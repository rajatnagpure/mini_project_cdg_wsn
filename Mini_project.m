clear all;
clc;
N=100;
%M=17;
fileID=fopen('Mini_150.csv','w');
A=zeros(100,2);
B=zeros(100,2);
T=csvread('Dataset2.csv');

%fprintf(fileID,"For N = %d\n\n\n",N);
%fprintf(fileID,"M    count   cv\n");
for M = 1:100
    min=10;
    max=20;
    for i=1:M
        for j=1:N
            %       P(i,j)=i+j;
            P(i,j)=sqrt(2/N)*cos((pi/N)*(i-1+1/2)*(j-1+1/2));
        end
    end
    % r = (b-a).*rand(1000,1) + a;
    d=T(:,1)%(max-min).*rand(N,1)+min;
    d=round(d);
    y=P*d;
    P1=pinv(P);
    d1=P'*y;
    d1=round(d1);
    compareP=round(P')==round(P1);
    compareD=round(d)==round(d1);
    a=sum(compareD(1:M,1));
    c=round(d)-round(d1);
    c=abs(c);
    mean2=mean(c);
    sd=std(c);
    cv=sd/mean2;
    if mean2==0
        cv=0;
    end;
    nbytes2=fprintf(fileID,'%d    %d    %f \n',M,a,cv);
    A(M,2)=cv;
    A(M,1)=M;   
    B(M,2)=a;
    B(M,1)=M;

end;
fclose(fileID);
hold on;
plot(A(:,1),A(:,2));
title("No of packets Vs Covarience");
xlabel("No of packets");
ylabel("Covarience");
%figure,plot(B(:,1),B(:,2));
figure,plot(B(:,1),B(:,2));
title("No. of packets Vs no of matching packets");
xlabel("No. of packets");
ylabel("No. of matching packets");

save WS_spatial.mat;



 