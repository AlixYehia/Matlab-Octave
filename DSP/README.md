# in my_dft.m

1. **abs(real(X)) < tol:** This part calculates the absolute values of the real parts of all elements in X (real(X)), and then checks if these absolute values are less than the tolerance tol. This condition creates a logical array of the same size as X, where each element is true if the corresponding element in X has a real part with an absolute value less than tol, and false otherwise.

2. **abs(imag(X)) < tol:** Similarly, this part calculates the absolute values of the imaginary parts of all elements in X (imag(X)), and checks if these absolute values are less than tol. This creates another logical array with the same size as X, but now the elements are true if the corresponding element in X has an imaginary part with an absolute value less than tol, and false otherwise.

3. I encountered an error in the phase plot due to MATLAB's approximation for very small floating-point values. To address this problem, I checked the workspace for the exact calculated values and found a solution. Adding the following code after the for loop sets the small values to exact zeroes and fixes the negative zero values for both real and imaginary parts:

```
% Remove negative values close to zero using tolerance

% Define the tolerance

tol = 1e-15; % I used this value through trial and error because using 'eps' didn't work.

% Set values close to zero to zero

X(abs(imag(X)) < tol) = real(X(abs(imag(X)) < tol)) + 0i;

X(abs(real(X)) < tol) = 0 + imag(X(abs(real(X)) < tol));
```
