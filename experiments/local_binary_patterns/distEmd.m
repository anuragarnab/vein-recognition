function D = distEmd( X, Y )

    Xcdf = cumsum(X,2);
    Ycdf = cumsum(Y,2);

    m = size(X,1);  n = size(Y,1);
    mOnes = ones(1,m); D = zeros(m,n);
    for i=1:n
      ycdf = Ycdf(i,:);
      ycdfRep = ycdf( mOnes, : );
      D(:,i) = sum(abs(Xcdf - ycdfRep),2);
    end
    
end


