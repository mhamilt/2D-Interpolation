function hiResMat = interp2D(loResMat,hiResSize,interpOrder,interpRes)
  % INTERP2D: output a higher resolution matrix using Lagrange interpolation
  % from a lower resolution matrix.
  %
  %   hiResMat = interp2D(loResMat,hiResSize,order,alphaRes) returns the
  %      matrix hiResMat, of a size hiResSize from a matrix loResMat.
  %
  %     hiResSize is a 2 element array [rows, columns] which must be larger
  %     than size(loResMat). The order of interpolation 'interpOrder' and
  %     the number of interpoint values 'interpRes'
  %
  %     Example
  %       Z = zeros(6); Z(3,4) = 1; Z(4,3) = 1; Z([1 6],[1 6]) = 1;
  %       hiResSize = [12, 12];
  %       plot(surf(interp2D(Z,hiResSize,4,10)));

  switch nargin
    case {0,1}
    error('Not enough input arguements')
    case 2
    warning('using default interpolation settings')
    interpOrder = 4;
    alphaRes = 10;
    case 3
    warning('using default inter poingt resolution')
    alphaRes = 10;
  end

  if nargin>4
    error('Too many input arguements')
  end

  if any(size(loResMat)>hiResSize)
    error('interpolation size too small')
  end

  interpTable = interpLookUp(interpOrder,interpRes);
  kSubValues = floor((1:interpOrder)-(interpOrder/2)); % interp point index offset
  hiResGridY = linspace(1,size(loResMat,1),hiResSize(1));
  hiResGridX = linspace(1,size(loResMat,2),hiResSize(2));
  hiResMat = zeros(hiResSize);

  for xAxisK = 1:hiResSize(2)
    alphaX = floor((hiResGridX(xAxisK)-floor(hiResGridX(xAxisK)))*interpRes +1);
    xGridIndeces = boomerang(kSubValues + floor(hiResGridX(xAxisK)),1,6);
    xInterpGridIndex = floor(hiResGridX(xAxisK));

    for yAxisK = 1:hiResSize(1)
      alphaY = floor((hiResGridY(yAxisK)-floor(hiResGridY(yAxisK)))*interpRes +1);
      yGridIndeces = boomerang(kSubValues + floor(hiResGridY(yAxisK)),1,6);
      yInterpGridIndex = floor(hiResGridY(yAxisK));
      loResPoints = loResMat(xGridIndeces,yGridIndeces);

      hiResMat(yAxisK,xAxisK) = ...
      kron(interpTable(alphaY,:),interpTable(alphaX,:)) * ...
      loResPoints(:);

    end
  end
