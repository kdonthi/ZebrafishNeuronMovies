function subplotfunc (windowsize, spacing, threshold, freq)
%This function takes the amount of indexes each window is in "windowsize" 
%(time between each index is 1/7 of a second), index spacing between 
%windows in "spacing", the threshold for a neuron to be considered firing 
%in "threshold", and the frames per second/frequency in "freq". 
%"clusternum1" is the cluster you want to observe over the movie and 
%"clusternum2" is an optional argument - if specified you can see both 
%clusters in comparison with each other but if "clusternum2" is blank, you 
%will a randomly chosne group of neurons selected the same size as the the 
%first cluster.

load('A2-H2B-GCaMP6f-6dpf_MultiPlane_ALL_CELLS','cell_per');
load('A2-H2B-GCaMP6f-6dpf_MultiPlane_CLUSTERS','assembliesCells');
load('A2-H2B-GCaMP6f-6dpf_MultiPlane_RASTER','deltaFoF');

binarymatrix = binaryMat(deltaFoF, threshold);
windowmatrix = windowavgFofF(binarymatrix, windowsize, spacing);
avgloc = meanCell(cell_per);
windowmatrix = windowmatrix'; %making this neurons * time
Xvals = avgloc(:,1);
Yvals = avgloc(:,2);
cluster1vec = assembliesCells{1}';
cluster2vec = assembliesCells{2}';
cluster3vec = assembliesCells{3}';
cluster4vec = assembliesCells{4}';
cluster5vec = assembliesCells{5}';
cluster6vec = assembliesCells{6}';
cluster7vec = assembliesCells{7}';
cluster8vec = assembliesCells{8}';
cluster9vec = assembliesCells{9}';
cluster10vec = assembliesCells{10}';
cluster11vec = assembliesCells{11}';
cluster12vec = assembliesCells{12}';
clustersvec = {cluster1vec, cluster2vec, cluster3vec, cluster4vec, cluster5vec, ...
    cluster6vec, cluster7vec, cluster8vec, cluster9vec, cluster10vec, cluster11vec, ...
    cluster12vec};
figure
movietitle = "Subplots: Thresh: " + threshold + ", Win. Size: " + ...
windowsize + ", Spacing: " + spacing + ", " + freq + " Hz";

outputVideo = VideoWriter(movietitle, "MPEG-4");
outputVideo.Quality = 100;
outputVideo.FrameRate = freq; %not always accurate (i.e., 100 fps is fast but not 100 frames/second)
open(outputVideo)

fprintf("Size the figure as you want and hit space bar when ready.")
pause


for i = 1:size(windowmatrix, 2) %time is on columns
    indicesabovezero = windowmatrix(:,i) > 0;
    X = Xvals(indicesabovezero);
    Y = Yvals(indicesabovezero);
    Z = zeros(size(windowmatrix,1), 3);
    R = 0.5;
    G = 0;
    B = 0;
    currcluster = 0;
    for j = 1:size(clustersvec,2)
        currcluster = clustersvec{j};
        Zcopy = Z; %get a fresh copy every time
        Zcopy(currcluster, 1) = R;
        Zcopy(currcluster, 2) = G;
        Zcopy(currcluster, 3) = B;
        zeromat = sum(Zcopy,2) == 0;
        Zcopy(zeromat,1) = 0.8;
        Zcopy(zeromat,2) = 0.8;
        Zcopy(zeromat,3) = 0.8;
        subplot(4,3,j);
        scatter(X,Y,50,Zcopy(indicesabovezero, :));
        xlim([50 500]);
        ylim([50 500]);
        xlabel("X");
        ylabel("Y");
        title("Cluster # " + j);
%         if 1 > R > 0 %gives 12 colors
%             R = R + 0.1;
%         elseif R >= 1
%             R = 0;
%             G = 0.2;
%         elseif 1 > G > 0
%             G = G + 0.15;
%         elseif G >= 1
%             G = 0;
%             B = 0.2;
%         else
%             B = B + 0.2;
%         end
        if R == 0.5 %gives 3 colors
            G = 0.5;
            R = 0;
        elseif G == 0.5
            B = 0.5;
            G = 0;
        else
            R = 0.5;
            B = 0;
        end
    end
    %Z(cluster2vec, 1) = 0.2; %all of first cluster is red, second cluster is green
    sgtitle("Frame " + i + " of " + size(windowmatrix, 2));
    writeVideo(outputVideo, getframe(gcf));
end
    
    