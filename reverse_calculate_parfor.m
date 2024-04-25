% Sizes in comments are rows by cols
% This function simulates the matrix dot product of sin(log(matA + 2.7))' * log(cos(matA) + 1.7);

function result = reverse_calculate_parfor(inputMat)
    % Preset a matrix with zeroes so memory is only allocated once
    result_size = size(inputMat, 1);
    tempResult = zeros(result_size, result_size);

    parfor i = 1:result_size
        % Since in a parfor loop only the iterator can be used to access store values in vector
        iterVec = zeros(result_size, 1);

        for j = 1:result_size
            iterResult = 0

            % Calculate for each cell in the matrix
            for k = 1:size(inputMat, 2)
                integerA = inputMat(i, k);
                integerB = inputMat(j, k);

                % Get result of the dot product of items
                iterResult = iterResult + (sin(log(integerA + 2.7)) * log(cos(integerB) + 1.7));
            end

            iterVec(j) = iterResult;
        end

        % Save vector to row
        tempResult(i, :) = iterVec;
    end

    result = tempResult;
end
