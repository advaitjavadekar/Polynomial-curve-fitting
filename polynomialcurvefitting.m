clc
clear
close all

E=zeros(1,10);
N=100; %test points
noise_amp=0.02;
x=rand(N,1);
%non-linear functions
%y1=3*x.^5+5*x.^2+noise_amp*rand(N,1);
y1=(cos(2*pi*x)).^2+noise_amp*rand(N,1);

plot(x,y1,'ro');


M=7; % maximal polynomial order

%multivariate linear regression using Normal Equation

X=zeros(N,M+1);
for m=0:M
    X(:,m+1)=x.^m;
end

Xpseudo=X'*X\X';
what=Xpseudo*y1;
xplot=0:0.001:1;
y1plot=cos(2*pi*xplot).^2;
X2=zeros(length(xplot),M+1);
for m=0:M
    X2(:,m+1)=xplot.^m;
end
y1pred=X2*what;

%error function
e=0;
for i=1:N
    e=e+0.5*(y1plot(i)'-y1pred(i)).^2;
end
e=2*e/N;
e=e.^0.5;
E(M)=e;
figure
plot(x,y1,'ro',xplot,y1plot,'k',xplot,y1pred,'b')
legend('observations','truth','polynomial')

display(E);
order =1:10;
figure
plot(order,E);
ylabel('Error')
xlabel('Order of Polynomial')

%now we have saved the learned polynomial in y1pred
%to see if it works well we will compare how this fits with a random test
%data 'test'

test= (cos(2*pi*x)).^2+noise_amp*rand(N,1);

figure
plot(x,test,'ro',xplot,y1pred,'b');
