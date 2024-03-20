function X = my_dft(x)
  % Calculate the DFT of the input sequence x
  N = length(x);
  n = 0:N-1;
  X = zeros(1, N);
  for k = 0:N-1
    X(k+1) = sum(x .* exp(-i*2*pi*k*(0:N-1)/N));
  end

  % Remove negative values close to zero using tolerance
  
  % Define the tolerance 
  tol = 1e-15;  % I used this value through trial and error because using 'eps' didn't work.

  % Set values close to zero to zero
  X(abs(imag(X)) < tol) = real(X(abs(imag(X)) < tol)) + 0i;
  X(abs(real(X)) < tol) = 0 + imag(X(abs(real(X)) < tol));

  
  magnitude = abs(X);
  phase = angle(X);
  stem(n, magnitude)
  hold on
  stem(n, phase)
  legend({"magnitude", "phase"})
end
