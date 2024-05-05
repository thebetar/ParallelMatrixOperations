reduction = 0.5;

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
% Disabled since it gets stuck forever
part2g2 = false;

part4a = true;
part4b = true;
part4c = false;
part4d = false;
part4e = false;
part4f1 = false;
part4f2 = false;
part4g1 = true;
% Disabled since it gets stuck forever
part4g2 = false;

global times;
times = zeros(1,20);
global norms;
norms = zeros(1,20);
global diffs;
diffs = zeros(1,20);

global cmp_result;

MNCT = maxNumCompThreads('automatic');

% Placed first since other tasks are compared to it
if part2b
    tasknum = 2;

    % Single thread
    maxNumCompThreads(1);

    % Single thread
    tic;
    cmp_result = calculate(c7);
    time = toc;

    record_results(tasknum, time, cmp_result, 'Single thread', 'single_thread.csv');
end

if part2a
    tasknum = 1;

    % Detect threads
    maxNumCompThreads(MNCT);

    % Default
    tic;
    result = calculate(c7);
    time = toc;

    record_results(tasknum, time, result, 'Default', 'default.csv');
end

if part2c
    tasknum = 3;

    % Single thread
    maxNumCompThreads(1);

    % With forloop
    tic;
    result = calculate_for(c7);
    time = toc;

    record_results(tasknum, time, result, 'Single thread forloop', 'single_thread_forloop.csv');
end

if part2d
    tasknum = 4;

    % Detect threads
    maxNumCompThreads(MNCT);

    % With forloop
    tic;
    result = calculate_for(c7);
    time = toc;

    record_results(tasknum, time, result, 'Default forloop', 'default_forloop.csv');
end

if part2e
    tasknum = 5;

    % Detect threads
    maxNumCompThreads(MNCT);
    
    % Start parallel pool
    startParpool();

    % Default parallel
    tic;
    result = calculate_parfor(c7);
    time = toc; 

    record_results(tasknum, time, result, 'Default parallel', 'default_parallel.csv');
end

if part2f1
    tasknum = 6;

    % Detect threads
    maxNumCompThreads(MNCT);

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
    maxNumCompThreads(MNCT);

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
    maxNumCompThreads(MNCT);

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
    maxNumCompThreads(MNCT);

    % Start parallel pool
    p = startParpool();

    % Parallel with even split and matrix multiplication
    tic
    result = calculate_for_split_distributed(c7);
    time = toc; 

    record_results(tasknum, time, result, 'Distributed even split parallel for', 'distributed_even_parallel_for.csv');
end

% Reverse and with shorter data
% Bigger than 15.000 rows kills my matlab process so it cannot run
c7 = c7(:, 1:50);

% Placed first since other tasks are compared to it
if part4b
    tasknum = 11;

    % Single thread
    maxNumCompThreads(1);

    % Single thread
    tic;
    cmp_result = reverse_calculate(c7);
    time = toc;

    record_results(tasknum, time, cmp_result, 'Reverse single thread', 'reverse_single_thread.csv');
end

if part4a
    tasknum = 10;

    % Detect threads
    maxNumCompThreads(MNCT);

    % Default
    tic;
    result = reverse_calculate(c7);
    time = toc;

    record_results(tasknum, time, result, 'Reverse default', 'reverse_default.csv');
end

if part4c
    tasknum = 12;

    % Single thread
    maxNumCompThreads(1);

    % With forloop
    tic;
    result = reverse_calculate_for(c7);
    time = toc;

    record_results(tasknum, time, result, 'Reverse single thread forloop', 'reverse_single_thread_forloop.csv');
end

if part4d
    tasknum = 13;

    % Detect threads
    maxNumCompThreads(MNCT);

    % With forloop
    tic;
    result = reverse_calculate_for(c7);
    time = toc;

    record_results(tasknum, time, result, 'Reverse default forloop', 'reverse_default_forloop.csv');
end

if part4e
    tasknum = 14;

    % Detect threads
    maxNumCompThreads(MNCT);

    % Start parallel pool
    
    startParpool();

    % Default parallel
    tic;
    result = reverse_calculate_parfor(c7);
    time = toc;

    record_results(tasknum, time, result, 'Reverse default parallel', 'reverse_default_parallel.csv');
end


if part4f1
    tasknum = 15;

    % Detect threads
    maxNumCompThreads(MNCT);

    % Start parallel pool
    p = startParpool();

    % Parallel with even split and matrix multiplication
    tic
    result = reverse_calculate_split(c7, p.NumWorkers);
    time = toc; 

    record_results(tasknum, time, result, 'Reverse even split parallel matrix', 'reverse_even_parallel_default.csv');
end

if part4f2
    tasknum = 16;

    % Detect threads
    maxNumCompThreads(MNCT);

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
    maxNumCompThreads(MNCT);

    % Start parallel pool
    p = startParpool();

    % Parallel with even split and matrix multiplication
    tic
    result = reverse_calculate_split_distributed(c7);
    time = toc; 

    record_results(tasknum, time, result, 'Reverse distributed even split parallel matrix', 'reverse_distributed_even_parallel_default');
end

if part4g2
    tasknum = 18;

    % Detect threads
    maxNumCompThreads(MNCT);

    % Start parallel pool
    p = startParpool();

    % Parallel with even split and matrix multiplication
    tic
    result = reverse_calculate_for_split_distributed(c7);
    time = toc; 

    record_results(tasknum, time, result, 'Reverse distributed even split parallel for', 'reverse_distributed_even_parallel_for.csv');
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

    if cmp_result == 0
        cmp_result = result;
    end

    % Truncate the result to 1000x1000 or it gets stuck forever because memory problem
    if(size(cmp_result, 1) > 1000)
        cmp_result = cmp_result(1:1000, 1:1000);
    end

    % Truncate the result to 1000x1000 or it gets stuck forever because memory problem
    if(size(result, 1) > 1000)
        result = result(1:1000, 1:1000);
    end

    normVal = norm(result);
    diffVal = norm(cmp_result - result);    

    fprintf('[%s] Time: %.12f\n', printlabel, time);
    fprintf('[%s] Norm: %.12f\n', printlabel, normVal);
    fprintf('[%s] Diff: %.12f\n', printlabel, diffVal);
    % filepath = sprintf('data/%s', filename);
    % csvwrite(filepath, result(100, 100));

    % Save results
    times(tasknum) = time;
    norms(tasknum) = normVal;
    diffs(tasknum) = diffVal;
end

function p = startParpool()
    p = gcp('nocreate');

    if isempty(p)
        parpool;
        p = gcp('nocreate');
    end
end