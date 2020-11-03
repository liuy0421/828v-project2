function [M_,inds] = Preprocess(M,words)

    [n,m] = size(M);
    
    idf = sum(M>0,1);
    is_str = zeros(m,1);
    
    for i = 1:m
        % 1. remove words with numerals
        cond1 = ~any(regexp(convertCharsToStrings(words(i)),'[0-9]'));
        % 2. remove short words with length < 5
        cond2 = strlength(convertCharsToStrings(words(i)))>4;
        % 3. remove common words occurring in > 70% of documents
        cond3 = idf(i) < 0.7*n;
        is_str(i) = cond1*cond2*cond3;
    end
    inds = find(is_str>0);
    M_ = M(:,inds);
    
end