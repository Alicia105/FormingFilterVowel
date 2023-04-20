% Formant frequencies for different vowels ---->to master

% son /i/
F_i = [27,80,575]
BW_i = [328,2208,2885]

% son /I/
F_I = [41,158,655]
BW_I = [365,2108,2826]

% son /e/
F_e = [96,128,450]
BW_e = [477, 1975, 2874]

% son /ae/
F_ae =  [627, 1914, 2850]; % Formant frequencies (Hz)
BW_ae = [73,  101,  406];
fs = 8192;              % Sampling rate (Hz)

% son /a/
F_a = [84,119,294]
BW_a = [735,1236,2489]

% son /ʌ/
F_delta = [65,176,458]
BW_delta = [676,1266,2438]

% son /ɐ/
F_ea = [72,84,387]
BW_ea = [650,1027,2445]

% son /Ↄ/
F_c = [61,108,299]
BW_c = [504,868,2654]

F = F_a;
BW = BW_a;
nsecs = length(F);
R = exp(-pi*BW/fs);     % Pole radii
theta = 2*pi*F/fs;      % Pole angles
poles = R .* exp(j*theta); % Complex poles 
B = 1;  A = real(poly([poles,conj(poles)]));
% freqz(B,A); % View frequency response:

% Convert to parallel complex one-poles (PFE):
[r,p,f] = residuez(B,A);
As = zeros(nsecs,3);
Bs = zeros(nsecs,3);
% complex-conjugate pairs are adjacent in r and p:
for i=1:2:2*nsecs
    k = 1+(i-1)/2;
    Bs(k,:) = [r(i)+r(i+1),  -(r(i)*p(i+1)+r(i+1)*p(i)), 0];
    As(k,:) = [1, -(p(i)+p(i+1)), p(i)*p(i+1)];
end
sos = [Bs,As]; % standard second-order-section form
iperr = norm(imag(sos))/norm(sos); % make sure sos is ~real
disp(sprintf('||imag(sos)||/||sos|| = %g',iperr)); % 1.6e-16
sos = real(sos) % and make it exactly real

% Reconstruct original numerator and denominator as a check:
[Bh,Ah] = psos2tf(sos); % parallel sos to transfer function
% psos2tf appears in the matlab-utilities appendix
disp(sprintf('||A-Ah|| = %g',norm(A-Ah))); % 5.77423e-15
% Bh has trailing epsilons, so we'll zero-pad B:
disp(sprintf('||B-Bh|| = %g',...
             norm([B,zeros(1,length(Bh)-length(B))] - Bh)));
% 1.25116e-15

% Plot overlay and sum of all three 
% resonator amplitude responses:
nfft=512;
H = zeros(nsecs+1,nfft);
for i=1:nsecs
  [Hiw,w] = freqz(Bs(i,:),As(i,:));
  H(1+i,:) = Hiw(:).';
end
H(1,:) = sum(H(2:nsecs+1,:));
ttl = 'Amplitude Response'; 
xlab = 'Frequency (Hz)';
ylab = 'Magnitude (dB)';
sym = ''; 
lgnd = {'sum','sec 1','sec 2', 'sec 3'};
np=nfft/2; % Only plot for positive frequencies
wp = w(1:np); Hp=H(:,1:np);
figure(1); clf;
myplot(wp,20*log10(abs(Hp)),sym,ttl,xlab,ylab,1,lgnd);
%disp('PAUSING'); pause;


% Now synthesize the vowel [a]:
nsamps = 4096*2;
f0 = 100; % Pitch in Hz
w0T = 2*pi*f0/fs; % radians per sample

nharm = floor((fs/2)/f0); % number of harmonics
sig = zeros(1,nsamps);
n = 0:(nsamps-1);
% Synthesize bandlimited impulse train

for i=1:nharm
    sig = sig + cos(i*w0T*n);
end

sig = sig/max(sig);
speech = filter(1,A,sig);

figure(2)
plot(speech);

audiowrite("test_a.wav",speech,fs);

%sound(sig,fs);

%sound(speech,fs); % hear buzz, then 'ah'

