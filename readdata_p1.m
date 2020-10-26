function [M,col_id,row_id,titles] = readdata_p1()

A = readmatrix('MovieRankings36.csv');
titles = ["Home Alone";"The Lion King";"The Princess Bride";"Titanic";...
          "Beauty and the Beast";"Cinderella";"Shrek";"Forrest Gump";...
          "Aladdin";"Ferris Bueller's Day Off";"Finding Nemo";...
          "Harry Potter and the Sorcerer's Stone";"Back to the Future";...
          "UP";"The Breakfast Club";"The Truman Show";"Avengers: Endgame";...
          "The Incredibles";"Coraline";"Elf"'];
% n = number of people, m = movies
[n,m] = size(A);
empty = isnan(A);
nan_row = [];
nan_col = [];
% greedily remove columns and rows with missing data
while sum(sum(empty)) ~= 0
    [~,maxid] = max([sum(empty,1)'./n;sum(empty,2)./m]);
    if maxid > m % if a row has the most # of missing data
        id = maxid - m;
        nan_row = [nan_row, id];
        empty(id,:) = zeros(1,m);
    else % if a column has the most # of missing data
        nan_col = [nan_col, maxid];
        empty(:,maxid) = zeros(n,1);
    end
end
row_id = setdiff(1:n, nan_row);
col_id = setdiff(1:m, nan_col);
M = A(row_id,col_id);