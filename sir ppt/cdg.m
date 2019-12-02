

N=20;
M=8;
min=10;
max=20;
for i=1:M
    for j=1:N
        %       P(i,j)=i+j;
        P(i,j)=sqrt(2/N)*cos((pi/N)*(i-1+1/2)*(j-1+1/2));
    end
end
% r = (b-a).*rand(1000,1) + a;
d=(max-min).*rand(N,1)+min;
d=round(d);
y=P*d;
P1=pinv(P);
d1=P'*y;
d1=round(d1);
compareP=round(P')==round(P1);
compareD=round(d)==round(d1);
c=round(d)-round(d1);
c=abs(c);
mean=mean(c);
sd=std(c);
cv=sd/mean;
