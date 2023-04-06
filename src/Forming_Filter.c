#include <stdio.h>
#include <math.h>
#include <complex.h>

//son i
float F_i = [27,80,575];
float BW_i = [328,2208,2885];

//son /I/
float F_I = [41,158,655];
float BW_I = [365,2108,2826];

//son /e/
float F_e = [96,128,450];
float BW_e = [477, 1975, 2874];

// son /ae/
float F_ae =  [627, 1914, 2850]; // Formant frequencies (Hz)
float BW_ae = [73,  101,  406];


// son /a/
float F_a = [84,119,294];
float BW_a = [735,1236,2489];

// son /ʌ/
float F_ʌ = [65,176,458];
float BW_ʌ = [676,1266,2438];

// son /ɐ/
float F_ɐ = [72,84,387];
float BW_ɐ = [650,1027,2445];

//son /Ↄ/
float F_Ↄ = [61,108,299];
float BW_Ↄ = [504,868,2654];


float fs = 8192;              // Sampling rate (Hz)
//poly



void filter(float F, float BW, float fs){
    int B = 1;  
    int nsecs = length(F);
    double R=[nsecs];
    double theta=[nsecs];
    double poles =[nsecs];
    for(int i=0, i<nsecs, i++){
       R[i] = exp(-M_PI*BW/fs);    //Pole radii
       theta[i]= 2*M_PI*F[i]/fs;      // Pole angles
       poles[i]=R[i] * exp(I*theta[i]); //Complex poles ;
    }
    for (int j=0;j<nsecs; j++){
        double A = real(poly( [poles,conj(poles)] ));


    }

//freqz(B,A); % View frequency response:

}





/*Synthesize bandlimited impulse train

for i=1:nharm,
    sig = sig + cos(i*w0T*n);
end;

sig = sig/max(sig);
speech = filter(1,A,sig);

figure(2)


audiowrite("test_a.wav",speech,fs);

#sound(sig,fs);

#sound(speech,fs); % hear buzz, then 'ah'*/