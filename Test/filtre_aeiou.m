function [A , B] = filtre_aeiou (F,BW,fs)

  R = exp(-pi*BW/fs);     % Pole radii
  theta = 2*pi*F/fs;      % Pole angles
  poles = R .* exp(j*theta); % Complex poles
  B = 1;  A = real(poly([poles,conj(poles)]));

end