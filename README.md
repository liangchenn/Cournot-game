# Cournot-game
A Cournot game solver.  
  
## Introduction
Taking in each firm's marginal cost, capacity, and a ownership matrix (default to n x n identity matrix) as input,  
  
and yields the producing level of each production unit.  

The output vector also contains other mid-variables used to help the calculation, 

which are put behind the equilibrium production unit, 

i.e. The output will be [Equilibrium', Mid-Vars']' (4`*`n x 1), 

where Equilibrium is an n x 1 vector denoting the equilibrium production unit.
  
This solver also allows firms to have sub-unit (i.e. firms will take each sub-unit's   
  
profit into its optimization problem), which is controlled by the ownership matrix.  
  
For the method used in the function, please see https://github.com/liangchenn/Cournot-game/blob/master/CournotGame.pdf

## Usage
````
%' USAGE :cournot_game(P, b, N, mc, qbar, k)
%' Demand Function : Price =  P - b*Quantity
%' P     : Intercept
%' b     : Slope
%' N     : Number of firms
%' mc    : Marginal cost for each sub-level units
%' qbar  : Production Constraints of each sub-level units
%' k     : A vector denotes the number of sub-level producing units of each firms, default to all-one vector.
````

