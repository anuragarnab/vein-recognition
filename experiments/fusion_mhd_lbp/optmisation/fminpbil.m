function  [bestever,verybest] = fminpbil(func, protovec)
% Usage:  [bestever,verybest] = fminpbil(func, protovec)
%
% An implementation of PBIL in the style of FMINSEARCH.
% FUNC is a string containing the name of the objective function
% PROTOVEC is any vector from the search space 
% FMINPBIL seeks a vector of real values in the range 0-1 which minimises
% FUNC; it stops if it reaches Fmin or runs out of allotted valuations.
% FUNC should expect as an input argument a vector of real values in 
% the range 0-1 (the same number as the number of elements in PROTOVEC)

% (in this implementation the only use made of PROTOVEC is to examine 
% its length to determine the number of variables in each trial solution,
% so it is immaterial what values it contains. However the program could 
% be modified to 'seed' the initial population with a likely starting 
% value or to pre-bias the probability vector; to keep this option open
% and to make the calling syntax the same as FMINSEARCH, we decided to pass
% the dummy vector PROTOVEC rather than just its length)

Fmin = -inf;               % expected minimum value of func  CHANGE THESE
prec = 12;                 % no of bits for each variable    PARAMETERS TO
ntrials =  50;             % population size                 MEET YOUR   
maxgen  =  20;             % number of generations           REQUIREMENTS

nvars = length(protovec);            % length of the bitstring
evals = 0;
fitrec=[];  						 % fitness record		
verybest= []						 % Storage of the verybest
bestever=inf;						 % initializing the best ever value
nbits=nvars*prec;                    % number of variables
bw =  2 .^((prec-1):-1:0)/2^prec;    % binary to decimal conversion factor
PV = 0.5*ones(1,nvars*prec);          % Initial unbiased probability vector

gen = 1;
  while ((bestever>Fmin)&(gen<=maxgen))
     bestfit = inf;
     for t = 1: ntrials
         ts = rand(size(PV)) <  PV;         
         x = 7 *(reshape(ts,nvars,prec) * bw'); % numbers in range 0-1
         
         %---------------------------------------------------
         f  = feval(func,x');   % evaluate each of the trial solutions
         %---------------------------------------------------
         evals = evals + 1;
        if f<bestfit		          % if it is an improvement, preserve it 
            bestfit = f;              % update the record  
            bestsol = ts;             % save the bitstring responsible
            bestx = x;                % and the corresponding real vector
        end
      end	

      LR = 0.1;                       % learning rate              
      FF = 0.005;                     % realxation (forgetting) factor  
      PV = 0.9*PV + LR*bestsol;       % Biasing generation towards bestsol
      PV = PV - FF*(PV-0.5);          % Relaxation to preserve diversity 
      %plot(PV);drawnow
      
      %fitrec = [fitrec, bestfit]	  % Keep record of the best
      if bestfit < bestever           % if the current best is better than 
         bestever = bestfit;		  % the best ever, update bestever
         besteversol = bestsol;       % save best bitstring
         bestX = bestx';              % save best real vector
      end
      
      disp('   maxgen ,   gen ,    bestfit , bestever')
      disp([maxgen,gen,bestfit,bestever])
      
   verybest = [verybest bestever];
   %plot(log(verybest),'r-');drawnow
   hold on
   
   %semilogy(verybest)
   %drawnow
gen = gen + 1;   
end
disp('Minimum attained')
disp(bestever);

disp('Best solution')
disp(bestX)

disp('Number of evaluations')
disp(evals)

disp('Number of generations')
disp(gen-1)
