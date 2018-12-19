function x = Back2TimeDomain(X,block,hop)
%creates spectrogram of audio
win = hamming(block);                                       % window to use when to bin once in time domain
win = win';
numBins = size(X,2) -1;
fftlen = 2*block;                                           % make output slightly longer othewise last few bins dont fit
xLen = fftlen + (numBins)*hop;                              
x = zeros(1,xLen);

for i =0:numBins
    i_start = i*hop + 1;                                    % start and finish of x for next bin
    i_stop = i_start + block-1;                             
    iBin = X(:,i+1)';                                       % get next bin
    fullBin = [iBin, conj(iBin((block/2):-1:2))];           % recreate the negative complex conjugates compnents of the frequency
    xOfBin = real(ifft(fullBin));                           % bin from frequency domain back to time domain 
    x(i_start:i_stop) = x(i_start:i_stop) + xOfBin .* win;  % creating overlap 

end