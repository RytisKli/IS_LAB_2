clear all;
close all;

tic 
%% 1. duomenų paruošimas
x = [0.1:1/22:1];
d = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))/2;
plot (x,d, 'b*'); grid on
%% 2. Pasirinkti struktūrą
%pirmojo paslėptojo sluoksnio ryšių svoriai
w11_1 = randn(1)*0.1;
w12_1 = randn(1)*0.1;
w13_1 = randn(1)*0.1;
w14_1 = randn(1)*0.1;
w15_1 = randn(1)*0.1;
b1_1 = randn(1)*0.1;
b2_1 = randn(1)*0.1;
b3_1 = randn(1)*0.1;
b4_1 = randn(1)*0.1;
b5_1 = randn(1)*0.1;
%antrojo sluoksnio išėjimo ryšių svoriai
w11_2 = randn(1)*0.1;
w12_2 = randn(1)*0.1;
w13_2 = randn(1)*0.1;
w14_2 = randn(1)*0.1;
w15_2 = randn(1)*0.1;
b1_2 = randn(1)*0.1;

n = 0.15;

for indx_n = 1:100000
    for indx=1:length(x)
        %% 3. Skaičiuojame tinklo atsaką
        % 3.1 pirmojo sluoksnio neuronas
        v1_1 = x(indx)*w11_1 + b1_1;
        v2_1 = x(indx)*w12_1 + b2_1;
        v3_1 = x(indx)*w13_1 + b3_1;
        v4_1 = x(indx)*w14_1 + b4_1;
        v5_1 = x(indx)*w15_1 + b5_1;
        %aktyvavimo f-ijos  pritaikymas
        y1_1 = 1/(1+exp(-v1_1));
        y2_1 = 1/(1+exp(-v2_1));
        y3_1 = 1/(1+exp(-v3_1));
        y4_1 = 1/(1+exp(-v4_1));
        y5_1 = 1/(1+exp(-v5_1));
        %3.2 Antrojo sluoksnio neuronui
        v1_2 = y1_1*w11_2+y2_1*w12_2+y3_1*w13_2+y4_1*w14_2+y5_1*w15_2 + b1_2;
        % aktyvavimo funkcijos pritaikymas 
        y1_2 = tanh(v1_2);
        y = y1_2;
        % 3.3 skaičiuojame klaidą
        e = d(indx) - y;
        
        %% Ryšių svorių atnaujinimas
        % 3.4 skaičiuojame klaidos gradientą išėjimo sl. neuronui
        delta1_2 = (1-(tanh(v1_2))^2)*e;
        % 3.5 skaičiuojame klaidos gradientą paslėptojo sl. neuronams
        delta1_1 = y1_1*(1-y1_1)*delta1_2*w11_2;
        delta2_1 = y2_1*(1-y2_1)*delta1_2*w12_2;
        delta3_1 = y3_1*(1-y3_1)*delta1_2*w13_2;
        delta4_1 = y4_1*(1-y4_1)*delta1_2*w14_2;
        delta5_1 = y5_1*(1-y5_1)*delta1_2*w15_2;
        % 3.6 atnaujiname išėjimo sluoksnio svorius
        w11_2 = w11_2 + n*delta1_2*y1_1;
        w12_2 = w12_2 + n*delta1_2*y2_1;
        w13_2 = w13_2 + n*delta1_2*y3_1;
        w14_2 = w14_2 + n*delta1_2*y4_1;
        w15_2 = w15_2 + n*delta1_2*y5_1;
        b1_2 = b1_2 + n*delta1_2;
        % 3.7 atnaujiname paslėptojo sluoksnio svorius
        w11_1 = w11_1 + n*delta1_1*x(indx);
        w12_1 = w12_1 + n*delta2_1*x(indx);
        w13_1 = w13_1 + n*delta3_1*x(indx);
        w14_1 = w14_1 + n*delta4_1*x(indx);
        w15_1 = w15_1 + n*delta5_1*x(indx);
        b1_1 = b1_1 + n*delta1_1;
        b2_1 = b2_1 + n*delta2_1;
        b3_1 = b3_1 + n*delta3_1;
        b4_1 = b4_1 + n*delta4_1;
        b5_1 = b5_1 + n*delta5_1;
    end
end

x = [0.1:1/220:1];
Y = zeros(1, length(d));

for indx=1:length(x)
        %% 3. Skaičiuojame tinklo atsaką
        % 3.1 pirmojo sluoksnio neuronas
        v1_1 = x(indx)*w11_1 + b1_1;
        v2_1 = x(indx)*w12_1 + b2_1;
        v3_1 = x(indx)*w13_1 + b3_1;
        v4_1 = x(indx)*w14_1 + b4_1;
        v5_1 = x(indx)*w15_1 + b5_1;
        %aktyvavimo f-ijos  pritaikymas
        y1_1 = 1/(1+exp(-v1_1));
        y2_1 = 1/(1+exp(-v2_1));
        y3_1 = 1/(1+exp(-v3_1));
        y4_1 = 1/(1+exp(-v4_1));
        y5_1 = 1/(1+exp(-v5_1));
        %3.2 Antrojo sluoksnio neuronui
        v1_2 = y1_1*w11_2+y2_1*w12_2+y3_1*w13_2+y4_1*w14_2+y5_1*w15_2 + b1_2;
        % aktyvavimo funkcijos pritaikymas 
        y1_2 = tanh(v1_2);
        y = y1_2;
        Y(indx) = y;
end
hold on;
plot (x, Y, 'g+'); hold off;

toc









