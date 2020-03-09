%% Initialization
%  Initialize the world, Q-table, and hyperparameters

gwinit(3)
state = gwstate()
pos_prev = state.pos;
eps = 0;
isTerminal = 0;
gwdraw()

%%

while isTerminal == false

[a, oa] = chooseaction(look_up, pos_prev(1), pos_prev(2), [1 2 3 4], [1 1 1 1], 0);

act = gwaction(a);

state = gwstate();
pos = state.pos;

pos_prev = pos;
state_prev = state;

isTerminal = state.isterminal();
gwdraw()

end
gwplotallarrows(look_up)

%%

gwplotallarrows(look_up)

%% Training loop
%  Train the agent using the Q-learning algorithm.



%% Test loop
%  Test the agent (subjectively) by letting it use the optimal policy
%  to traverse the gridworld. Do not update the Q-table when testing.
%  Also, you should not explore when testing, i.e. epsilon=0, always pick
%  the optimal action.


