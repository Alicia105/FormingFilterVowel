[signal_in,fs] = audioread('synth_test_sound.wav');
signal_in = signal_in(1:90000,1);
S = size(signal_in);

size_fen = 10000;
nobs = 1 : size_fen;
fen = 1/2 * (1 - cos(pi*1/(size_fen/2)*nobs));
fen=fen.';
n = round(S / size_fen) +1 ;
n=n(1);

%F =  [627, 1914, 2850]; % Formant frequencies (Hz)
%BW = [73,  101,  406];


    %%définition de variables
    
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


% 
%     %%découpagesignal_decoupe = fen.*signal_in(1:size_fen);
% signal_decoupe_2 = fen.*signal_in(size_fen/2+1:size_fen*3/2);
%  
% [A1,B1] = filtre_aeiou(F_a,BW_a,fs);
% [A2,B2] = filtre_aeiou(F_e,BW_e,fs);
% 
% signal_decoupe_filtre = filter(B1,A1,signal_decoupe);
% signal_decoupe_filtre_2 = filter(B2,A2,signal_decoupe_2);
% 
% out = [signal_decoupe_filtre(1:size_fen/2), signal_decoupe_filtre(size_fen/2+1:size_fen)+signal_decoupe_filtre_2(size_fen/2+1 :size_fen)]  ;


% signal_decoupe = fen.*signal_in((k-1)*size_fen:k*size_fen);
% signal_decoupe_2 = fen.*signal_in(size_fen/2+1:size_fen*3/2);
% 
out1 = zeros(1, n/2);
out2 = zeros(1,n/2) ;
[A1,B1] = filtre_aeiou(F_a,BW_a,fs);
[A2,B2] = filtre_aeiou(F_e,BW_e,fs);

for k=1:n %decoupage en fenetre
    if k<n/2 
        signal_decoupe = fen.*signal_in((k-1)*size_fen+1:k*size_fen);
        signal_decoupe_2 = fen.*signal_in((k-1)*size_fen/2+1:k*size_fen*3/2);
        signal_decoupe_filtre = filter(B1,A1,signal_decoupe);
        signal_decoupe_filtre_2 = filter(B1,A1,signal_decoupe_2);
        out(k,1)= [signal_decoupe_filtre(k,1)];
       % out1((k-1)*size_fen+1:k*size_fen) =  [signal_decoupe_filtre(1:size_fen/2), signal_decoupe_filtre(size_fen/2+1:size_fen)+signal_decoupe_filtre_2(size_fen/2+1 :size_fen)];    
    
    elseif k>=n/2
        signal_decoupe = fen.*signal_in((k-1)*size_fen+1:k*size_fen);
        signal_decoupe_2 = fen.*signal_in((k-1)*size_fen/2+1:k*size_fen*3/2);
        signal_decoupe_filtre = filter(B1,A2,signal_decoupe);
        signal_decoupe_filtre_2 = filter(B1,A2,signal_decoupe_2);
        %out2((k-1)*size_fen+1:k*size_fen) =  [signal_decoupe_filtre(1:size_fen/2), signal_decoupe_filtre(size_fen/2+1:size_fen)+signal_decoupe_filtre_2(size_fen/2+1 :size_fen)];            
    end
    
    
end
    
    
signal_decoupe = fen.*signal_in(1:size_fen);
signal_decoupe_2 = fen.*signal_in(size_fen/2+1:size_fen*3/2);
 
[A1,B1] = filtre_aeiou(F_a,BW_a,fs);
[A2,B2] = filtre_aeiou(F_e,BW_e,fs);

signal_decoupe_filtre = filter(B1,A1,signal_decoupe);
signal_decoupe_filtre_2 = filter(B2,A2,signal_decoupe_2);

%out = [signal_decoupe_filtre(1:size_fen/2) , signal_decoupe_filtre(size_fen/2+1:size_fen)+signal_decoupe_filtre_2(size_fen/2+1 :size_fen)]  ;
%out = [signal_decoupe , signal_decoupe_2]  ;

for k=1:size_fen
    if k<size_fen/2
        out(k,1)= [signal_decoupe_filtre(k,1)];
    elseif k>=size_fen/2 && k<3*size_fen/2
        out(k,1)= [signal_decoupe_filtre(k,1)+signal_decoupe_filtre_2(k,1)];
    elseif k>=3*size_fen/2
        out(k,1)= [signal_decoupe_filtre_2(k,1)];        
    end

end
out=out(:,1);
   %%figures


figure(1)
%plot(out)
subplot(221)
plot(signal_decoupe)
subplot(222)
plot(signal_decoupe_2)
subplot(223)
plot(signal_decoupe_filtre)
subplot(224)
plot(signal_decoupe_filtre_2)

figure(2)
plot(out)
%plot(out(:,1))
audiowrite("out.wav",out,fs)


