function result = calculate_parfor_optim(inputMat)
    % 25070 by 1000
    matA = sin(log(inputMat + 2.7))';
    % 25070 by 1000
    matB = log(cos(inputMat) + 1.7)';

    % Preset a matrix with zeroes so memory is only allocated once
    result = zeros(size(matA, 1), size(matB, 1));

    % Flatten the result matrix into a vector
    result_vector = reshape(result, [1, size(result, 1) * size(result, 2)]);

    % Iterate over the result vector
    parfor n = 1:size(result_vector, 2)
        % Get row index by dividing n by the number of columns
        i = ceil(n / size(result, 2));
        % Get column index by getting the remainder of n divided by the number of columns
        j = mod(n - 1, size(result, 2)) + 1;

        % 1 by 25070
        vectorA = matA(i, :);
        % 1 by 25070
        vectorB = matB(j, :);

        iterResult = 0;

        % Calculate for each cell in the matrix
        for k = 1:size(vectorA, 2)
            % Get result of the dot product of items
            iterResult = iterResult + vectorA(k) * vectorB(k);
        end

        result_vector(n) = iterResult;
    end

    % Reshape the result vector back into a matrix
    result = reshape(result_vector, size(result));
end

