function windowavg = windowavgfofF(FofFmatrix, windowsize, spacing)
%This function takes in a t x n matrix of FofF values, with its rows as each
%timestamp and its columns as each neuron, and returns a new matrix with
%averages of FofF values for a sliding window with neurons "windowsize" and
%having "spacing" more neurons until the first neuron of the next window as
%rows and neurons as columns.

    timestamps = size(FofFmatrix, 1);
    numbneurons = size(FofFmatrix, 2);
    newmatrixrownum = floor((timestamps - (windowsize - 1) + (spacing - 1)) / spacing); % removing last (windowsize - 1) neurons not in use, because these neurons cannot start a window of size (neurons) 
    %and adding (spacing - 1) to adjusted timestamps allows us to move the first index to the number for spacing and allows us to divide to get the total number of rows
    newmatrix = zeros(newmatrixrownum, numbneurons); 
    
    i = 1; %iterating through original matrix
    rownum = 1; %iterating through window matrix
    while (rownum <= newmatrixrownum)
        newmatrix(rownum,:) = (sum(FofFmatrix(i:i+(windowsize - 1), :), 1));
        rownum = rownum + 1;
        i = i + spacing;
    end
    windowavg = newmatrix / windowsize; %doing average all at once
end
