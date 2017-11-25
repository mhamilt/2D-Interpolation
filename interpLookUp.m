  function alpha_table = interptab(N, Q)
% interptab: Creates a look up table for interpolation of order N AND
% resolution Q.
%
%   alpha_table = interptab(N, Q) returns the lookup table alpha_table
%   with Q rows and N columns.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 Lagrange Alpha Interpolation              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Polynomial for the point j,
  % ones as it multiply by itself in a minute and can't == 0
  P_j = ones(N,Q);
  % P_jnorm = ones(N,Q);
  P_jnorm = ones(N,1);
  % As deinfed in the notes,
  % -1/2 <= alpha < 1/2
  alphas = (0:1/Q:(1-1/Q))-0.5;

  % points either side of our alpha values
  if mod(N,2) == 0
    k = -(N - 1)*0.5:1:(N - 1)*0.5; % even N
  else
    k = -N/2:1:N/2-1; % from Carlos: odd N
  end

  % loop for every value of alpha
  for q = 1:Q
    % one 'for' loop for every subpolynomial P_j(j),
    % length N but m ~= j
    for j = 1:N
      % loop for everyterm in each sub polynomial P_j(j)(m)
        for m = 1:N
          if m ~= j
            P_j(j,q) = P_j(j,q)*(alphas(q)-k(m));
            % P_jnorm(j,q) = P_jnorm(j,q)*(k(j)-k(m));
              if q == 1
              % find scaling value, basically the case if alpha == k(j)
              % only need to compute this once, hence the if for the first q
                P_jnorm(j) = P_jnorm(j)*(k(j)-k(m));
              end
          end
        end
      end
   end

   alpha_table = (P_j ./ repmat(P_jnorm,1,Q))';
