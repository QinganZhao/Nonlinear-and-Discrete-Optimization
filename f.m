%this function is to calculate the function in problem 3
function [fun] = f(x, a)
%x is the input vector, a is the random matrix generated in the main script
fun = 0;
for i=1:100
    fun = fun + log10(2-x(i)^2) + log10(1 - 2 * (a(:,i))' * x);
end
fun = -fun;
