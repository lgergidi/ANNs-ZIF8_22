function [y1] = myNeuralNetworkFunction(x1)
%MYNEURALNETWORKFUNCTION neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction,
% 
% [y1] = myNeuralNetworkFunction(x1) takes these arguments:
%   x = 3xQ matrix, input #1
% and returns:
%   y = 1xQ matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.keep = [1 2];
x1_step2.xoffset = [16.04;273];
x1_step2.gain = [0.0475285171102662;0.02];
x1_step2.ymin = -1;

% Layer 1
b1 = [-2.4248711305964278928;0;-2.4248711305964278928];
IW1_1 = [1.8562135078827242118 -1.560279274089645396;1.5286930660659518999 1.8823117461679610418;-1.413995089584613174 1.9699283963206886128];

% Layer 2
b2 = [2.0191493984303714448;0;-2.0191493984303714448];
LW2_1 = [-1.1347286731301977625 1.6318265055225207316 0.35566471209844552348;-1.1620618903342725403 1.375497334813064354 -0.91355543791092652661;-1.3050159087562120952 0.51538664878635154221 1.4519897979420182121];

% Layer 3
b3 = [-2.0191493984303714448;0;-2.0191493984303714448];
LW3_2 = [1.1918744327641783709 -0.13814346072545208299 1.6239815312877159403;-0.25194910484058130606 -0.95308987156819502395 1.7621309935603204355;-0.35279487144938437293 1.1503619332987566892 1.6214707811977033813];

% Layer 4
b4 = -0.75299833536039884052;
LW4_3 = [-0.47897698583290782004 0.37927568014821799736 -0.7363386690489752695];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = 3739925575.48105;
y1_step1.xoffset = 1.23e-12;

% ===== SIMULATION ========

% Dimensions
Q = size(x1,2); % samples

% Input 1
xp1 = removeconstantrows_apply(x1,x1_step1);
xp1 = mapminmax_apply(xp1,x1_step2);

% Layer 1
a1 = relu1_apply(repmat(b1,1,Q) + IW1_1*xp1);

% Layer 2
a2 = relu1_apply(repmat(b2,1,Q) + LW2_1*a1);

% Layer 3
a3 = relu1_apply(repmat(b3,1,Q) + LW3_2*a2);

% Layer 4
a4 = repmat(b4,1,Q) + LW4_3*a3;

% Output 1
y1 = mapminmax_reverse(a4,y1_step1);
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
  y = bsxfun(@minus,x,settings.xoffset);
  y = bsxfun(@times,y,settings.gain);
  y = bsxfun(@plus,y,settings.ymin);
end

% Remove Constants Input Processing Function
function y = removeconstantrows_apply(x,settings)
  y = x(settings.keep,:);
end

% Sigmoid Symmetric Transfer Function
function a = relu1_apply(n,~)
  
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
  x = bsxfun(@minus,y,settings.ymin);
  x = bsxfun(@rdivide,x,settings.gain);
  x = bsxfun(@plus,x,settings.xoffset);
end
