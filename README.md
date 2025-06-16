# Q-Learning Model for Mouse Choice-Delay Task
This repository contains a single, self-contained MATLAB script (qlearn_behav_model.m) that

loads a behavioural session from one mouse,
cleans the raw trial data,
applies a two-option Q-learning model that includes
• exponential value decay (γ)
• hyperbolic delay discounting (a)
• soft-max action selection with bias (b) and perseveration (κ)
visualises both the animal’s choices and the model’s predictions.
The script is read-only in the sense that all free parameters have already been fitted elsewhere; it simply reproduces the model’s trajectory on the session you specify.

Quick start
MATLAB

% Inside MATLAB
>> edit qlearn_behav_model      % optional – inspect / modify
>> qlearn_behav_model           % run it
A figure with two stacked panels (behaviour vs. model; Q-values vs. task variables) should appear.

Folder / file layout

.
├── qlearn_behav_model.m       # main script
├── data/                   # ← put your .dat files here (or in pwd)
│   ├── 42trialtype1.dat
│   ├── 42responsetype1.dat
│   └── …
└── README.md               # this file
Required data files
For one recording session the script expects seven ASCII .dat files named as

<mouseID><variableName><sessionID>.dat
Example for mouse 42, session 1:

variableName	meaning (vector length = number of trials)
trialtype	1 = left large/short, 2 = right large/short, 0 = right (legacy)
responsetype	0 = no response, 1 = reward immed., 2 = reward after delay, 3 = no sound
trialdelay	imposed delay (s) if outcome = 2
amountlarge	water amount (µL) for the “large” side
trialoffset	ITI offset for each trial (s)
lickdirection	1 = right lick, 2 = left lick
gain	reward magnitude actually obtained (µL)
Put the files either in the working directory or update the load paths in the script.

Editing the session to run
Inside qlearn_model_v2.m change

MATLAB

mice  = 42;   % animal ID
trial = 1;    % session number
to the IDs corresponding to the files you want to analyse.

Software requirements
• MATLAB R2018a or newer (only core functions are used).
• No external toolboxes required.

Parameter table (pre-fitted values)
symbol	description	value
α	learning rate	0.8349
γ	exponential decay of Q	0.6663
β	inverse temperature (soft-max)	0.6104
b	static bias towards right port	1.5121
κ	perseveration weight (stay bias)	1.8069
a	hyperbolic delay discount factor	0.6969
If you wish to re-fit these parameters to your own data, simply treat them as free variables and wrap the script in an optimisation routine (e.g. fmincon on negative log-likelihood).

Citation
If you use this code in a publication, please cite the repository and the original behavioural paradigm, e.g.,
“Data and analysis code are available at https://github.com/pena-rodrigo/discount_factor”

License
MIT License – see LICENSE for details.

Feel free to open issues or submit pull requests!
