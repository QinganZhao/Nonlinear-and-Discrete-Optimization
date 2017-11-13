clear all

syms x1 x2; 
tol = 1e-6;    %set the tolerance
max_iter = 50;  %set the maximum iteration

%backtracking parameter
alpha = 1;  
beta = 0.6; 

%create the function f(x) and its gradient and hessian
func = exp(x1-x2-0.4)+exp(x1+x2-0.4)+(x1-1)^2+(x2+1)^2;
func_grad = (gradient(func))';
func_hess = (hessian(func));
f = inline(func, 'x1', 'x2');
grad = inline(func_grad, 'x1', 'x2');  
hess = inline(func_hess, 'x1', 'x2'); 

%initialization (denote x(0) by (0,0))
x = [0; 0];
k = [0:50];
x1_k = [0:50];
x2_k = [0:50];
f_k = [f(0,0), 1:50];
i = 0;
grad_norm = sqrt(grad(x(1), x(2)) * grad(x(1), x(2))');

%Newton's method with backtracking line search
while grad_norm>tol && i<=max_iter
    step = alpha;
    tmp_x = x - step * hess(x(1), x(2)) \ (grad(x(1), x(2)))';
    %backtracking line search
    while f(tmp_x(1), tmp_x(2)) > f(x(1), x(2))
        step = step * beta;
        tmp_x = x - step * hess(x(1), x(2)) \ (grad(x(1), x(2)))';
    end
    x = x - step * hess(x(1), x(2)) \ (grad(x(1), x(2)))';
    grad_norm = sqrt(grad(x(1), x(2)) * grad(x(1), x(2))');
    i = i + 1;
    x1_k(i+1) = x(1);
    x2_k(i+1) = x(2);
    f_k(i+1) = f(x(1), x(2));
end

%consider the case that the function converges before reaching the maximum iteration
if i<max_iter
    for j=i+1:max_iter+1
        x1_k(j) = x1_k(i);
        x2_k(j) = x2_k(i);
        f_k(j) = f(x(1), x(2));
    end
end

%visualization
%plot f(x(k)) versus k for k=0,1,2,...,50
plot(k, f_k, '.-k', 'MarkerSize', 15);
set(gca, 'FontSize', 15);
xlabel('k', 'FontSize', 15);
ylabel('f(x(k))', 'FontSize', 15);
%plot the trajectory of points x(0), x(1), ..., x(50)
figure;
plot(x1_k, x2_k, '.-k', 'MarkerSize', 15);
set(gca, 'FontSize', 15);
xlabel('x1', 'FontSize', 15);
ylabel('x2', 'FontSize', 15);
fprintf('The minimum value of the function is %f, where x=(%f, %f).\n', f(x(1), x(2)), x(1), x(2)); 

