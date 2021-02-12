function meanCellMatrix = meanCell(Matrix)
    %This function takes in a n x 1 cell array and outputs a n x 1 cell matrix
    %containing the avg x and y coordinates for each neuron (does "each ROI" mean "each cell"?)

    numbneurons = size(Matrix, 1);
    newmatrix = zeros(numbneurons,2); %matrix for avg x and y cooordinates

    for i = 1:numbneurons
        newmatrix(i,:) = mean(Matrix{i,1});
    end
    meanCellMatrix = newmatrix;
end
