% function [f,g] = softmax_regression(theta, X,y)
function [f, g] = softmax_regression_vec(theta, X, y)
  %
  % Arguments:
  %   theta - A vector containing the parameter values to optimize.
  %       In minFunc, theta is reshaped to a long vector.  So we need to
  %       resize it to an n-by-(num_classes-1) matrix.
  %       Recall that we assume theta(:,num_classes) = 0.
  %
  %   X - The examples stored in a matrix.  
  %       X(i,j) is the i'th coordinate of the j'th example.
  %   y - The label for each example.  y(j) is the j'th example's label.
  %
  m=size(X,2);
  n=size(X,1);

  % theta is a vector;  need to reshape to n x num_classes.
  theta=reshape(theta, n, []);
  num_classes=size(theta,2)+1;
  
  % initialize objective value and gradient.
  f = 0;
  g = zeros(size(theta));
  
  
  
  %
  % TODO:  Compute the softmax objective function and gradient using vectorized code.
  %        Store the objective function value in 'f', and the gradient in 'g'.
  %        Before returning g, make sure you form it back into a vector with g=g(:);
  %
  
  tmp = zeros(size(theta));
  
  % Objective function
  expo = exp(theta' * X);
  totalSum = sum(expo,1) + 1;
  lastRow = 1 ./ totalSum;
  P = [bsxfun(@rdivide,expo,totalSum); lastRow ];
  I = sub2ind(size(P), y, 1 : size(P,2));
  f = 0 - sum(P(I)); 
  
  numClassesMinusOne = num_classes - 1;    
  diff = (y == num_classes) - P(num_classes,:);
  for i = 1 : m        
      % Gradient       
      for k = 1 : numClassesMinusOne     
          % We have to subtract by diff(i) to make up for the gradient
          % contributed by the last class, which is set to zero
          g(:,k) = g(:,k) - X(:,i)*((y(i) == k) - P(k,i) - diff(i));
      end        
      
  end
  

  
  g=g(:); % make gradient a vector for minFunc
