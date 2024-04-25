% Sizes in comments are rows by cols
% This function simulates the matrix dot product of sin(log(matA + 2.7))' * log(cos(matA) + 1.7);

function result = calculate_split(inputMat, numWorkers)
    % Define sizes
    rowSize = size(inputMat, 1);
    resultSize = size(inputMat, 2);
    
    % Divide all the rows by the amount of workers available
    workerParts = rowSize / numWorkers;

    % Define all ends of ranges for workers
    workedRngEnd = ones(1, numWorkers + 1);
    for i = 1:numWorkers
        workedRngEnd(1, i+1) = workerParts * i;
    end

    % Use cell since matrix will stack multiple matrices on top of each other which is not good
    workerResults = {};

    % Parallel iterate over all workers to do calculations
    parfor i = 1:numWorkers
        % Get rows that belong to worker
        part = inputMat(workedRngEnd(i):workedRngEnd(i+1), :);
        % Get result from rows
        workerResults{i} = calculate(part);
    end

    % Allocate result matrix
    result = zeros(resultSize, resultSize);

    % Iterate over all workers to combine results
    for i = 1:numWorkers
        % Add all results together
        result = result + workerResults{i};
    end
end
