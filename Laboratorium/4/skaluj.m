function [v] = skaluj( u )

max_u = max(u);
n = length(u);

for i=1:n
    v(i) = u(i) / max_u;
end

end

