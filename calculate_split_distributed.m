% Sizes in comments are rows by cols
% This function simulates the matrix dot product of sin(log(matA + 2.7))' * log(cos(matA) + 1.7);

function result = calculate_split(inputMat, numWorkers)
    % Define sizes
    resultSize = size(inputMat, 2);
    
    inputMatPart = distributed(inputMat)

    % Use cell since matrix will stack multiple matrices on top of each other which is not good
    workerResults = {};

    % Parallel iterate over all workers to do calculations
    parfor i = 1:numWorkers
        % Get result from rows
        workerResults{i} = calculate(inputMatPart);
    end

    % Allocate result matrix
    result = zeros(resultSize, resultSize);

    % Iterate over all workers to combine results
    for i = 1:numWorkers
        % Add all results together
        result = result + workerResults{i};
    end
end
