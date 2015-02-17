function [Ox, Oy] = gaussian1d(m,d)
Ox = (m-d*5):0.1:(m+d*5);
Oy = zeros(size(Ox));

for i = 1:size(Oy,2)
    x = Ox(i);
    Oy(i) = 1/(sqrt(d^2*2*pi))*exp(-((x-m)^2)/(2*d^2));
end

end