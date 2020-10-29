function [M,y] = readdata()
%% read data
fid=fopen('vectors.txt','r');
A = fscanf(fid,'%i\n');
ind = find(A>100000); % find entries of A with document IDs
n = length(ind); % the number of documents
la = length(A);
I = 1:la;
II = setdiff(I,ind);
d = max(A(II)); % the number of words in the dictionary
M = zeros(n,d);
y = zeros(n,1); % y = -1 => category 1; y = 1 => category 2 
% define M and y
for j = 1 : n % for all documents
    i = ind(j); % find the row in A where the doc id occurs
    y(j) = A(i+1); % the first entry in the next row is the label
    if j<n % if we're not at the last document, 
        iend = ind(j+1)-1; % the end is marked by the next
    else   % otherwise
        iend = length(A); % the end is just the length of A
    end
    M(j,A(i+2:2:iend-1)) = A(i+3:2:iend);
end
i1 = find(y==-1);
i2 = find(y==1);
ii = find(M>0);
n1 = length(i1);
n2 = length(i2);

fprintf('Class 1: %d items\nClass 2: %d items\n',n1,n2);
fprintf('M is %d-by-%d, fraction of nonzero entries: %d\n',n,d,length(ii)/(n*d));
end
