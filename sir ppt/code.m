% /******************** Coding of Network deployment and data generation in WSN **********************************************/
% /******Written by Srijit Chowdhury, Senior Research Scholar, IIEST, Shibpur.************************************************/
% /******Copyright@2019-2021*******************************************************************************************************/
% /******Do not delete/modify upto the below comment line. You can freely use, and modify for academic purpose only.**********/
% /******Do not distribute without getting prior permission. For permission or any query email to src.dcs.dcs@gmail.com ******/
% /***************************************************************************************************************************/
clc
clear all
close all

N=input('No. of nodes: ');
L=input('Length of area: ');
tr=input('Transmission range: ');
a=sqrt(2)*tr;
nRx=ceil(L/a);
nRy=ceil(L/a);
minX=0;minY=0;maxX=0;maxY=0;

 
 count=1;
 for i=1:nRx
 minY=maxY;
 maxY=maxY+ceil(L/nRy);     
     for j=1:nRy
         minX=maxX;
         maxX=maxX+ceil(L/nRx);
         Region(count).minX=minX;
         Region(count).maxX=maxX;
         Region(count).minY=minY;
         Region(count).maxY=maxY;

     count=count+1;
     end
 minX=0;maxX=0;
 
 end

for i=1:N
    sensors(i).id=i;
    sensors(i).x=randi(L);
    sensors(i).y=randi(L);
% %     display(sensors(i).id)
% %     display(sensors(i).x)
% %     display(sensors(i).y)
     plot(sensors(i).x,sensors(i).y,'ro')
     hold on
end
fn=input('Enter file name to save id and positions of sensor nodes: ','s');
if(isempty(fn))
    fn='Network1.txt';
end
file1=fopen(fn,'wt');
for i=1:N
   fprintf(file1,'%d %d %d\r\n',sensors(i).id,sensors(i).x,sensors(i).y); 
end
fclose(file1);

dist=zeros(N);
adj_mat=zeros(N);
adj=fopen('adj_mat.txt','wt');
dnode=fopen('dist_node.txt','wt');
for i=1:N
   for j=1:N
      d=sqrt((sensors(i).x-sensors(j).x)^2 + (sensors(i).y-sensors(j).y)^2);
      dist(i,j)=d;
      if d>0 && d<=tr
         adj_mat(i,j)=1;
          
      else
         adj_mat(i,j)=0; 
      end
      fprintf(adj,'%d ',adj_mat(i,j));
      fprintf(dnode,'%.2f ',dist(i,j));
   end
   fprintf(adj,'\r\n');
   fprintf(dnode,'\r\n');
end
fclose(adj);
fclose(dnode);
 for i=1:N
     count=1;
     for j=1:nRx
         for k=1:nRy
             if(sensors(i).x>=Region(count).minX && sensors(i).x<=Region(count).maxX && sensors(i).y>=Region(count).minY && sensors(i).y<=Region(count).maxY)
                sensors(i).region=strcat(num2str(j),num2str(k));
                sensors(i).region1=count;
             end

         count=count+1;
         end
     end
 end
 
 tempLow=15; 
tempHigh=35;
 d=2;       %%%%%%%%%%%%% Degree of fluctuations in temperature within a specific region.
 
 count=1;
 for i=1:nRx
     for j=1:nRy
         minT=tempLow+rand()*(tempHigh-tempLow);
         maxT=minT+d;
         Region(count).minT=minT;
         Region(count).maxT=maxT;

         count=count+1;
     end
 end
 
 
% % temp= importdata('SyntheticDataset1.xlsx');
 filename='Dataset1.csv';
 temp=fopen(filename,'wt');  
 %using 'wt' helps clear file contents before writing
  filename='Dataset2.csv';
 temp2=fopen(filename,'wt'); 
 n1=input('Enter no. of data per node: ');
 if isempty(n1)
     n1=1000;
 end
 interval=input('Enter interval of sensor reading: ');
 if isempty(interval)
     interval=30;
 end
 
 row=1;
 for i=1:n1
     t1=datestr(now);
     t2=datevec(t1,'dd-mmm-yyyyHH:MM:SS');
     
     for j=1:N
        c=sensors(j).region1;
        tempReading=Region(c).minT+rand()*(Region(c).maxT-Region(c).minT);
        fprintf(temp,'%s %d %f\r\n',t1,sensors(j).id,tempReading);
        fprintf(temp2,'%f\n',tempReading);
         row=row+1;
     end
     pause(interval);
 end
 fclose(temp);
