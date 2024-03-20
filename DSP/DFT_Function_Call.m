clc
close all
clear all

% Enter the the sequence as an array for ex. [1 1 0 0] or any size
input_sequence = input("Enter the sequence = ");

% Calculate the DFT using my_dft function
output = my_dft(input_sequence);

% Display the result
disp(output);