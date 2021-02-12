function movie (windowsize, spacing, threshold, freq, clusternum1, clusternum2)
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
cluster1vec = assembliesCells{clusternum1}';
figure
if nargin == 6
    movietitle = clusternum1 + " is RED and " + clusternum2 + " is GREEN";
    cluster2vec = assembliesCells{clusternum2}';
else
    movietitle = clusternum1 + " is RED and Random is GREEN";
    randomlyorderedneurons = randperm(size(windowmatrix,1))';
    cluster2vec = randomlyorderedneurons(1:size(cluster1vec,1));
end
movietitle = movietitle + "  Thresh: " + threshold + ", Win. Size: " + ...
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
    Z(cluster1vec, 1) = 255; 
    Z(cluster2vec, 2) = 255; %all of first cluster is red, second cluster is green
    Z = Z(indicesabovezero,:);
    rowsum = sum(Z,2);
    intersection = rowsum == 510;
    zeromat = rowsum == 0;
    for j = 1:size(intersection)
        if intersection(j) ~= 0
            Z(j,:) = [0, 0, 255]; %all the values at the intersection are purple
        end
    end
    for k = 1:size(zeromat)
        if zeromat(k) ~= 0
            Z(k,:) = [255,255,255]; %making all the ones that we are not looking are white
        end
    end 
    
    
    scatter(X, Y, 10, Z);
    xlim([50 500]);
    ylim([50 500]);
    xlabel("X");
    ylabel("Y");
    title(movietitle + "     Frame " + i + " of " + size(windowmatrix, 2));
    writeVideo(outputVideo, getframe(gcf));
end
    
    