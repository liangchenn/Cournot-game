function [solution] = cournot_game(P, b, N, mc, qbar, k)
% A COURNOT GAME SOLVER
% USAGE :cournot_game(P, b, N, mc, qbar, k)
% Demand Function : Price =  P - b*Quantity
% P     : Intercept
% b     : Slope
% N     : Number of firms
% mc    : Marginal cost for each sub-level units
% qbar  : Production Constraints of each sub-level units
% k     : Number of sub-level producing units of each firms

%% DEFAULT VALUE
if nargin ==5
    k = ones(1, N); % k is default to [1, 1,.. ,1]
end

%% CONSTANT SETUPS
M = 10^6;
K = sum(k);
indq = 1;
indQ = K;
indpsi = 1+K;
indPsi = 2*K;
indu_up = indPsi + 1;
indU_up = 3*K;
indu_low = indU_up+1;
indU_low = 4*K;

%% SOLVER SETUPS
% add the path of IBM cplexlib solver
addpath('/Applications/CPLEX_Studio_Community129/cplex/examples/src/matlab');
addpath('/Applications/CPLEX_Studio_Community129/cplex/matlab/x86-64_osx');

lb = zeros(4*K, 1);  % lower bounds
ub = repmat(M,4*K, 1);  % upper bounds
ctype = [repmat('C',1,2*K) repmat('I',1,2*K)];  
Aeq = [];
beq = [];
f = zeros(4*K, 1);

%% FOC
%build ownership matrix
ownership = [];
for i = 1:length(k)
    ownership = blkdiag(ownership, ones(k(i)));
end

foc_1 = [-b*ownership - b*ones(K), -1*eye(K), zeros(K), zeros(K)];
foc_2 = [b*ownership + b*ones(K) , eye(K), zeros(K), M*eye(K)];
Aineqc = [foc_1; foc_2];

%% U lower bar

Aineq3 = [eye(K), zeros(K, 3*K)];
for i= 1:K
    Aineq3(i,indU_up+i) = -qbar(i);
end

%% U upper bar
Aineq4 = [-1*eye(K), zeros(K, 3*K)];
for i= 1:K
    Aineq4(i,indPsi+i) = qbar(i);
end

%% PSI
Aineq5 = [zeros(K), eye(K), -M*eye(K), zeros(K)];

%% Sorting 1
Aineq6 = [zeros(K, 2*K), eye(K), -1*eye(K)];


%% Sorting 2 & 3
res_matrix = [];
for n=1:length(k)
    inner_matrix = zeros(k(n)-1,k(n));
    for i=1:(k(n)-1)
        inner_matrix(i, i) = -1;
        inner_matrix(i, i+1) = 1; 
    end
    res_matrix = blkdiag(res_matrix, inner_matrix);
end
dim = size(res_matrix);
Aineq7 = [zeros(dim), zeros(dim), res_matrix, zeros(dim)];
Aineq8 = [zeros(dim), zeros(dim), zeros(dim), res_matrix];
%%
Aineq = [Aineqc; Aineq3; Aineq4; Aineq5; Aineq6; Aineq7; Aineq8];
%% inequality value (RHS)
bineqc = repmat([0], 5*K, 1);

for i=1:K
    bineqc(i) = -(P - mc(i));
    bineqc(i+K) = M+(P-mc(i));
end
bineq = [bineqc; zeros(K, 1); zeros(K-N, 1); zeros(K-N, 1)];
%% SOLVER
solution = cplexmilp(f, Aineq, bineq, Aeq, beq, [], [], [], lb, ub, ctype);

