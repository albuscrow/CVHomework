function c = myconv2(a,b,shape)
    % check arguements
    if ( nargin ~= 2 && nargin ~= 3 )
        error( 'conv2 requires 2 or 3 arguements' );
    end
    
    % get array sizes
    [ma, na] = size(a);
    [mb, nb] = size(b);
    
    
    % do full convolution
    c = zeros( ma+mb-1, na+nb-1 );
    for i = 1:mb
        for j = 1:nb
            r1 = i;
            r2 = r1 + ma - 1;
            c1 = j;
            c2 = c1 + na - 1;
            c(r1:r2,c1:c2) = c(r1:r2,c1:c2) + b(i,j) * a;
        end
    end
    
    if ( nargin == 2 || strcmp(shape, 'full') )
        % nothing to do, full convolution done
    elseif ( strcmp(shape, 'same') )
        % extract region of size(a) from c
        r1 = floor(mb/2) + 1;
        r2 = r1 + ma - 1;
        c1 = floor(nb/2) + 1;
        c2 = c1 + na - 1;
        c = c(r1:r2, c1:c2);
    elseif ( strcmp(shape, 'valid')  )
        % extract valid region from c
        c = c(mb:ma, nb:na);
    else
        error( 'conv2 third arguement must be ''full'', ''same'', or ''valid''' );
    end
    
end