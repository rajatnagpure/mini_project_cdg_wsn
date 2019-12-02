load WS_spatial;
load WS_random;

hold on;
plot(A(:,1),A(:,2),'g');
title("No of packets Vs Covarience");
xlabel("No of packets");
ylabel("Covarience");
plot(C(:,1),C(:,2),'r');
hold off;