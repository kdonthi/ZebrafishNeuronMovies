function shiftedMatrix = shiftmatrix(matrix, indices)
%This function creates a new matrix by shifting the
%neurons with their indices in the vector "indices" at the top of the
%matrix.
    newmatrix = matrix;
    matrixtoadd = matrix(indices, :);
    newmatrix(indices,:) = [];
    newmatrix = [matrixtoadd; newmatrix];
    shiftedMatrix = newmatrix;
end