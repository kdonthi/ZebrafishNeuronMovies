function puttingItTogether(windowsize, spacing, deltaFoF, threshold, cell_per)
    %This function takes in a txn deltaFoF matrix, creates a matrix with a
    %sliding window average for a certain window of time and spacing
    %between the windows. Afterwards, we convert that matrix to a binary
    %matrix with neurons above a certain threshold value. Then we take the
    %cell_per matrix, which is a n x 1 cell array that contains the
    %perimeter coordinates for each neuron, and average each index to
    %create a nx1 vector with an estimate of each neuron's position.
    
    %After this we take the information about when a neuron fires above the
    %threshold in addition the X and Y coordinates to plot the firing over
    %time.
    
    windowavg = windowavgFofF(deltaFoF, windowsize, spacing);
    binarymatrix = binaryMat(windowavg, threshold);
    avgloc = meanCell(cell_per);
    visualization(avgloc(:,1), avgloc(:,2), binarymatrix, spacing);
end