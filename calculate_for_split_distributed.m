% Sizes in comments are rows by cols
% This function simulates the matrix dot product of sin(log(matA + 2.7))' * log(cos(matA) + 1.7);

function result = calculate_for_split_distributed(inputMat)
    % Define sizes
    resultSize = size(inputMat, 2);
    
    inputMatPart = distributed(inputMat);

    % Allocate result matrix
    workerResults = zeros(resultSize, resultSize);

    % Parallel iterate over all workers to do calculations
    spmd
        % Get result from rows
        workerResults = calculate_for(inputMatPart);
    end

    result = gather(workerResults);
end
