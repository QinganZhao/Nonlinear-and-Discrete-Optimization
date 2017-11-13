%this function is to calculate gradient of the function in problem 3
function [grad] = grad_fun(x, a)

grad = zeros(1,100);
%x is the input vector, a is the random matrix generated in the main script
for i=1:100
    tmp = 0;
    for k=1:100
        tmp = tmp + 2 * a(i,k) / (log(10) * (1 - 2 * (a(:,k))' * x));
    end
    grad(i) = 2 * x(i) / (log(10) * (2-x(i)^2)) + tmp;
end