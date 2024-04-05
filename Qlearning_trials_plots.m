% fitting a learning model
%%%working in this code without the validation

close all
clear all
accuracy=[];

acum_pr = [];
mice = 42; %or 42


% for cross=1 
    for trial = 1:1 %this is session and not trial
        
        choice = load([num2str(mice) 'trialtype' num2str(trial) '.dat']);
        outcome = load([num2str(mice) 'responsetype' num2str(trial) '.dat'])';
        delay = load([num2str(mice) 'trialdelay' num2str(trial) '.dat']);
  
        amount_small = load([num2str(mice) 'amountsmall' num2str(trial) '.dat']);
        amount_large = load([num2str(mice) 'amountlarge' num2str(trial) '.dat']);
        
        offset = load([num2str(mice) 'trialoffset' num2str(trial) '.dat']);
        
        lickD = load([num2str(mice) 'lickdirection' num2str(trial) '.dat']);

        %%%cleaning the data
        %%%right choices are marked 2
        choice(choice==0)=2;

        %%%remove outcome=0 no response from all data
        choice(outcome==0)=[];
        delay(outcome==0)=[];
        amount_large(outcome==0)=[];
        amount_small(outcome==0)=[];
        offset(outcome==0)=[];
        lickD(outcome==0)=[];
        outcome(outcome==0)=[];


        %%%remove outcome=3 no sound from all data
        choice(outcome==3)=[];
        delay(outcome==3)=[];
        amount_large(outcome==3)=[];
        amount_small(outcome==3)=[];
        offset(outcome==3)=[];
        lickD(outcome==3)=[];
        outcome(outcome==3)=[];
        amount_diff = amount_large - amount_small;

        % %%%remove outcome=4 error from all data
        % outcome(choice==4)=[];
        % delay(choice==4)=[];
        % choice(choice==4)=[];
        % offset(choice==4)=[];
        % amount_large(choice==4)=[];

        savechoices = choice;
        choice(delay>0) = 3; %%these are trials with delays I mark with 3
        choice(amount_large<1)=4; %these trials with less large reward I mark with 4
        
        saveoutcome = outcome;
        % outcome(delay>0) = 3; %%these are trials with delays I mark with 3
        % outcome(amount_large<1)=4; %these trials with less large reward I mark with 4
            
        delayLength = zeros(1,length(delay));
        for tr = 1:length(delay)
            if outcome(tr) == 1
                delayLength(tr) = offset(tr);
            elseif outcome(tr) == 2
                delayLength(tr) = offset(tr) + delay(tr);
            end
        end

        outcome(delay>1)=3; %%these are trials with delays I mark with 3
        outcome(amount_large<1)=4; %these trials with less large reward I mark with 4
            
        

        [alpha_save,gamma_save,beta_save,b,kappa,beta_param,De] = paramf(outcome,choice,saveoutcome);
        % De
        outcome=saveoutcome;
        %%%%%
        N = length(outcome); % number of trials
        k = 2; % number of options
        Q = nan(N, k); % values of each choice each trial
        
        Q(1, :) = 1; % initialize guesses]
        Q(2, :) = 1; % initialize guesses]
        gamma = gamma_save;
        alpha1 = alpha_save;
        R_small=1;
        R_large=2;
        % D = 1-1./delay;
        % D(isinf(D))=1;
        % D(delayLength>1)
        D = ones(1,length(delayLength));
        D(delayLength>1)= De;
        D(delayLength==0.5)=0.6;
        D(delayLength<0.5)=0.5*De;
        for ind = 1:(N - 1) 
            Q(ind + 1, :) = gamma * Q(ind, :); 
            if outcome(ind) == 1
               Q(ind + 1, outcome(ind)) = Q(ind, outcome(ind)) + alpha1 * (R_small*D(ind) - Q(ind, outcome(ind)));
            elseif outcome(ind) == 2
               Q(ind + 1, outcome(ind)) = Q(ind, outcome(ind)) + alpha1 * (R_large*D(ind)*amount_diff(ind)  - Q(ind, outcome(ind)));
            end
        end

        Q(:,1) = rescale(Q(:,1),0,1);
        Q(:,2) = rescale(Q(:,2),0,1);
    
        Pr = @(Qrin, Qlin, a) 1 ./ (1 + exp(-beta_param*(Qrin-Qlin) + b));
        Pl = @(Qrin, Qlin, a) 1 - Pr(Qrin, Qlin, a);
        
        choice_a = savechoices;
        right_left = ones(length(choice),1);
        probs = rescale(Pr(Q(:,1),Q(:,2),outcome(:)),0,1);
        for i = 2:length(choice)-1
            right_left(i)=right_left(i-1);
            if(probs(i)<0.5)
                right_left(i)=2;
            elseif(1-probs(i)<0.5)
                right_left(i)=1;
            end
            acum_pr = [acum_pr; Pr(Q(i,1),Q(i,2),choice_a(i))]; 
        end
    

        left_choice = -100*ones(1,length(savechoices));
        left_choice(savechoices==2)=2.1;
        right_choice = -100*ones(1,length(savechoices));
        right_choice(savechoices==1)=0.9;

        accuracy = sum(outcome==right_left)/length(outcome);
    end

Q(:,1) = rescale(Q(:,1),0.2,0.8);
Q(:,2) = rescale(Q(:,2),0.2,0.8);
plot(Q(:,2),'LineWidth',2); hold on;
plot(Q(:,1),'LineWidth',2); hold on;
legend('$Q_r$','$Q_l$','Interpreter','Latex')
xlabel('Trial')
set(gca,'fontsize',20);


f = figure(1);
plot(rescale(-probs,1,2),'g','LineWidth',2); hold on
ylim([0,3])
plot(rescale(outcome,1,2),'k','LineWidth',1);
plot(right_choice,'r|'); hold on;
plot(left_choice,'b|')
set(gca,'YTickLabel',[]);
set(gca,'ytick',[])
xlabel('Trial')
set(gca,'fontsize',20);
xlim([20,400])

plot(delay,'--','LineWidth',2); hold on;
% plot(amount_diff,'-.','LineWidth',2)
% plot(amount_large,'--','LineWidth',2)
legend('Qr','Ql','Model','Mouse','Higher reward right','Higher reward left','delay')%,'Low Larger Reward')
% % 

idchangesup = find(diff(right_choice)>0);
idchangesdown = find(diff(right_choice)<0);
idchangesdelay = find(diff(delay)>1);

for i = 1:length(idchangesdelay)
    idchangesup(find(idchangesup==idchangesdelay(i)))=[];
    idchangesdown(find(idchangesdown==idchangesdelay(i)))=[];
end

prup = zeros(1,7);
prupdelay = zeros(1,7);
outu = zeros(1,11);
outdelay = zeros(1,11);
for i = 1:length(idchangesup) 
    prup = prup + (probs(idchangesup(i):idchangesup(i)+6))'; 
    if(lickD(idchangesup(i)-4) < 0.1)
        outu = outu + (lickD(idchangesup(i)-4:idchangesup(i)+6)); 
    else
        outu = outu + (-lickD(idchangesup(i)-4:idchangesup(i)+6) + 0.5); 
    end
end

for i = 1:length(idchangesdelay) 
    prupdelay = prupdelay + (probs(idchangesdelay(i):idchangesdelay(i)+6))'; 
    % outdelay = outdelay + (lickD(idchangesdelay(i)-4:idchangesdelay(i)+6)); 
    if(lickD(idchangesdelay(i)-4) < 0.1)
        outdelay = outdelay + (lickD(idchangesdelay(i)-4:idchangesdelay(i)+6)); 
    else
        outdelay = outdelay + (-lickD(idchangesdelay(i)-4:idchangesdelay(i)+6) + 0.5); 
    end
end

for i = 1:length(idchangesdelay) 
    if(lickD(idchangesdelay(i)-4) < 0.1)
        plot(lickD(idchangesdelay(i)-4:idchangesdelay(i)+6)); hold on;
    else
        plot(-lickD(idchangesdelay(i)-4:idchangesdelay(i)+6) + 0.5); hold on;
    end
end

prup = prup./(length(idchangesup));% - prup(1);
prupdelay = prupdelay./length(idchangesdelay);
outu = outu./length(idchangesup);
outdelay = outdelay./length(idchangesdelay);
figure; plot(prup- prup(1),'LineWidth',2); hold on; plot(prupdelay-prupdelay(1),'LineWidth',2)
legend('No delay','Delay')
xlabel('trials from block switch')
set(gca,'fontsize',20);

figure; plot(outu,'LineWidth',2); hold on; plot(outdelay,'LineWidth',2)

%%%%%
% % idchangesdown = find(diff(right_choice)<0);
% % idchangesdelay = find(diff(delay)>0);
% % 
% % for i = 1:length(idchangesdelay)
% %     idchangesdown(find(idchangesdown==idchangesdelay(i)))=[];
% % end
% % 
% % prup = zeros(1,6);
% % prupdelay = zeros(1,6);
% % outu = zeros(1,6);
% % outdelay = zeros(1,6);
% % for i = 1:length(idchangesup) 
% %     prup = prup + (probs(idchangesdown(i)-1:idchangesdown(i)+4))'; 
% %     outu = outu + (outcome(idchangesdown(i)-1:idchangesdown(i)+4))'; 
% % end
% % for i = 1:length(idchangesdelay) 
% %     prupdelay = prupdelay + (probs(idchangesdelay(i)-1:idchangesdelay(i)+4))'; 
% %     outdelay = outdelay + (outcome(idchangesdelay(i)-1:idchangesdelay(i)+4))'; 
% % end
% % prup = prup./length(idchangesdown);
% % prupdelay = prupdelay./length(idchangesdelay);
% % outu = outu./length(idchangesdown);
% % outdelay = outdelay./length(idchangesdelay);
% % figure; plot(rescale(prup,0,1)); hold on; plot(rescale(prupdelay,0,1))

% figure; plot(rescale(-outu,0,1)); hold on; plot(rescale(-outdelay,0,1))

% idchangesdown = find(diff(outcome)==-1);
% prud = zeros(1,7);

% % outd = zeros(1,7);
% for i = 1:1%length(idchangesdown) 
%      prud = prud + (probs(idchangesdown(i)-5:idchangesdown(i)+1))'; 
% %     outd = outd + (outcome(idchangesdown(i)-5:idchangesdown(i)+1))'; 
% end
% prud = prud./length(idchangesdown);
% outd = outd./length(idchangesdown);
% 
% for i = 1:length(idchangesup) 
% % %     plot(rescale(-probs(idchangesdown(i)-2:idchangesdown(i)+2),1,2),'g'); hold on;
% % %     plot(outcome(idchangesdown(i)-2:idchangesdown(i)+2),'k'); hold on;
% % end
%      prup = prup + (probs(idchangesup(i)-5:idchangesup(i)+1))'; 
%      outu = outu + (outcome(idchangesup(i)-5:idchangesup(i)+1))'; 
% end
% prup = prup./length(idchangesup);
% outu = outu./length(idchangesup);
% 
% subplot(2,1,1)
% plot(rescale(outcome(idchangesdown(i)-5:idchangesdown(i)+1),1,2),'k')
% hold on; 
% plot(rescale(prup,1,2),'g')
% subplot(2,1,2)
% plot(rescale(outcome(idchangesup(i)-5:idchangesup(i)+1),1,2), 'k' )
% hold on; 
% plot(rescale(prud,1,2),'g')
