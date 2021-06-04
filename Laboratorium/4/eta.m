function wyn = eta(q, r, a)

fi = 1000;
ksi = 0.001;

if q < r
    wyn = fi*(q-r)/(a-r); 
elseif q > a
    wyn = 1 + ksi*(q-a)/(a-r);
else
    wyn = (q-r)/(a-r);
end


end

