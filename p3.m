clear all
%this code is not efficient enough to run 500 variables
%run it with only 100 variables

rand_num = rand(100,100); %randomly generated matrix (n vectors)
tol = 1e-6;    %set the tolerance
max_iter = 300;  %set the maximum iteration

%backtracking parameter
alpha = 0.4;  
beta = 0.4; 

%initialization (denote x(0) by (0,0,...,0))
x = zeros(100,1);
k = [0:300];
f_k = [f(x, rand_num), 1:50];
i = 0;
grad_norm = sqrt(grad_fun(x, rand_num) * grad_fun(x, rand_num)');

%Newton's method with backtracking line search
while grad_norm>tol && i<=max_iter
    step = alpha;
    tmp_x = x - step * hess_fun(x, rand_num) \ (grad_fun(x, rand_num))';
    %backtracking line search
    while f(tmp_x, rand_num) > f(x, rand_num) 
        step = step * beta;
        tmp_x = x - step * hess_fun(x, rand_num) \ (grad_fun(x, rand_num))';
    end
    x = x - step * hess_fun(x, rand_num) \ (grad_fun(x, rand_num))';
    grad_norm = sqrt(grad_fun(x, rand_num) * grad_fun(x, rand_num)');
    fprintf('The %dth iteration completed\n', i);   %monitor the iteration
    i = i + 1;
    f_k(i+1) = f(x, rand_num);
end
fprintf('All iterations completed\n');
%consider the case that the function converges before reaching the maximum iteration
if i<max_iter
    for j=i+1:max_iter+1
        f_k(j) = f(x, rand_num);
    end
end

%visualization
%plot f(x(k)) versus k for k=0,1,2,...,50
plot(k, f_k, '.-k', 'MarkerSize', 15);
set(gca, 'FontSize', 15);
xlabel('k', 'FontSize', 15);
ylabel('f(x(k))', 'FontSize', 15);
fprintf('The minimum value of the function is %f.\n', f(x, rand_num)); 



