# Cournot-game
A Cournot game solver.  
  
## Introduction
Taking in each firm's marginal cost, capacity, and a ownership matrix (default to nxn identity matrix) as input,  
  
and yields the producing level of each production unit.  
  
This solver also allows firms to have sub-unit (i.e. firms will take each sub-unit's   
  
profit into its optimization problem), which is controlled by the ownership matrix.  

## Usage
````
% USAGE :cournot_game(P, b, N, mc, qbar, k)
% Demand Function : Price =  P - b*Quantity
% P     : Intercept
% b     : Slope
% N     : Number of firms
% mc    : Marginal cost for each sub-level units
% qbar  : Production Constraints of each sub-level units
% k     : A vector denotes the number of sub-level producing units of each firms, default to all-one vector.
````

