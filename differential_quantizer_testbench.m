%% Quantization of x_n and obtaining xq_n @ encoder and decoder
clear all
clc
close all
x_n=randn(1,100);
partition=linspace(min(x_n),max(x_n),length(x_n));
codebook=(partition(1)+partition(2))/2-(partition(2)-partition(1));
codebook=[codebook (partition(1)+partition(2))/2];
for i=1:length(partition)-1
    codebook=[codebook codebook(i+1)+(partition(2)-partition(1))];
end
[xq_n,xq_n_decoder]=differential_quantizer(x_n,partition,codebook);
figure
plot(xq_n-xq_n_decoder);
title('Difference Between Quantized x_n at Decoder and at Encoder ')
xlabel('n');
ylabel('V');

%% Some plots
figure
plot(x_n);
hold on
plot(xq_n-x_n);
title('x_n and the error (x_n - x_n @ decoder)');
legend('x_n','error')
xlabel('n');
ylabel('V');

%% SNR Calculation
snr=10*log10(var(x_n)/var(x_n-xq_n));