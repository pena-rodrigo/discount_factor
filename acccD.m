 function accuracy = acccD(D,b,kappa,beta_param,outcome,choice,Q,alpha,gamma)
     
        acum_pr = [];

        R_small =1;
        R_large=2;

        N = length(outcome); % number of trials
        k = length(unique(choice)); % number of options
        Q = nan(N, k); % values of each choice each trial

        Q(1, :) = 0; % initialize guesses

        for ind = 1:(N - 1) 
            Q(ind + 1, :) = gamma * Q(ind, :);
            if choice(ind) == 1
               Q(ind + 1, choice(ind)) = Q(ind, choice(ind)) + alpha * (R_small  - Q(ind, choice(ind)));
            elseif choice(ind) == 2
               Q(ind + 1, choice(ind)) = Q(ind, choice(ind)) + alpha * (R_large  - Q(ind, choice(ind)));
            elseif choice(ind) == 3
               Q(ind + 1, 2) = Q(ind, 2) + alpha * (R_large*D - Q(ind, 2));
            elseif choice(ind) == 4
               Q(ind + 1, 2) = Q(ind, 2) + alpha * (R_large*0.25 - Q(ind, 2));   
            end
        end


        Pr = @(Qrin, Qlin, a) 1 ./ (1 + exp(-beta_param*(Qrin-Qlin) + b + kappa.*a));
        Pl = @(Qrin, Qlin, a) 1 - Pr(Qrin, Qlin, a);
        
        choice_a = choice;
        right_left = zeros(length(choice),1);
        for i = 1:length(choice)
            if(rand()<Pr(Q(i,1),Q(i,2),choice_a(i)))
                right_left(i)=1;
            else
                right_left(i)=2;
            end
            acum_pr = [acum_pr; Pr(Q(i,1),Q(i,2),choice_a(i))];
        end
   
        left_choice = -100*ones(1,length(choice));
        left_choice(choice==2)=2.1;
        right_choice = -100*ones(1,length(choice));
        right_choice(choice==1)=0.9;

        accuracy = sum(outcome==right_left)/length(outcome);
 end