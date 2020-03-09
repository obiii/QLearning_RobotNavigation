    
%%
%Initilize world/state
world = 1;
gwinit(world);
gwdraw();
look_up = zeros(10,15,4);
%%

look_up(10,:,1) = -inf;
look_up(1,:,2) = -inf; 
look_up(:,15,3) = -inf; 
look_up(:,1,4) = -inf; 


%%

% init values
eps = 1;
maxEps = 1;
minEps = 0.2;
epsDecay = 0.001;
alpha = 0.2;
gamma = 0.90;

trains = 4000;

gwdraw()

tic
for epoch = 1:trains
gwinit(world);
state = gwstate();
pos_prev = state.pos;
step = 0; 


while state.isterminal==0 
step = step + 1;

[a, oa] = chooseaction(look_up, pos_prev(1), pos_prev(2), [1 2 3 4], [1/4 1/4 1/4 1/4], eps);

prevState = state;
state = gwaction(a);

r = state.feedback();
pos = state.pos();

if state.isterminal()
    break
end


Q_prev = look_up(prevState.pos(1),prevState.pos(2),a);
look_up(prevState.pos(1),prevState .pos(2), a) = ((1-alpha)*Q_prev)+alpha*(r+gamma*max(look_up(pos(1), pos(2), :)));


if(step > 1000)
   break 
end

end

eps = minEps + (maxEps-minEps)*exp(-epsDecay*epoch);

if mod(epoch, 1000) == 0
    epoch
end


end

%%

world=4

if (world == 1)
   load("world1.mat")
elseif(world == 2)
    load("world2.mat")
elseif(world == 3)
    load("world3.mat")
elseif(world == 4)
    load("world4.mat")
end
gwinit(world)
state = gwstate()
pos_prev = state.pos;
eps = 0;
isTerminal = 0;
gwdraw()
%%
gwgetpolicy(look_up)
[Vf,~] = max(look_up,[],3)
%%
while isTerminal == false

[a, oa] = chooseaction(look_up, pos_prev(1), pos_prev(2), [1 2 3 4], [1 1 1 1], 0);

act = gwaction(a);

state = gwstate();
pos = state.pos;
figure(1)
gwdraw(look_up)
pos_prev = pos;
state = state;

isTerminal = state.isterminal();


end
%%
imagesc(Vf)
colorbar
