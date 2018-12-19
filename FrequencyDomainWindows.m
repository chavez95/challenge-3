function X = FrequencyDomainWindows(x, block, hop)
% x should be a vector
% block = block size
% hop = hop size good size is block/4

% create a win 
win = hamming(block);
win = win';


XLen = size(x,2);
% create an output matrix row = information of each bin col = number of
% bins
X = zeros((1+block/2),1+round((XLen-block)/hop));
numBlocks = floor((XLen-block)/hop);

% create bins, apply window, and store output
for i = 1:numBlocks
    i_start = (i-1) * hop +1;
    i_stop =  i_start + block -1;
    bin = win .* x(i_start:i_stop);
    BIN = fft(bin);
    X(:,i) = BIN(1:1+block/2)';   % only need half the spectrum the other have is the same values but negative complex conjugates.
    % create plots to show statement above
    % plot(linspace(-10,10,1024), imag(fftshift(BIN)))
    % plot(linspace(-10,10,1024), real(fftshift(BIN)))
end


end