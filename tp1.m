 clear all
close all
clc

fe = 1e4;
te = 1/fe;
N = 5000; 

t = (0:N-1)*te; 

%% Repr�sentation temporelle et fr�quentielle

x = 1.2*cos(2*pi*440*t+1.2)+3*cos(2*pi*550*t)+0.6*cos(2*pi*2500*t);
figure;

% Question 1:


subplot(2,3,1)
plot(t,x,'.');
title('Le signal x(t)')


%Question 2:

%Step 1: cr�� le vecteur f qui correspond � l'�chantillonnage du signal 
%dans l'espace fr�quentiel
f =(0:N-1)*(fe/N); 
%Utilisation de la commande fft qui correspond a faire la transformee
%de fourier discret d'une mani�re rapide 
y = fft(x); 
%sans decalage
% On fait abs pour avoir le module  
subplot(2,3,2)
plot(f,abs(y));
%avec la commande fft on obtient un spectre qui n'est pas centr� sur 0
title("Le spectre d'amplitude")


%Question 3:

%Pour centr� le spectre on doit cr�er une autre variable dont on va tracer
%la fonction fftshift qui fait le d�calage
fshift = (-N/2:N/2-1)*(fe/N);
subplot(2,3,3)
%On multiplie par 2 pour avoir l'ampliture exact avant on obtient le module
%de Cn
plot(fshift,fftshift(2*abs(y)/N))
title("Le spectre d'amplitude centr�")


%Question 4:

%Introduction de bruit 
noise = 5*randn(size(x));
subplot(2,3,4)
plot(noise)
title("Le signal noise")


%Question 5:

%sound(noise)
xnoise = x+noise;
%sound(xnoise)


%Question 6:

ybruit = fft(xnoise);
subplot(2,3,5)
% plot(fshift,fftshift((abs(ybruit)).^2/N));
plot(fshift,fftshift((abs(ybruit)*2)/N));
title("Le signal noise ")


%Question 7:
figure;
noise2 = 20*randn(size(x));
xnoise2=x+noise2;
ybruit2 = fft(xnoise2);
plot(fshift,fftshift((abs(ybruit2))*2/N));
title("Le signal noise 2")

%Apr�s l'augementation de l'intensit� du signal bruit on remarque que le
%spectre de bruit est encombrer avec celui qui contient l'informatrion
%pertinante du coup �a sera tr�s difficile d'extrait et filtrer le signal
%xnoise2

%% Analyse fr�quentielle du chant du rorqual bleu

%Question 1:
[whale,fe]=audioread("bluewhale.au");
 
chant = whale(2.45e4:3.10e4);
%Question 2:

sound(chant,fe)

%Question 3:
N = length(chant);
te = 1/fe;
t = (0:N-1)*(10*te);
figure;
subplot(2,1,1)
plot(t,chant)
title('Le signal whant')
y = abs(fft(chant)).^2/N; 
f = (0:floor(N/2))*(fe/N)/10;
subplot(2,1,2)
plot(f,y(1:floor(N/2)+1));
title('Le signal densit� spectrale de puissance du signal')
[23:35, 29/01/2023] Aymane Ouchker: clear all
close all
clc
%% Jeux de mots
%Question 1:

[x,fe]=audioread("/Users/aymanouchker/Documents/eidia/S5/Traitement du signal/Traitement-de-signal/sound.au");

%Question 2:

%sound(x,fe)
plot(x)

%Question 3:

%sound(x,fe*2)
%sound(x,fe/2)
%sound(x,fe)



%Question 4:

stem(x)
%Apr�s le tra�age de la fonction x on peut arriver a voir que le morceau 
%Rien ne sert de est contenue dans la partie de l'index 1025 j'usqu'� 2.05e05

%Question 5:


riennesertde=x(1025:(2.05e05));
stem(riennesertde)
%sound(riennesertde,fe)

%Question 6:

courir=x((2.239e+05):(2.642e+05));
%sound(courir,fe)

ilfaut=x((2.987e+05):(3.81e+05));
%sound(ilfaut,fe)

partirapoint=x((4e+05):(5.28e+05));
%sound(partirapoint,fe)



%Question 7:
parole=[riennesertde ,partirapoint ,ilfaut,courir];
%sound(parole,fe)


%% Synth�se et analyse spectrale d�une gamme de musique

%Synth�se d�une gamme de musique

%Question 1:

fe=8192;
te=1/fe;
N=5000;
t=(0:N-1)*te;
do=10*cos(2*pi*262*t);
%sound(do,fe)
re=10*cos(2*pi*294*t);
%sound(re,fe)
mi=10*cos(2*pi*330*t);
%sound(mi,fe)
fa=10*cos(2*pi*349*t);
%sound(re,fa)
sol=10*cos(2*pi*392*t);
%sound(sol,fe)
la=10*cos(2*pi*440*t);
%sound(la,fe)
si=10*cos(2*pi*494*t);
%sound(si,fe)
do2=10*cos(2*pi*523*t);
%sound(do2,fe)
musique=[do,re,mi,fa,sol,la,si,do2];
sound(musique,fe)
 

%Spectre de la gamme de musique

%Question 2:

f=(0:N-1)*(fe/N);
spectre_musique=fft(musique);
signalAnalyzer(abs(fftshift(spectre_musique)));