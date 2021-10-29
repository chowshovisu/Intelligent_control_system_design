%%
% *ANN* 
%%
clear all; close all; clc; warning off;

u=2*ones(151,1);
y=zeros(151,1);
% Assuming initial condition 'zero'
for k=2:length(u)
    if k<51
        u(k)=2*exp(-0.02*pi*(k-1));
    else
        u(k)=10*exp(-0.01*pi*(k-1))*sin(0.2*pi*(k-1));
    end
    y(k)= (y(k-1)/(1+(y(k-1))^2))+(u(k-1)^3);
end

%%
% *ARTIFICIAL NEURAL NETWORK*
%%
% *LM*
%%
u1=u(1:100);
y1=y(1:100);

net = fitnet(20,'trainlm') 
net = train(net,u1',y1'); 
view(net) 
ylm = net(u'); 
%%
figure(1)
plot(y,'g-');
hold on;
plot(ylm,'r-');
hold on;
plot([100,100],[min(y),max(y)],'k--');
legend('Given system','ANN-LM','LEFT: TRAINED|RIGHT: TEST','location','best');
grid on;
ylabel('Output');
title('System VS ANN-LM');
%%
netG = fitnet(20,'traingd') 
netG = train(netG,u1',y1'); 
view(netG) 
ygd = netG(u'); 
%%
figure(2)
plot(y,'g-');
hold on;
plot(ygd,'r-');
hold on;
plot([100,100],[min(y),max(y)],'k--');
legend('Given system','ANN-GD','LEFT: TRAINED|RIGHT: TEST','location','best');
grid on;
ylabel('Output');
title('System VS ANN-GD');
%%
figure(3)
plot(u,'r');
hold on;
plot(y,'k');
title('OUTPUT VS INPUT');
legend('Input', 'Output','location','best');
grid on;
