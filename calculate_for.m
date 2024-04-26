% Sizes in comments are rows by cols
% This function simulates the matrix dot product of sin(log(matA + 2.7))' * log(cos(matA) + 1.7);

function result = calculate_for(inputMat)
    % Preset a matrix with zeroes so memory is only allocated once
    result_size = size(inputMat, 2);
    tempResult = zeros(result_size, result_size);
    
    for i = 1:result_size
        for j = 1:result_size
            iterResult = 0;

            % Calculate for each cell in the matrix
            for k = 1:size(inputMat, 1)
                integerA = inputMat(k, i);
                integerB = inputMat(k, j);

                % Get result of the dot product of items
                iterResult = iterResult + (sin(log(integerA + 2.7)) * log(cos(integerB) + 1.7));
            end

            tempResult(i, j) = iterResult;
        end
    end

    result = tempResult;
end
