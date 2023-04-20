#include <stdio.h>
#include <math.h>
#include <complex.h>
#include "../inc/forming_filter.h"

float fs = 8192;              // Sampling rate (Hz)
//poly

void filter(float *F, float *BW, float fs){
    double A ;
    int B = 1;  
    int nsecs = sizeof(F)/sizeof(F[0]);

    double R[nsecs];
    double theta[nsecs];
    double poles[nsecs];
    double conju[nsecs];

    for(int i=0;i<nsecs; i++){
       R[i] = exp(-M_PI*BW[i]/fs);    //Pole radii
       theta[i]= 2*M_PI*F[i]/fs;      // Pole angles
       poles[i]=R[i] * exp(I*theta[i]); //Complex poles ;
      // poles[i]=R[i]. * exp(I*theta[i]); //Complex poles ;
       conju[i]=conj(poles[i]);
    }
    /*for (int j=0;j<nsecs; j++){
        // poly= [poles,conj(poles)];
        printf

    }*/
//A=creal(poly);*/ 
}

//fonction de filtre matlab
/*function [A , B] = filtre_aeiou (F,BW,fs)

  R = exp(-pi*BW/fs);     % Pole radii
  theta = 2*pi*F/fs;      % Pole angles
  poles = R .* exp(j*theta); % Complex poles
  B = 1;  A = real(poly([poles,conj(poles)]));

end*/



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