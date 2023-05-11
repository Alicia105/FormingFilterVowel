%--------------------------------------------%
% def signal entrée%

[signal_in,fs] = audioread('synth_test_projet.wav');
signal_in = signal_in(:,1);
S = size(signal_in);

size_fen = 128; 
nobs = 1 : size_fen;
fen = 1/2 * (1 - cos(pi*1/(size_fen/2)*nobs));
fen=fen.';
fen2 = cat(1, fen(size_fen/2 : size_fen) , fen(1 : size_fen/2-1)) ; 
nf = 800;

%%définition des variables de filtre
    
%son i
F_i = [328,2208,2885];
BW_i = [27,80,575];

%son /I/
F_I = [365,2108,2826];
BW_I = [41,158,655];

%//son /e/
F_e = [477, 1975, 2874];
BW_e = [96,128,450];

%// son /ae/
F_ae =  [627, 1914, 2850];
BW_ae = [73,  101,  406];


%// son /a/
F_a =[735,1236,2489];
BW_a = [84,119,294];

%// son /ʌ/
F_delta = [676,1266,2438];
BW_delta = [65,176,458];

%// son /ɐ/
F_ea = [650,1027,2445];
BW_ea = [72,84,387];

%//son /Ↄ/
F_c = [504,868,2654];
BW_c = [61,108,299];


% paramètres filtres % 

[A1,B1] = filtre_aeiou(F_a,BW_a,fs);
[A2,B2] = filtre_aeiou(F_c,BW_c,fs);



sig_fen_1 = repmat(fen,nf,1);
sig_fen_2 = repmat(fen2, nf,1);


n = size(sig_fen_1);

out_1 = filter(B1,A1,sig_fen_1.*signal_in(1:n));
out_2 = filter(B2,A2,sig_fen_1.*signal_in(n+1 : 2*n));

out_3 = filter(B1,A1,sig_fen_2.*signal_in(1:n));
out_4 = filter(B2,A2,sig_fen_2.*signal_in(n+1 : 2*n));

sig_fen_tot = sig_fen_1+sig_fen_2;

out = cat(1, 1/2*(out_1+out_3), 1/2*(out_2+out_4));

out2 = filter(B2,A2,signal_in);

%-----------------------------------------------%

% Figures %  

figure(1)
plot((1:2*n),cat(1,sig_fen_1,sig_fen_1),(1:2*n),cat(1,sig_fen_2,sig_fen_2));
title("signal de fenetrage")

figure(2)
plot((1:2*n),cat(1,out_1,out_2),(1:2*n),cat(1,sig_fen_1,sig_fen_1))
title("signal filtré et fenêtre 1")
legend;

figure(3)
plot((1:2*n),cat(1,out_3,out_4),(1:2*n),cat(1,sig_fen_2,sig_fen_2))
title("signal filtré et fenêtre 2")

figure(4)
plot(out)
title("signal filtré total")


audiowrite("out.wav",out,fs)










