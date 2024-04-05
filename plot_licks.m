count=1;
for i = 1:7
    data = load(['S_J42_2022100' num2str(i) '.mat']);
    
    trial = data.S.TrialInfo.TrialType;
    save(['42trialtype' num2str(count) '.dat'], 'trial','-ascii')
    
    response = data.S.TrialInfo.ResponseType;
    save(['42responsetype' num2str(count) '.dat'], 'response','-ascii')
    
    amountlarge = data.S.Water.PerLickLarge;
    save(['42amountlarge'  num2str(count) '.dat'], 'amountlarge','-ascii')
    
    amountsmall = data.S.Water.PerLickSmall;
    save(['42amountsmall'  num2str(count) '.dat'], 'amountsmall','-ascii')
    
    trialdelay = data.S.TrialInfo.Delay
    save(['42trialdelay'  num2str(count) '.dat'], 'trialdelay','-ascii');

    offset = data.S.TrialInfo.Offset;
    save(['42trialoffset'  num2str(count) '.dat'], 'offset','-ascii');

    lick = data.S.Lick.LickDirection;
    save(['42lickdirection'  num2str(count) '.dat'], 'lick','-ascii');

    count = count + 1;
end

for i = 25:26
    data = load(['S_J42_202209' num2str(i) '.mat']);
    
    trial = data.S.TrialInfo.TrialType;
    save(['42trialtype' num2str(count) '.dat'], 'trial','-ascii')
    
    response = data.S.TrialInfo.ResponseType;
    save(['42responsetype' num2str(count) '.dat'], 'response','-ascii')
    
    amountlarge = data.S.Water.PerLickLarge;
    save(['42amountlarge'  num2str(count) '.dat'], 'amountlarge','-ascii')
    
    amountsmall = data.S.Water.PerLickSmall;
    save(['42amountsmall'  num2str(count) '.dat'], 'amountsmall','-ascii')
    
    trialdelay = data.S.TrialInfo.Delay
    save(['42trialdelay'  num2str(count) '.dat'], 'trialdelay','-ascii');

    offset = data.S.TrialInfo.Offset;
    save(['42trialoffset'  num2str(count) '.dat'], 'offset','-ascii');

    lick = data.S.Lick.LickDirection;
    save(['42lickdirection'  num2str(count) '.dat'], 'lick','-ascii');    
    
    count = count + 1;
end

count=1;

for i = 6:9
    data = load(['S_J49_2022120' num2str(i) '.mat']);
    
    trial = data.S.TrialInfo.TrialType;
    save(['49trialtype' num2str(count) '.dat'], 'trial','-ascii')
    
    response = data.S.TrialInfo.ResponseType;
    save(['49responsetype' num2str(count) '.dat'], 'response','-ascii')
    
    amountlarge = data.S.Water.PerLickLarge;
    save(['49amountlarge'  num2str(count) '.dat'], 'amountlarge','-ascii')
    
    amountsmall = data.S.Water.PerLickSmall;
    save(['49amountsmall'  num2str(count) '.dat'], 'amountsmall','-ascii')
    
    trialdelay = data.S.TrialInfo.Delay
    save(['49trialdelay'  num2str(count) '.dat'], 'trialdelay','-ascii');

    offset = data.S.TrialInfo.Offset;
    save(['49trialoffset'  num2str(count) '.dat'], 'offset','-ascii');
    
    lick = data.S.Lick.LickDirection;
    save(['49lickdirection'  num2str(count) '.dat'], 'lick','-ascii');
    
    count = count + 1;
end

for i = 10:13
    data = load(['S_J49_202212' num2str(i) '.mat']);
    
    trial = data.S.TrialInfo.TrialType;
    save(['49trialtype' num2str(count) '.dat'], 'trial','-ascii')
    
    response = data.S.TrialInfo.ResponseType;
    save(['49responsetype' num2str(count) '.dat'], 'response','-ascii')
    
    amountlarge = data.S.Water.PerLickLarge;
    save(['49amountlarge'  num2str(count) '.dat'], 'amountlarge','-ascii')
    
    amountsmall = data.S.Water.PerLickSmall;
    save(['49amountsmall'  num2str(count) '.dat'], 'amountsmall','-ascii')
    
    trialdelay = data.S.TrialInfo.Delay
    save(['49trialdelay'  num2str(count) '.dat'], 'trialdelay','-ascii');

    offset = data.S.TrialInfo.Offset;
    save(['49trialoffset'  num2str(count) '.dat'], 'offset','-ascii');

    lick = data.S.Lick.LickDirection;
    save(['49lickdirection'  num2str(count) '.dat'], 'lick','-ascii');
    
    count = count + 1;
end

count=1;
for i = 11:23
    data = load(['S_Y19_202303' num2str(i) '.mat']);
    
    trial = data.S.TrialInfo.TrialType;
    save(['19trialtype' num2str(count) '.dat'], 'trial','-ascii')
    
    response = data.S.TrialInfo.ResponseType;
    save(['19responsetype' num2str(count) '.dat'], 'response','-ascii')
    
    amountlarge = data.S.Water.PerLickLarge;
    save(['19amountlarge'  num2str(count) '.dat'], 'amountlarge','-ascii')
    
    amountsmall = data.S.Water.PerLickSmall;
    save(['19amountsmall'  num2str(count) '.dat'], 'amountsmall','-ascii')
    
    trialdelay = data.S.TrialInfo.Delay
    save(['19trialdelay'  num2str(count) '.dat'], 'trialdelay','-ascii');

    offset = data.S.TrialInfo.Offset;
    save(['19trialoffset'  num2str(count) '.dat'], 'offset','-ascii');

    lick = data.S.Lick.LickDirection;
    save(['19lickdirection'  num2str(count) '.dat'], 'lick','-ascii');
    
    count = count + 1;
end

count=1;
for i = 22:24
    data = load(['S_SK6_202301' num2str(i) '.mat']);
    
    trial = data.S.TrialInfo.TrialType;
    save(['6trialtype' num2str(count) '.dat'], 'trial','-ascii')
    
    response = data.S.TrialInfo.ResponseType;
    save(['6responsetype' num2str(count) '.dat'], 'response','-ascii')
    
    amountlarge = data.S.Water.PerLickLarge;
    save(['6amountlarge'  num2str(count) '.dat'], 'amountlarge','-ascii')
    
    amountsmall = data.S.Water.PerLickSmall;
    save(['6amountsmall'  num2str(count) '.dat'], 'amountsmall','-ascii')
    
    trialdelay = data.S.TrialInfo.Delay
    save(['6trialdelay'  num2str(count) '.dat'], 'trialdelay','-ascii');

    offset = data.S.TrialInfo.Offset;
    save(['6trialoffset'  num2str(count) '.dat'], 'offset','-ascii');

    lick = data.S.Lick.LickDirection;
    save(['6lickdirection'  num2str(count) '.dat'], 'lick','-ascii');    
    
    count = count + 1;
end

for i = 26:27
    data = load(['S_SK6_202301' num2str(i) '.mat']);
    
    trial = data.S.TrialInfo.TrialType;
    save(['6trialtype' num2str(count) '.dat'], 'trial','-ascii')
    
    response = data.S.TrialInfo.ResponseType;
    save(['6responsetype' num2str(count) '.dat'], 'response','-ascii')
    
    amountlarge = data.S.Water.PerLickLarge;
    save(['6amountlarge'  num2str(count) '.dat'], 'amountlarge','-ascii')
    
    amountsmall = data.S.Water.PerLickSmall;
    save(['6amountsmall'  num2str(count) '.dat'], 'amountsmall','-ascii')
    
    trialdelay = data.S.TrialInfo.Delay
    save(['6trialdelay'  num2str(count) '.dat'], 'trialdelay','-ascii');

    offset = data.S.TrialInfo.Offset;
    save(['6trialoffset'  num2str(count) '.dat'], 'offset','-ascii');
    
    lick = data.S.Lick.LickDirection;
    save(['6lickdirection'  num2str(count) '.dat'], 'lick','-ascii');    
    
    count = count + 1;
end

count=1;
for i = 15:16
    data = load(['S_J51_202302' num2str(i) '.mat']);
    
    trial = data.S.TrialInfo.TrialType;
    save(['51trialtype' num2str(count) '.dat'], 'trial','-ascii')
    
    response = data.S.TrialInfo.ResponseType;
    save(['51responsetype' num2str(count) '.dat'], 'response','-ascii')
    
    amountlarge = data.S.Water.PerLickLarge;
    save(['51amountlarge'  num2str(count) '.dat'], 'amountlarge','-ascii')
    
    amountsmall = data.S.Water.PerLickSmall;
    save(['51amountsmall'  num2str(count) '.dat'], 'amountsmall','-ascii')
    
    trialdelay = data.S.TrialInfo.Delay
    save(['51trialdelay'  num2str(count) '.dat'], 'trialdelay','-ascii');

    offset = data.S.TrialInfo.Offset;
    save(['51trialoffset'  num2str(count) '.dat'], 'offset','-ascii');
    
    lick = data.S.Lick.LickDirection;
    save(['51lickdirection'  num2str(count) '.dat'], 'lick','-ascii');
    
    count = count + 1;
end

count=1;
% for i = 10:21
    data = load('S_J50_20221209.mat');
    
    trial = data.S.TrialInfo.TrialType;
    save(['50trialtype' num2str(count) '.dat'], 'trial','-ascii')
    
    response = data.S.TrialInfo.ResponseType;
    save(['50responsetype' num2str(count) '.dat'], 'response','-ascii')
    
    amountlarge = data.S.Water.PerLickLarge;
    save(['50amountlarge'  num2str(count) '.dat'], 'amountlarge','-ascii')
    
    amountsmall = data.S.Water.PerLickSmall;
    save(['50amountsmall'  num2str(count) '.dat'], 'amountsmall','-ascii')
    
    trialdelay = data.S.TrialInfo.Delay
    save(['50trialdelay'  num2str(count) '.dat'], 'trialdelay','-ascii');

    offset = data.S.TrialInfo.Offset;
    save(['50trialoffset'  num2str(count) '.dat'], 'offset','-ascii');
    
    lick = data.S.Lick.LickDirection;
    save(['50lickdirection'  num2str(count) '.dat'], 'lick','-ascii');

    count = count + 1;
% end


for i = 10:15
    data = load(['S_J50_202212' num2str(i) '.mat']);
    
    trial = data.S.TrialInfo.TrialType;
    save(['50trialtype' num2str(count) '.dat'], 'trial','-ascii')
    
    response = data.S.TrialInfo.ResponseType;
    save(['50responsetype' num2str(count) '.dat'], 'response','-ascii')
    
    amountlarge = data.S.Water.PerLickLarge;
    save(['50amountlarge'  num2str(count) '.dat'], 'amountlarge','-ascii')
    
    amountsmall = data.S.Water.PerLickSmall;
    save(['50amountsmall'  num2str(count) '.dat'], 'amountsmall','-ascii')
    
    trialdelay = data.S.TrialInfo.Delay
    save(['50trialdelay'  num2str(count) '.dat'], 'trialdelay','-ascii');

    offset = data.S.TrialInfo.Offset;
    save(['50trialoffset'  num2str(count) '.dat'], 'offset','-ascii');
    
    lick = data.S.Lick.LickDirection;
    save(['50lickdirection'  num2str(count) '.dat'], 'lick','-ascii');

    count = count + 1;
end

for i = 17:21
    data = load(['S_J50_202212' num2str(i) '.mat']);
    
    trial = data.S.TrialInfo.TrialType;
    save(['50trialtype' num2str(count) '.dat'], 'trial','-ascii')
    
    response = data.S.TrialInfo.ResponseType;
    save(['50responsetype' num2str(count) '.dat'], 'response','-ascii')
    
    amountlarge = data.S.Water.PerLickLarge;
    save(['50amountlarge'  num2str(count) '.dat'], 'amountlarge','-ascii')
    
    amountsmall = data.S.Water.PerLickSmall;
    save(['50amountsmall'  num2str(count) '.dat'], 'amountsmall','-ascii')
    
    trialdelay = data.S.TrialInfo.Delay
    save(['50trialdelay'  num2str(count) '.dat'], 'trialdelay','-ascii');

    offset = data.S.TrialInfo.Offset;
    save(['50trialoffset'  num2str(count) '.dat'], 'offset','-ascii');
    
    lick = data.S.Lick.LickDirection;
    save(['50lickdirection'  num2str(count) '.dat'], 'lick','-ascii');    
    
    count = count + 1;
end

count=1;
for i = 8:9
    data = load(['S_J44_2022100' num2str(i) '.mat']);
    
    trial = data.S.TrialInfo.TrialType;
    save(['44trialtype' num2str(count) '.dat'], 'trial','-ascii')
    
    response = data.S.TrialInfo.ResponseType;
    save(['44responsetype' num2str(count) '.dat'], 'response','-ascii')
    
    amountlarge = data.S.Water.PerLickLarge;
    save(['44amountlarge'  num2str(count) '.dat'], 'amountlarge','-ascii')
    
    amountsmall = data.S.Water.PerLickSmall;
    save(['44amountsmall'  num2str(count) '.dat'], 'amountsmall','-ascii')
    
    trialdelay = data.S.TrialInfo.Delay
    save(['44trialdelay'  num2str(count) '.dat'], 'trialdelay','-ascii');

    offset = data.S.TrialInfo.Offset;
    save(['44trialoffset'  num2str(count) '.dat'], 'offset','-ascii');
    
    lick = data.S.Lick.LickDirection;
    save(['44lickdirection'  num2str(count) '.dat'], 'lick','-ascii');    
    
    count = count + 1;
end

for i = 10:13
    data = load(['S_J44_202210' num2str(i) '.mat']);
    
    trial = data.S.TrialInfo.TrialType;
    save(['44trialtype' num2str(count) '.dat'], 'trial','-ascii')
    
    response = data.S.TrialInfo.ResponseType;
    save(['44responsetype' num2str(count) '.dat'], 'response','-ascii')
    
    amountlarge = data.S.Water.PerLickLarge;
    save(['44amountlarge'  num2str(count) '.dat'], 'amountlarge','-ascii')
    
    amountsmall = data.S.Water.PerLickSmall;
    save(['44amountsmall'  num2str(count) '.dat'], 'amountsmall','-ascii')
    
    trialdelay = data.S.TrialInfo.Delay
    save(['44trialdelay'  num2str(count) '.dat'], 'trialdelay','-ascii');

    offset = data.S.TrialInfo.Offset;
    save(['44trialoffset'  num2str(count) '.dat'], 'offset','-ascii');
    
    lick = data.S.Lick.LickDirection;
    save(['44lickdirection'  num2str(count) '.dat'], 'lick','-ascii');    
    
    count = count + 1;
end

for i = 16:18
    data = load(['S_J44_202210' num2str(i) '.mat']);
    
    trial = data.S.TrialInfo.TrialType;
    save(['44trialtype' num2str(count) '.dat'], 'trial','-ascii')
    
    response = data.S.TrialInfo.ResponseType;
    save(['44responsetype' num2str(count) '.dat'], 'response','-ascii')
    
    amountlarge = data.S.Water.PerLickLarge;
    save(['44amountlarge'  num2str(count) '.dat'], 'amountlarge','-ascii')
    
    amountsmall = data.S.Water.PerLickSmall;
    save(['44amountsmall'  num2str(count) '.dat'], 'amountsmall','-ascii')
    
    trialdelay = data.S.TrialInfo.Delay
    save(['44trialdelay'  num2str(count) '.dat'], 'trialdelay','-ascii');

    offset = data.S.TrialInfo.Offset;
    save(['44trialoffset'  num2str(count) '.dat'], 'offset','-ascii');
    
    lick = data.S.Lick.LickDirection;
    save(['44lickdirection'  num2str(count) '.dat'], 'lick','-ascii');    
    
    count = count + 1;
end