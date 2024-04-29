
 function [alpha_save,gamma_save,beta_save,b,kappa,beta_param,D] = paramf(outcome,choice,saveoutcome)

        lb = 0;
        ub = 1; 
        lb = [-1, lb];
        ub = [1, ub];
        Qfun = add_perseveration(@Q_model_Rewards);
        numiter = 100;
        [beta, LL, Q] = rlfit(Qfun, choice, outcome, lb, ub, numiter,0.1,0.01); 
        gamma_save = beta(2);
        [beta, LL, Q] = rlfit(Qfun, choice, outcome, lb, ub, numiter,3.5e-7,0.01);
        alpha_save = beta(2);
        beta_save = beta;
        outcome=saveoutcome;
        firstparam = linspace(0.1,1,20); 
        secondparam = linspace(1,10,20);   
        thirdparam = linspace(0.01,1,20);
        [F,S,T] = ndgrid(firstparam, secondparam, thirdparam);
        fitresult = arrayfun(@(p1,p2,p3) accc(p1,p2,p3,outcome,choice,Q,alpha_save,gamma_save), F, S,T); 
        maximum = max(max(fitresult));
        [x,y,z]=find(fitresult==maximum);
        x=x(1);y=y(1);z=z(1);
        bestFirst = F(x,y,z);
        bestSecond = S(x,y,z);
        bestThird = T(x,y,z);
        b=bestFirst; kappa=bestSecond; beta_param=bestThird;
        firstparam = linspace(0.01,1,50); 
        [F] = ndgrid(firstparam);
        fitresult = arrayfun(@(p1) acccD(p1,b,kappa,beta_param,outcome,choice,Q,alpha_save,gamma_save), F); 
        maximum = max(max(fitresult));
        [x]=find(fitresult==maximum);
        x=x(1);
        bestFirst = F(x);
        D = bestFirst;
        
