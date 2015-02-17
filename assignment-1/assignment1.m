x = (5:0.1:10);
y = zeros(size(x));
for i = 1:size(y)
   y(i) = 2*x(i) + 1; 
end

plot(x,y);

%% Exercise 2.1
[Ox1 , Oy1] = gaussian1d(-1,1);
[Ox2 , Oy2] = gaussian1d(0,2);
[Ox3 , Oy3] = gaussian1d(2,3);

subplot(1,3,1)
plot(Ox1, Oy1,'r');
subplot(1,3,2)
plot(Ox2, Oy2,'b');
subplot(1,3,3)
plot(Ox3, Oy3,'g');


%% Exercise 2.2
mu = [1 2];
sigma = [0.3 0.2; 0.2 0.2];
R = chol(sigma,'lower');
z = repmat(mu,100,1) + randn(100,2)*R;
plot(z(:,1),z(:,2),'.');

