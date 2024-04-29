%b=0.3, kappa=2.12, beta_param=1.3;
 function accuracy = accc(b,kappa,beta_param,outcome,choice,Q,alpha,gamma)
     
        acum_pr = [];


        Pr = @(Qrin, Qlin, a) 1 ./ (1 + exp(-beta_param*(Qrin-Qlin) + b + kappa.*a));
        Pl = @(Qrin, Qlin, a) 1 - Pr(Qrin, Qlin, a);
        
        choice_a = choice; %for a parameter
        right_left = zeros(length(choice),1);
        for i = 1:length(choice)
            if(rand()<Pr(Q(i,1),Q(i,2),choice_a(i)))
                right_left(i)=1;
            else
                right_left(i)=2;
            end
            acum_pr = [acum_pr; Pr(Q(i,1),Q(i,2),choice_a(i))]; %%acum to see results
        end
   
        left_choice = -100*ones(1,length(choice));
        left_choice(choice==2)=2.1;
        right_choice = -100*ones(1,length(choice));
        right_choice(choice==1)=0.9;

        accuracy = sum(outcome==right_left)/length(outcome);
 end

