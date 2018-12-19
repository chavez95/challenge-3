function modified = audiomod(input,rate,fs)
% input should be a vector if not a vector try this.
if size(input,1) > size(input,2)
    input = input'; 
end
% if audio stereo add row together 
% if input has more than two row program is probably going to break
if size(input,1) == 2
    input = input(1,:)+input(2,:);
end

% setting ideal block and hop sizes
block = 1024;
hop = 256;

% getting sepctrogram of the input
X = FrequencyDomainWindows(input,block,hop);

Xlen = size(X,2);   
samples = 0:rate:(Xlen-2);  % number of samples need to compress or stretch audio by a factor of rate
                            % without -2 StretchCompress.m steps out of
                            % bounds of X
                            
% create new spectrogram of stretched/compressed audio
XX = StretchCompress(X,samples,rate);

% put stretch/compressed audio back into time domain
modified = Back2TimeDomain(XX,block,hop);

% play audio
soundsc(modified,fs);




end