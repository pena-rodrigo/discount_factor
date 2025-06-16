%% ---------------------------------------------------------------------
%  Script : qlearn_model_v2.m
%  Purpose: Fit a simple reinforcement–learning model to a single
%           mouse’s choice behavior and visualise the result.
%           (Validation code has been removed for clarity.)
%  ---------------------------------------------------------------------
%% House-keeping
clear;              % remove everything from the workspace
clc;                % clear the command window
close all force;    % close any open figure windows

%% Parameters & bookkeeping variables
% NOTE: values shown here are the *fitted* parameters that were obtained 
alpha1     = 0.8349;    % learning-rate for Q-value update
gamma      = 0.6663;    % discount factor (memory decay)
beta_save  = 0.6104;    % inverse temperature (sensitivity) in softmax
b          = 1.5121;    % bias toward the right port
kappa      = 1.8069;    % perseveration / stay bias weight
a          = 0.6969;    % scaling term for delay discounting
mice       = 42;        % animal ID
trial      = 1;         % recording session

%% ---------------------------------------------------------------------
% 1) Load behavioural data
% ----------------------------------------------------------------------
% The files are expected to be in the current directory and to follow the
% naming scheme "<mouseID><variableName><trialID>.dat".
choice        = load([num2str(mice) 'trialtype'     num2str(trial) '.dat']);
outcome       = load([num2str(mice) 'responsetype'  num2str(trial) '.dat']).';
delay         = load([num2str(mice) 'trialdelay'    num2str(trial) '.dat']);
amount_large  = load([num2str(mice) 'amountlarge'   num2str(trial) '.dat']);
offset        = load([num2str(mice) 'trialoffset'   num2str(trial) '.dat']);
lickD         = load([num2str(mice) 'lickdirection' num2str(trial) '.dat']);
gain          = load([num2str(mice) 'gain'          num2str(trial) '.dat']);

%% ---------------------------------------------------------------------
% 2) Data cleaning / pre-processing
% ----------------------------------------------------------------------
% In the raw file: 1 = left, 2 = right, 
choice(choice == 0) = 2;          % turn 0 into 2 so “right” is unique

% Remove trials with “no response”  (outcome == 0)
badTrials = (outcome == 0);
choice( badTrials) = [];
delay(  badTrials) = [];
amount_large(badTrials) = [];
gain(   badTrials) = [];
offset( badTrials) = [];
lickD(  badTrials) = [];
outcome(badTrials) = [];

% Remove trials with “no sound” (outcome == 3)
badTrials = (outcome == 3);
choice( badTrials) = [];
delay(  badTrials) = [];
amount_large(badTrials) = [];
gain(   badTrials) = [];
offset( badTrials) = [];
lickD(  badTrials) = [];
outcome(badTrials) = [];

% Back-up copies for plotting
savechoices = choice;
saveoutcome = outcome;

%% ---------------------------------------------------------------------
% 3) Trial-by-trial auxiliary variables
% ----------------------------------------------------------------------
% Effective delay for each outcome type
delayLength = zeros(1, numel(delay));
for tr = 1:numel(delay)
    if outcome(tr) == 1                      % reward delivered immediately
        delayLength(tr) = offset(tr);
    elseif outcome(tr) == 2                  % reward delivered after delay
        delayLength(tr) = offset(tr) + delay(tr);
    end
end

%% ---------------------------------------------------------------------
% 4) Reinforcement-learning model
% ----------------------------------------------------------------------
N = numel(outcome);         % total number of valid trials
k = 2;                      % two possible actions: left (index 2) / right (index 1)

% Initialise state–action values Q( trial , option )
Q = nan(N, k);
Q(1:2, :) = 0;              % start both options at zero on first two trials

% Pre-compute hyperbolic discount term for each trial
D = 1 ./ (1 + a * delayLength);

% --- TD-style update loop ---------------------------------------------
for ind = 1:(N - 1)

    % Exponential trace decay (a la gamma)
    Q(ind + 1, :) = gamma * Q(ind, :);

    % Signed prediction error only for chosen side
    if     lickD(ind) == 1    % right chosen
        Q(ind + 1, 1) = Q(ind, 1) + alpha1 * (gain(ind) * D(ind) - Q(ind, 1));
    elseif lickD(ind) == 2    % left chosen
        Q(ind + 1, 2) = Q(ind, 2) + alpha1 * (gain(ind) * D(ind) - Q(ind, 2));
    end
end

%% ---------------------------------------------------------------------
% 5) Softmax choice rule
% ----------------------------------------------------------------------
Pr = @(Q_r, Q_l, a_prev) 1 ./ (1 + exp(-beta_save * (Q_r - Q_l) + b + kappa * a_prev));
Pl = @(Q_r, Q_l, a_prev) 1 - Pr(Q_r, Q_l, a_prev); %

% Probability the model chooses RIGHT on each trial (starting at trial 2)
probs = Pr(Q(2:end,1), Q(2:end,2), lickD(1:end-1)');

%% ---------------------------------------------------------------------
% 6) Prepare helper vectors for the figure
% ----------------------------------------------------------------------
% Vertical ticks signalling where the “larger amount” belongs
left_choice  = -100 * ones(1, numel(savechoices));
left_choice( savechoices == 1) = 2.1;        % left higher → higher y-value

right_choice = -100 * ones(1, numel(savechoices));
right_choice(savechoices == 2) = 0.9;        % right higher → lower y-value

% Rescale for aesthetic overlay in the plot
probs   = -rescale(probs, 0, 1);             % flip sign for plotting underneath
Q(:,1)  =  rescale(Q(:,1), 0.2, 0.5);
Q(:,2)  =  rescale(Q(:,2), 0.2, 0.5);

%% ---------------------------------------------------------------------
% 7) Visualisation
% ----------------------------------------------------------------------
figure('Color', 'w');

% ---- Panel 1 : behaviour & model prediction --------------------------
subplot(2,1,1)
hold on
plot(rescale(probs, 1, 2), 'g', 'LineWidth', 2);      % model prediction
stairs(smooth(lickD,5),'k')     % actual mouse choice
plot(right_choice, 'b|', 'LineWidth', 1.5);           % cue: higher reward right
plot(left_choice , 'r|', 'LineWidth', 1.5);           % cue: higher reward left
stairs(rescale(delay, 0, 0.5)       , '-.' , 'LineWidth', 2); % trial delay
stairs(rescale(amount_large,0,0.5)  , '--', 'LineWidth', 2);  % large amount

ylim([0,3]);  xlim([0, numel(choice)])
legend({'Model', 'Mouse', 'Higher reward right', ...
        'Higher reward left', 'Delay', 'Large amount'}, ...
       'Interpreter', 'latex', 'Location', 'best')
set(gca, 'YTick', [], 'FontSize', 20);

% ---- Panel 2 : Q-values and task variables ---------------------------
subplot(2,1,2)
hold on
plot(Q(:,1), 'LineWidth', 2);        % Q_r
plot(Q(:,2), 'LineWidth', 2);        % Q_l
stairs(rescale(delayLength, 0, 0.1), '-.' , 'LineWidth', 2); % realised delay
stairs(rescale(gain, 0, 0.1)      , '--', 'LineWidth', 2); % realised amount
xlim([0, numel(choice)])

legend({'$Q_r$', '$Q_l$', 'Actual delay', 'Actual amount'}, ...
       'Interpreter', 'latex', 'Location', 'best')
set(gca, 'YTick', [], 'FontSize', 20)
xlabel('Trial')

%% ---------------------------------------------------------------------
% End of script
% ----------------------------------------------------------------------