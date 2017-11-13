%this function is to calculate hessian of the function in problem 3
function [hess] = hess_fun(x, a)
%x is the input vector, a is the random matrix generated in the main script

%divide the hessian matrix into two parts for convenience
hess_1 = zeros(100);
hess_2 = zeros(100);

for i=1:100
    hess_1(i,i) = 4 + 2 * x(i)^2 / (log(10) * (2 - x(i)^2)^2);
end

for i=1:100
    for j=1:100
        for k=1:100
            hess_2(i,j) = hess_2(i,j) + 2 * a(i,k) * 2 * a(j,k) / (log(10) * (1 - 2 * (a(:,k))' * x)^2);
        end
    end
end
hess = hess_1 + hess_2;

    