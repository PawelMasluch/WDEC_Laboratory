function Z = oblicz1(nr_cechy_x, nr_cechy_y, R, A, MAX)

eps = 0.001;

Q = zeros(5, 21);

for i=1:5
    for j=1:21
        Q(i,j) = (j-1)*MAX(i)/20;
    end
end

Z = zeros( 21, 21 );

q = zeros(5);

for q1=1:21
    for q2=1:21
        for q3=1:21
            for q4=1:21
                for q5=1:21
                    
                    q = [q1 q2 q3 q4 q5];
                    
                    eta1 = eta( Q(q1), R(1), A(1) );
                    eta2 = eta( Q(q2), R(2), A(2) );
                    eta3 = eta( Q(q3), R(3), A(3) );
                    eta4 = eta( Q(q4), R(4), A(4) );
                    eta5 = eta( Q(q5), R(5), A(5) );
                    
                    tmp = [eta1 eta2 eta3 eta4 eta5]';
                    
                    S = min(tmp) + eps/5 * sum(tmp);
                    
                    Z( q(nr_cechy_x), q(nr_cechy_y) ) = S;
                    
                end
            end
        end
    end
end

end


