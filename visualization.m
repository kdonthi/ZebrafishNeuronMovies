function [x, y, time] = visualization(X, Y, windowmatrix, spacing)
    %This function creates a scatter plot of the firing of X and Y coordinates over time.

    %A point at a x,y, and time coordinate means that a neuron at that location
    %fired above the threshold value.

    %The function takes in a nx1 X matrix for the X coordinates of each neuron,
    %a nx1 Y matrix for the Y coordinates of each neuron (indices should match
    %X matrix) and a txn binarymatrix that contains information about whether a
    %neuron fires above a threshold value for each time.

    if size(X,1) ~= size(Y,1) || size(Y,1) ~= size(windowmatrix,2)
        disp("something wrong")
    end
    numbneurons = size(X,1);
    xgraph = [];
    ygraph = [];
    timegraph = []; 
    binarymatrix = windowmatrix > 0;
    binarymatrix(3, 1:10)
    newbinary = ((1/7)*spacing*([1:size(binarymatrix,1)] - 1))'.* binarymatrix; %starting time at 0 
    %by subtracting vector by 1, creating increments of 1/7 seconds, and
    %accounting for adjusted time difference from spacing and newbinary is
    %time at point at firing
    for i = 1:numbneurons
        newmatrix = zeros(sum(binarymatrix(:,i),1),3); %creating new matrix for number of "active" neurons to add onto xgraph, ygraph, and timegraph
        newmatrix(:,1) = X(i);
        newmatrix(:,2) = Y(i);
        newmatrix(:,3) = newbinary(binarymatrix(:,i) ~= 0, i); %indexing time values of newbinary for values with firing above threshold 
        xgraph = [xgraph; newmatrix(:,1)];
        ygraph = [ygraph; newmatrix(:,2)];
        timegraph = [timegraph; newmatrix(:,3)];
    end
    disp(size(windowmatrix,2) * size(windowmatrix,1) - size(xgraph,1));
    disp(size(windowmatrix,2) * size(windowmatrix,1));
    scatter3(xgraph, ygraph, timegraph);
    hold on;
    xlabel("X");
    ylabel("Y");
    zlabel("Time");
    x = xgraph;
    y = ygraph;
    time = timegraph;
    hold off;
end
