load WS_spatial;
load WS_random;

figure
hold on;
plot(B(:,1),B(:,2),'g');
title("No. of packets Vs no of matching packets");
xlabel("No. of packets");
ylabel("No. of matching packets");
plot(D(:,1),D(:,2),'r');
hold off;