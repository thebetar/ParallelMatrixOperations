function result = calculate_for_split_distributed(inputMat)
    % Split the input matrix over workers using the distributed function
    inputMatPart = distributed(inputMat);

    % Parallel iterate over all workers to do calculations
    spmd
        % Get result from rows
        workerResults = calculate_for(inputMatPart);
    end

    result = gather(workerResults);
end
