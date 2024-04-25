reduction = 0.1;

n = 1000 * reduction;

rows = 5000 * reduction;
extra_rows = 5070 * reduction;

% This creates a matrix with the dimensions of cols * 4 + large_cols by n (25070 * 1000)
c7 = [
    0.1 * ones(rows, n); 
    0.2 * ones(rows, n); 
    0.3 * ones(rows, n); 
    0.4 * ones(rows, n); 
    0.3 * ones(extra_rows, n);
];

part2a = false;
part2b = false;
part2c = false;
part2d = false;
part2e = false;
part2f1 = false;
part2f2 = false;
part2g1 = false;
part2g2 = false;

part4a = true;
part4b = false;
part4c = true;
part4d = false;
part4e = false;
part4f1 = false;
part4f2 = false;
part4g1 = false;
part4g2 = false;


times = zeros(1,20);
norms = zeros(1,20);
diffs = zeros(1,20);

% Placed first since other tasks are compared to it
if part2b
    tasknum = 2;

    % Single thread
    MNCT = maxNumCompThreads(1);

    % Single thread
    tic;
    cmp_result = calculate(c7);
    time = toc;
    fprintf('[Single thread] Time: %.12f\n', time);
    csvwrite('data/single_thread.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(cmp_result);
    diffs(tasknum) = diff(cmp_result);
end

if part2a
    tasknum = 1;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Default
    tic;
    result = calculate(c7);
    time = toc;
    fprintf('[Default] Time: %.12f\n', time);
    csvwrite('data/default.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end

if part2c
    tasknum = 3;

    % Single thread
    MNCT = maxNumCompThreads(1);

    % With forloop
    tic;
    result = calculate_for(c7);
    time = toc;
    fprintf('[Single thread forloop] Time: %.12f\n', time);
    csvwrite('data/single_thread_forloop.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end

if part2d
    tasknum = 4;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % With forloop
    tic;
    result = calculate_for(c7);
    time = toc;
    fprintf('[Default forloop] Time: %.12f\n', time);
    csvwrite('data/default_forloop.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end

if part2e
    tasknum = 5;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');
    
    % Start parallel pool
    p = gcp('nocreate');

    if isempty(p)
        parpool;
        p = gcp('nocreate');
    end

    % Default parallel
    tic;
    result = calculate_parfor(c7);
    time = toc; 
    fprintf('[Default parallel] Time: %.12f\n', time);
    csvwrite('data/default_parallel.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end

if part2f1
    tasknum = 6;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = gcp('nocreate');

    if isempty(p)
        parpool;
        p = gcp('nocreate');
    end

    % Parallel with even split and matrix multiplication
    tic
    result = calculate_split(c7, p.NumWorkers);
    time = toc; 
    fprintf('[Even split parallel matrix] Time: %.12f\n', time);
    csvwrite('data/even_parallel_default.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end

if part2f2
    tasknum = 7;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = gcp('nocreate');

    if isempty(p)
        parpool;
        p = gcp('nocreate');
    end

    % Parallel with even split and matrix multiplication
    tic
    result = calculate_for_split(c7, p.NumWorkers);
    time = toc; 
    fprintf('[Even split parallel for] Time: %.12f\n', time);
    csvwrite('data/even_parallel_for.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end

if part2g1
    tasknum = 8;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = gcp('nocreate');

    if isempty(p)
        parpool;
        p = gcp('nocreate');
    end

    % Parallel with even split and matrix multiplication
    tic
    result = calculate_split_distributed(c7, p.NumWorkers);
    time = toc; 
    fprintf('[Even split parallel matrix] Time: %.12f\n', time);
    csvwrite('data/even_parallel_default.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end

if part2g2
    tasknum = 9;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = gcp('nocreate');

    if isempty(p)
        parpool;
        p = gcp('nocreate');
    end

    % Parallel with even split and matrix multiplication
    tic
    result = calculate_for_split_distributed(c7, p.NumWorkers);
    time = toc; 
    fprintf('[Even split parallel for] Time: %.12f\n', time);
    csvwrite('data/even_parallel_for.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end

% Reverse and with shorter data
c7 = c7(:, 1:50);

% Placed first since other tasks are compared to it
if part4b
    tasknum = 11;

    % Single thread
    MNCT = maxNumCompThreads(1);

    % Single thread
    tic;
    cmp_result = reverse_calculate(c7);
    time = toc;
    fprintf('[Reverse single thread] Time: %.12f\n', time);
    csvwrite('data/reverse_single_thread.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end

if part4a
    tasknum = 10;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Default
    tic;
    result = reverse_calculate(c7);
    time = toc;
    fprintf('[Reverse default] Time: %.12f\n', time);
    csvwrite('data/reverse_default.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end

if part4c
    tasknum = 12;

    % Single thread
    MNCT = maxNumCompThreads(1);

    % With forloop
    tic;
    result = reverse_calculate_for(c7);
    time = toc;
    fprintf('[Reverse single thread forloop] Time: %.12f\n', time);
    csvwrite('data/reverse_single_thread_forloop.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end

if part4d
    tasknum = 13;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % With forloop
    tic;
    result = reverse_calculate_for(c7);
    time = toc;
    fprintf('[Reverse default forloop] Time: %.12f\n', time);
    csvwrite('data/reverse_default_forloop.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end

if part4e
    tasknum = 14;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = gcp('nocreate');

    if isempty(p)
        parpool;
        p = gcp('nocreate');
    end

    % Default parallel
    tic;
    result = reverse_calculate_parfor(c7);
    time = toc;
    fprintf('[Reverse default parallel] Time: %.12f\n', time);
    csvwrite('data/reverse_default_parallel.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end


if part4f1
    tasknum = 15;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = gcp('nocreate');

    if isempty(p)
        parpool;
        p = gcp('nocreate');
    end

    % Parallel with even split and matrix multiplication
    tic
    result = reverse_calculate_parfor_split(c7, p.NumWorkers);
    time = toc; 
    fprintf('[Reverse even split parallel matrix] Time: %.12f\n', time);
    csvwrite('data/reverse_even_parallel_default.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end

if part4f2
    tasknum = 16;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = gcp('nocreate');

    if isempty(p)
        parpool;
        p = gcp('nocreate');
    end

    % Parallel with even split and matrix multiplication
    tic
    result = reverse_calculate_for_split(c7, p.NumWorkers);
    time = toc; 
    fprintf('[Reverse even split parallel for] Time: %.12f\n', time);
    csvwrite('data/reverse_even_parallel_for.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end

if part2g1
    tasknum = 17;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = gcp('nocreate');

    if isempty(p)
        parpool;
        p = gcp('nocreate');
    end

    % Parallel with even split and matrix multiplication
    tic
    result = reverse_calculate_split_distributed(c7, p.NumWorkers);
    time = toc; 
    fprintf('[Even split parallel matrix] Time: %.12f\n', time);
    csvwrite('data/even_parallel_default.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end

if part2g2
    tasknum = 18;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = gcp('nocreate');

    if isempty(p)
        parpool;
        p = gcp('nocreate');
    end

    % Parallel with even split and matrix multiplication
    tic
    result = reverse_calculate_for_split_distributed(c7, p.NumWorkers);
    time = toc; 
    fprintf('[Even split parallel for] Time: %.12f\n', time);
    csvwrite('data/even_parallel_for.csv', result);

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(result);
    diffs(tasknum) = diff(result - cmp_result);
end
