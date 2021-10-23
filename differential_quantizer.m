function [xq_n,xq_n_decoder] = differential_quantizer(x_n,partition,codebook)
x_estimated=0; % the first register is empty
d_n=x_n(1);
[~,dq_n]=quantiz(d_n,partition,codebook);
xq_n=dq_n;

%encoder part
for i=2:length(x_n)
    x_estimated(i)=xq_n(i-1);
    d_n(i)=x_n(i)-x_estimated(i);
    [~,dq_n(i)]=quantiz(d_n(i),partition,codebook);
    xq_n(i)=dq_n(i)+x_estimated(i);
end

%decoder part
xq_n_decoder=dq_n(1);
for j=2:length(dq_n)
    xq_n_decoder(j)=dq_n(j)+xq_n_decoder(j-1);
end
end