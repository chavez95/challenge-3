function XX = StretchCompress(X, samples, rate)
    BinSize = size(X,1); %Bin size
    XX = zeros(BinSize, length(samples)); % creating output array
       
    origPhase = angle(X(:,1)); % calculate phase angle of each column 
                        %before any frequency modifications are done
    
for i = samples
  binsIJ = X(:,floor(i)+[1 2]); % grab the next two bins that will be combined into one bin
  
  XXMag = 0.5*abs(binsIJ(:,1)) + 0.5 * abs(binsIJ(:,2)); % calculate the new frequency magnitude.
                                                      %0.5 * is so that madnitude doesnt double when combining magnitudes.  
  
  phaseDif = angle(binsIJ(:,2)) - angle(binsIJ(:,1));         % calculating the phase difference between the two bins. 
                                                      %needed for subsequent bins otherwise pitch distortions happen
  
  XX(:,(i/rate) + 1) = XXMag .* exp(1i*origPhase);                % new XX value to be converted back to time-domain               
  
  origPhase = origPhase + phaseDif; % phase difference from this frequency modification carries
                % over subsequent bins. add phase difference to rest of the
                % phases to have correct phases for the rest of the bins. 
end
end