function rel_per_accu()
% Author: Raymart Jay Canoy
% Date: 09 September 2020
true_value = input('True value = ');
num_value = input('Numerical value = ');

eps = (abs(true_value - num_value)/abs(true_value))*100;
fprintf('\n')
fprintf('Relative percent error is %.20f%%\n', eps)
fprintf('\n')
end