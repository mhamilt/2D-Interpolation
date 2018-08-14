% A quick example of Lagrange in 2D
Z = zeros(6); Z(3,4) = 1; Z(4,3) = 1; Z([1 6],[1 6]) = 1;
hiResSize = [100, 100];

ax1 = subplot(1,2,1)
surf(Z);
title(['\fontsize{18}Input'])
caxis([-.5 1])
ax2 = subplot(1,2,2)
surf(interp2D(Z,hiResSize,4,50));
title(['\fontsize{18}Interpolated'])
