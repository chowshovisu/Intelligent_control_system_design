%%
% *ANFIS* 
%%
%We need to Make sure to include anfX.fis in directory
clear all; close all; clc; warning off;
%u=rand(200,1);
r=linspace(-pi,pi,200);
u=sin(r);
u=u';
%u=ones(200,1);
y=zeros(200,1);
% Assuming initial condition 'zero'
for k=2:length(u)-1
    y(k+1)=((y(k)*u(k))/(1+abs(y(k-1))^0.3))-(1-exp(-u(k)))/((1+exp(-u(k))));
end

train_data=[u(1:100),y(1:100)];
test_data=[u(101:200),y(101:200)];
%%
figure(1)
plot(u,'r');
hold on;
plot(y,'k');
title('OUTPUT VS INPUT');
legend('Input', 'Output','location','best');
grid on;
%%
f=readfis('anfX.fis')
yf=evalfis(u, f);
figure(2)
plot(y,'g-');
hold on;
plot(yf,'ro');
hold on;
plot([100,100],[min(y),max(y)],'k--');
legend('Given system','ANFIS','LEFT: TRAINED|RIGHT: TEST','location','best');
grid on;
ylabel('Output');
title('System VS ANFIS');

%% 
% *ARTIFICIAL NEURAL NETWORK*
%%
u1=u(1:100);
y1=y(1:100);

net = fitnet(20) 
net = train(net,u1',y1'); 
view(net) 
yn = net(u'); 
%%
figure(3)
plot(y,'g-');
hold on;
plot(yn,'ro');
hold on;
plot([100,100],[min(y),max(y)],'k--');
legend('Given system','ANN','LEFT: TRAINED|RIGHT: TEST','location','best');
grid on;
ylabel('Output');
title('System VS ANN');
%%
%I tested the system with ANFIS and ANN. The error was less in ANFIS
%system. Both system works well with trained input but when I used
%tesed data, It couldn't identify the system properly. 