function M = simmx(A,B)
% M = simmx(A,B)
%    calculate a sim matrix between specgram-like feature matrices A and B.
%    size(M) = [size(A,2) size(B,2)]; A and B have same #rows.
%    Omitting B gives simmx(A,A).
% 2003-03-15 dpwe@ee.columbia.edu

% $Header: /Users/dpwe/matlab/columbiafns/RCS/simmx.m,v 1.2 2009/07/08 20:24:17 dpwe Exp $
% Copyright (c) 2003-2009 Dan Ellis <dpwe@ee.columbia.edu>
% released under GPL - see file COPYRIGHT

if nargin < 2
    B = A;
end

EA = sqrt(sum(A.^2));
EB = sqrt(sum(B.^2));

% Avoid div0
EA(EA==0) = 1;
EB(EB==0) = 1;

%ncA = size(A,2);
%ncB = size(B,2);
%M = zeros(ncA, ncB);
%for i = 1:ncA
%  for j = 1:ncB
%    % normalized inner product i.e. cos(angle between vectors)
%    M(i,j) = (A(:,i)'*B(:,j))/(EA(i)*EB(j));
%  end
%end

% this is 10x faster
M = (A'*B)./(EA'*EB);