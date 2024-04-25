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

part2a = true;
part2b = true;
part2c = true;
part2d = true;
part2e = true;
part2f1 = true;
part2f2 = true;
part2g1 = true;
part2g2 = true;

part4a = true;
part4b = true;
part4c = true;
part4d = true;
part4e = true;
part4f1 = true;
part4f2 = true;
part4g1 = true;
part4g2 = true;


global times;
times = zeros(1,20);
global norms;
norms = zeros(1,20);
global diffs;
diffs = zeros(1,20);

global cmp_result;

% Placed first since other tasks are compared to it
if part2b
    tasknum = 2;

    % Single thread
    MNCT = maxNumCompThreads(1);

    % Single thread
    tic;
    cmp_result = calculate(c7);
    time = toc;

    record_results(tasknum, time, cmp_result, 'Single thread', 'single_thread.csv');
end

if part2a
    tasknum = 1;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Default
    tic;
    result = calculate(c7);
    time = toc;

    record_results(tasknum, time, result, 'Default', 'default.csv');
end

if part2c
    tasknum = 3;

    % Single thread
    MNCT = maxNumCompThreads(1);

    % With forloop
    tic;
    result = calculate_for(c7);
    time = toc;

    record_results(tasknum, time, result, 'Single thread forloop', 'single_thread_forloop.csv');
end

if part2d
    tasknum = 4;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % With forloop
    tic;
    result = calculate_for(c7);
    time = toc;

    record_results(tasknum, time, result, 'Default forloop', 'default_forloop.csv');
end

if part2e
    tasknum = 5;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');
    
    % Start parallel pool
    p = startParpool();

    % Default parallel
    tic;
    result = calculate_parfor(c7);
    time = toc; 

    record_results(tasknum, time, result, 'Default parallel', 'default_parallel.csv');
end

if part2f1
    tasknum = 6;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = startParpool();

    % Parallel with even split and matrix multiplication
    tic
    result = calculate_split(c7, p.NumWorkers);
    time = toc; 

    record_results(tasknum, time, result, 'Even split parallel matrix', 'even_parallel_default.csv');
end

if part2f2
    tasknum = 7;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = startParpool();

    % Parallel with even split and matrix multiplication
    tic
    result = calculate_for_split(c7, p.NumWorkers);
    time = toc; 

    record_results(tasknum, time, result, 'Even split parallel for', 'even_parallel_for.csv');
end

if part2g1
    tasknum = 8;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = startParpool();

    % Parallel with even split and matrix multiplication
    tic
    result = calculate_split_distributed(c7);
    time = toc; 

    record_results(tasknum, time, result, 'Distributed even split parallel matrix', 'distributed_even_parallel_default.csv');
end

if part2g2
    tasknum = 9;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = startParpool();

    % Parallel with even split and matrix multiplication
    tic
    result = calculate_for_split_distributed(c7);
    time = toc; 

    record_results(tasknum, time, result, 'Distributed even split parallel for', 'distributed_even_parallel_for.csv');
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

    record_results(tasknum, time, cmp_result, 'Reverse single thread', 'reverse_single_thread.csv');
end

if part4a
    tasknum = 10;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Default
    tic;
    result = reverse_calculate(c7);
    time = toc;

    record_results(tasknum, time, result, 'Reverse default', 'reverse_default.csv');
end

if part4c
    tasknum = 12;

    % Single thread
    MNCT = maxNumCompThreads(1);

    % With forloop
    tic;
    result = reverse_calculate_for(c7);
    time = toc;

    record_results(tasknum, time, result, 'Reverse single thread forloop', 'reverse_single_thread_forloop.csv');
end

if part4d
    tasknum = 13;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % With forloop
    tic;
    result = reverse_calculate_for(c7);
    time = toc;

    record_results(tasknum, time, result, 'Reverse default forloop', 'reverse_default_forloop.csv');
end

if part4e
    tasknum = 14;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    
    p = startParpool();

    % Default parallel
    tic;
    result = reverse_calculate_parfor(c7);
    time = toc;

    record_results(tasknum, time, result, 'Reverse default parallel', 'reverse_default_parallel.csv');
end


if part4f1
    tasknum = 15;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = startParpool();

    % Parallel with even split and matrix multiplication
    tic
    result = reverse_calculate_parfor_split(c7, p.NumWorkers);
    time = toc; 

    record_results(tasknum, time, result, 'Reverse even split parallel matrix', 'reverse_even_parallel_default.csv');
end

if part4f2
    tasknum = 16;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool    
    p = startParpool();

    % Parallel with even split and matrix multiplication
    tic
    result = reverse_calculate_for_split(c7, p.NumWorkers);
    time = toc; 

    record_results(tasknum, time, result, 'Reverse even split parallel for', 'reverse_even_parallel_for.csv');
end

if part4g1
    tasknum = 17;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = startParpool();

    % Parallel with even split and matrix multiplication
    tic
    result = reverse_calculate_split_distributed(c7);
    time = toc; 

    record_results(tasknum, time, result, 'Reverse even split parallel matrix', 'reverse_even_parallel_default.csv');
end

if part4g2
    tasknum = 18;

    % Detect threads
    MNCT = maxNumCompThreads('automatic');

    % Start parallel pool
    p = startParpool();

    % Parallel with even split and matrix multiplication
    tic
    result = reverse_calculate_for_split_distributed(c7);
    time = toc; 

    record_results(tasknum, time, result, 'Reverse even split parallel for', 'reverse_even_parallel_for.csv');
end

% Save all the remaining recorded data
csvwrite('data/times.csv', times);
csvwrite('data/norms.csv', norms);
csvwrite('data/diffs.csv', diffs);

% Function definitions
function record_results(tasknum, time, result, printlabel, filename)
    global times;
    global norms;
    global diffs;
    global cmp_result;

    fprintf('[%s] Time: %.12f\n', printlabel, time);
    filepath = sprintf('data/%s', filename);
    csvwrite(filepath, result);

    if cmp_result == 0
        cmp_result = result;
    end

    % Save results
    times(tasknum) = time;
    norms(tasknum) = norm(cmp_result);
    diffs(tasknum) = norm(cmp_result);
end

function p = startParpool()
    p = gcp('nocreate');

    if isempty(p)
        parpool;
        p = gcp('nocreate');
    end
end