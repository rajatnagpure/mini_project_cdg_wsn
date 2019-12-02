N=10;
M=10;
Positions=zeros(N,3);
for i=1:N
    Positions(i,1)=i;
    Positions(i,2)=round((M)*rand(1));
    Positions(i,3)=round((M)*rand(1));
end ;
Tr=30;
Neighbour=zeros(N,N);
for i=1:N
    for j=1:N
            x1=Positions(i,2);
            x2=Positions(j,2);
            y1=Positions(i,3);
            y2=Positions(j,3);
            d1=sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
            if i==j
                Neighbour(i,j)=0;
            elseif d1<Tr
                Neighbour(i,j)=d1;
                %Neighbour(j,i)=d1;
            else
                Neighbour(i,j)=M+100;
            end;
    end;
end;

% for i=1:N 
%     mini=M+100;
%     for j=1:N
%         if(mini>Neighbour(j,i))
%             mini=Neighbour(j,i);
%             ind=j;
%         end;
%     end;
%     for j=1:N
%         if j~=ind
%             Neighbour(j,i)=0;
%             Neighbour(i,j)=0;
%         end;
%     end;
% end;
%

scatter(Positions(:,1),Positions(:,2));
grid on;
% minnGraph=graph(Neighbour);
% plot(minnGraph,'xData',Positions(:,2),'yData',Positions(:,3));
% 
% T= minspantree(minnGraph);
% figure,plot(T,'xData',Positions(:,2),'yData',Positions(:,3));
% 
% [tree,d]=shortestpathtree(minnGraph,1);
% figure,p=plot(minnGraph,'xData',Positions(:,2),'yData',Positions(:,3));
% p.NodeCData=d;
