function out = Q_model_Rewards(alpha, choice, outcome,par_gamma)
% reinforcement learning model with forgetting
% alpha is the learning rate, gamma is the discount factor

% gamma=alpha;%par_gamma;
if par_gamma~=3.5e-7 %fit the gamma
    gamma = alpha;
    alpha1=0.0001;
else
   gamma=par_gamma;
   alpha1 = alpha;
end

R_small =1;
R_large=2;

N = length(outcome); % number of trials
k = length(unique(choice)); % number of options
Q = nan(N, k); % values of each choice each trial
Qthis = nan(N, 1); % value of the chosen option

Q(1, :) = 0; % initialize guesses

for ind = 1:(N - 1) 
    % ind
    % copy forward action values to the next trial with forgetting
    Q(ind + 1, :) = gamma * Q(ind, :);
    
    % update option chosen on this trial for the next trial's choice
    % Q(ind + 1, choice(ind)) = Q(ind, choice(ind)) + alpha * (outcome(ind) - Q(ind, choice(ind)));   

    % update option chosen on this trial for the next trial's choice
    % include action-specific rewards
    if choice(ind) == 1
       Q(ind + 1, choice(ind)) = Q(ind, choice(ind)) + alpha1 * (R_small  - Q(ind, choice(ind)));
    elseif choice(ind) == 2
       Q(ind + 1, choice(ind)) = Q(ind, choice(ind)) + alpha1 * (R_large  - Q(ind, choice(ind)));
    elseif choice(ind) == 3
       Q(ind + 1, 2) = Q(ind, 2) + alpha1 * (R_large*0.01 - Q(ind, 2));
    elseif choice(ind) == 4
       Q(ind + 1, 2) = Q(ind, 2) + alpha1 * (R_large*0.25 - Q(ind, 2));   
    end
end

% return vector of action values for each trial
out = Q;