% Sizes in comments are rows by cols
% This function simulates the matrix dot product of sin(log(matA + 2.7))' * log(cos(matA) + 1.7);

function result = reverse_calculate_split_distributed(inputMat)
    % Split the input matrix over workers using the distributed function
    inputMatPart = distributed(inputMat);

    % Parallel iterate over all workers to do calculations
    spmd
        % Get result from rows
        workerResults = reverse_calculate(inputMatPart);
    end

    result = gather(workerResults);
end
