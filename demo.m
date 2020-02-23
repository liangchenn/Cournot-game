%  cournot_game(1200, 2, 2, [100,200,200],[300,100,100],[2,1])
cournot_game(1200, 2, 2, [100,200,200],[300,100,100], [2, 1])

%% 11 firm
P = 4000;
b=2;
qbar = [300,300,300,300,300, 100,100,100,100,100,100];
mc   = [100,100,100,100,100, 200,200,200,200,200,200];
N =11;
cournot_game(P, b, N, mc, qbar)
% consistent with answer





%% 42 Firms
firms = readtable('./cournotgamedata.csv');
%%
qbar = firms.capacity;
mc = firms.total_var_cost;
k = [5,8,6,7,6,5,5];
% game 1
P = 15819/5.48;
b = 1/5.48;


solutions_general = cournot_game(P, b, 42, mc, qbar);



%%
res = solutions_general(1:42);
firms.game4s = res;
%%

writetable(firms, './generalcournotresult.csv')

%%
solutions_simple  = cournot_game(P, b, 42, mc, qbar);
sol = getOptimalSolution(P,b,42,qbar,mc);
%%

Q = sum(solutions_simple(1:42));

