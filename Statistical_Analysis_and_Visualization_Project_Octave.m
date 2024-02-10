clc
close all
clear all
pkg load statistics


a=[62 75 67 65 68 71 67 81 61 62 67 63 73 78 72 57 92 67 74 71 74 82 60 55 74 82 61 57 69 77 77 68 85 67 60 70 64 78 80 66 70 59 65 88 67 73 75 66 63 67];
b=[54.5 59.5 64.5 69.5 74.5 79.5 84.5 89.5 94.5];
n=length(a);

sorted=sort(a);
f=[0 0 0 0 0 0 0 0];
for i=1:n
  if b(1)<=sorted(i)&&sorted(i)<=b(2)
    f(1)=f(1)+1;
  endif
  if b(2)<=sorted(i)&&sorted(i)<=b(3)
      f(2)=f(2)+1;
  endif
  if b(3)<=sorted(i)&&sorted(i)<=b(4)
      f(3)=f(3)+1;
  endif
  if b(4)<=sorted(i)&&sorted(i)<=b(5)
      f(4)=f(4)+1;
  endif
  if b(5)<=sorted(i)&&sorted(i)<=b(6)
      f(5)=f(5)+1;
  endif
  if b(6)<=sorted(i)&&sorted(i)<=b(7)
      f(6)=f(6)+1;
  endif
  if b(7)<=sorted(i)&&sorted(i)<=b(8)
      f(7)=f(7)+1;
  endif
  if b(8)<=sorted(i)&&sorted(i)<=b(9)
      f(8)=f(8)+1;
  endif
endfor
f


nf=length(f);


x=[];
for t=1:nf
  x(t)=(b(t)+b(t+1))./2;
endfor
x

N=sum(f)
range=max(a)-min(a)
k=ceil(1+3.322.*(log10(N)));
classwidth=floor(37./k)
k=ceil(range./classwidth)




%% mean calculation and plot

figure

xf=x.*f
mean_a=(1./N).*(sum(xf))
hold
bar(x,f,1);
plot([mean_a,mean_a],[0 max(f)],'r')
plot(x,f,'k')

xlabel('class')
ylabel('Frequency')
title('Histogram-Frequency polygon')
legend('histogram','mean','frequency polygon')
grid







cfa=[];
for t=2:nf+1
  cfa(1)=0;
  cfa(t)=f(t-1);
  if(t>1)
  cfa(t)=cfa(t)+cfa(t-1);

    endif
   endfor
  cfa


  cfd=[];
  cfd(1)=sum(f);
  for t=2:nf+1
  if(t>1)
  cfd(t)=cfd(t-1)-f(t-1);

    endif
   endfor
  cfd


  cf=[];
for t=1:nf
  cf(t)=f(t);
  if(t>1)
  cf(t)=cf(t)+cf(t-1);

    endif
   endfor
  cf

%%% median calculation and plot

class_midpoint=(n+1)./2;


for t=1:nf
  if(cf(t)>class_midpoint)
  pointer=t
  break
    endif
   endfor
  l=b(pointer)
  fm=f(pointer)
  v=cf(pointer-1)

median_a=l+(((((n+1)./2)-cf(pointer-1))./fm)).*classwidth

figure

hold
plot([median_a,median_a],[0 max(cf)],'r')
plot(b,cfa)
plot(b,cfd)

xlabel('class')
ylabel('Cumulative Frequency')
title('Ascending-Descending Cumulative Frequency ')
legend('Median','Ascending cf','Descending cf')




%% mode calculation and plot

modefrequency=max(f)
for i=1:nf
  if modefrequency == f(i)
    pointer2=i
  endif
endfor

delta1=f(pointer2)-f(pointer2-1);
delta2=f(pointer2)-f(pointer2+1);
mode_a=b(pointer2)+((delta1/(delta1+delta2)).*classwidth)

figure

hold
bar(x,f,1);
plot([mode_a,mode_a],[0 max(f)],'r')
plot([b(pointer2),b(pointer2+1)],[f(pointer2),f(pointer2+1)],'k')
plot([b(pointer2+1),b(pointer2)],[f(pointer2),f(pointer2-1)],'k')
xlabel('class')
ylabel('Frequency')
title('Histogram')
legend('histogram','mode')
grid
