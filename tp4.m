clear all
close all
clc

Te = 5*1e-4;
f1 = 500;
f2 = 400;
f3 = 50;
t = 0:Te:5-Te;
fe = 1/Te;
N = length(t);

fshift = (-N/2:N/2-1)*(fe/N);
f = (0:N-1)*(fe/N);

x = sin(2*pi*f1*t)+sin(2*f2*pi*t)+sin(2*pi*f3*t);
y = fft(x);
%{
subplot(2,1,1)
plot(t,x)

subplot(2,1,2)
plot(fshift, fftshift(abs(y)));
%}

k = 1;
wc = 50;
wc1 = 500;
wc2 = 1000;

h = (k*1j*((2*pi*f)/wc))./(1+1j*((2*pi*f)/wc));
h1 = (k*1j*((2*pi*f)/wc1))./(1+1j*((2*pi*f)/wc1));
h2 = (k*1j*((2*pi*f)/wc2))./(1+1j*((2*pi*f)/wc2));

G = 20*log(abs(h));
G1 = 20*log(abs(h1));
G2 = 20*log(abs(h2));

P = angle(h);
P1 = angle(h1);
P2 = angle(h2);

subplot(3,1,1)
semilogx(abs(h))
plot(abs(h))
legend("Module de h(t)")

subplot(3,1,2)
semilogx(f,G,f,G1,f,G2);
title("Diagramme de Bode")
xlabel("rad/s")
ylabel("decibel")
legend("G : wc=50","G1 : wc=500","G2 : wc=1000")

subplot(3,1,3)
semilogx(f,P,f,P1,f,P2)
%legend("P","P1","P2")

% Charger le signal sonore 
% [x,fs] = audioread('test.wav');

% Definir les par du filtre
% fc = 3000; % frequence de coupure 
% n = 4; % ordre du filtre

% Creer le filtre 
% [b,a] = butter(n,fc/(fs/2),'low');

% Appliquer le filtre au signal
% y = filter(b,a,x);

% Enregistrer le signal filtre
% audiowrite('signal_filtre.wav',y,fs);

% % % % % % % % % % % % % % % % % % % % % % % % % % 

[music, fs] = audioread('test.wav');
% save('testt.mat', 'y', 'fs');
load('testt.mat');
music = music';
N=length(music);
te = 1/fs;% fs=fe
t = (0:N-1)*te;

f = (0:N-1)*(fs/N);
fshift = (-N/2:N/2-1)*(fs/N);

y_trans = fft(music);
% subplot(3,1,1)
% plot(t,y)
% subplot(3,1,2)
 plot(fshift,fftshift(abs(y_trans)))


% % % % % % % % % % % % % % % % % % % % % % % % % % % 

k = 1;
fc = 5000;
%la transmitance complexe 
h =k./(1+1j*(f/fc).^1000);
h_filter = [h(1:floor(N/2)), flip(h(1:floor(N/2)))];

semilogx(f(1:floor(N/2)),abs( h(1:floor(N/2))),'linewidth',1.5)

% %diagramme de bode en fct de la phase 
% P = angle(h);
% P1 = angle(H1);
% P2 = angle(H2);

y_filtr = y_trans(1:end-1).*h_filter;
sig_filtred= ifft(y_filtr,"symmetric");

plot(fshift(1:end-1),fftshift(abs(fft(sig_filtred))))