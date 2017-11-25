function outVar = boomerang(k,MIN,MAX)
  % BOOMERANG: Mirror Wrap an array so that it rebounds up and down
  % between a maximum and minimum
  %
  %   outVar = boomerang(k,MIN,MAX) returns a number or array, depending
  %   on the input value(s) 'k'. This value is bound between a MIN and
  %   MAX threshold. If beyond a threshold the number is mirrored back up the
  %   range until the other threshold is reached.
  %
  %     Example
  %       x = 1:10;
  %       max = 7;
  %       min = 3;
  %       y = boomerang(x,min,max);

  if nargin<3
    error('Not enough input arguements')
  end

  if nargin>3
    error('Too many input arguements')
  end
  if (MAX<MIN || MIN>MAX)
    error('INVALID BOUNDS')
  end

  range = MAX - MIN;

  if ((any(size(k)>1))) %% array ouput

    over = k(k>MAX) - MAX;
    upAndOverIndex = find(mod(floor(over/range),2)==0);
    upAndOver = over(upAndOverIndex);
    downAndOverIndex = find(mod(floor(over/range),2)==1);
    downAndOver = over(downAndOverIndex);
    over(upAndOverIndex) = MAX - mod(upAndOver,range);
    over(downAndOverIndex) = MIN + mod(downAndOver,range);

    under = abs(k(k<MIN) - MIN);
    upAndUnderIndex = find(under(mod(floor(under/range),2)==0));
    upAndUnder = under(upAndUnderIndex);
    downAndUnderIndex = find(under(mod(floor(under/range),2)==1));
    downAndUnder = under(downAndUnderIndex);
    under(upAndUnderIndex) = MIN+mod(upAndUnder,range);
    under(downAndUnderIndex) = MAX-mod(downAndUnder,range);

    k(k<MIN) = under; k(k>MAX) = over;
    outVar = k;
    %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    %% single number ouput
  else

    if (k > MAX)
      over = k - MAX;
      if mod(floor(over/range),2)
        outVar = MIN+mod(over,range);
      else
        outVar = MAX - mod(over,range);
      end


    elseif (k < MIN)
      over = abs(k - MIN);
      if mod(floor(over/range),2)
        outVar = MAX-mod(over,range);
      else
        outVar = MIN + mod(over,range);
      end

    else
      outVar = k;
      %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    end
  end
