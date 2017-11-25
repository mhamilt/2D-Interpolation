% A quick example of Lagrange in 2D
Z = zeros(6); Z(3,4) = 1; Z(4,3) = 1; Z([1 6],[1 6]) = 1;
hiResSize = [100, 100];

subplot(2,1,1)
surf(Z);
subplot(2,1,2)
surf(interp2D(Z,hiResSize,4,50));
