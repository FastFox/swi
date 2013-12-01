%function [x,fx] = ABC(func_id,CS,D,eval_budget)
function [x,fx] = ABC(func_id,CS,D,eval_budget)
% Artificial Bee Colony optimization algorithm
% Runs the algorithms with colony size CS for the
% D-dimensional problem for ITS iterations and returns
%    X: the best solution found
%    FX: the value of f(X) (function to be optimized)

		% Random should be always random
		rng('shuffle');

    % BBOB settings
    datapath = 'PUT_MY_BBOB_DATA_PATH';
    opt.algName = 'ABC';
    opt.comments = 'PUT MORE DETAILED INFORMATION, PARAMETER SETTINGS ETC';
    %func_id = 1;
    instance_id = 1;
    fgeneric('initialize', func_id, instance_id, datapath, opt);
    
%    FUNC_ID is an integer setting the fitness function to be evaluated.
%    INSTANCE_ID is the instance of the fitness function. Optimal and
%      target function value and the applied rotation(s) are different
%      for each INSTANCE_ID.

    % So, we have multiple functions, which have an ID. There are multiple instances of functions, with difference parameters. 
    % The dimensions are automaticly adjusted to the length of the solution given

    n_employed = CS / 2; % number of empoyed bees
    n_onlookers = n_employed; % number of onlookers
    L = CS * D / 2; % limit: the maximum amount of evaluations allowed before becoming scout
    X = rand(D,n_employed) * 8 - 4; % random initial food sources "Most function have their global optimum in [-4,4]^D which can be a reasonable setting for initial solutions."
    fit = zeros(1,n_employed); % the fitness of food sources
    counter = zeros(1,n_employed); % evaluation counter for each EB 
   	eval_count = 1; % Counter to keep track of amount of evaluation
		breakOut = false; % Stop process when eval_budget is is reached

    for i = 1:n_employed
        fit(i) = f(X(:,i));
				eval_count = eval_count + 1;
    end
    [fx,x] = min(fit); 

    
    while eval_count < eval_budget
        
        % Phase 1: employed foragers
        for i = 1:n_employed
            j = randi(D); % select a random variable
            k = randi(n_employed); % select a random EB
            V = X(:,i);
            V(j) = X(j,i) + phi(X(j,i) - X(j,k)); % mutate solution
            V(j) = max(-5, min(5, V(j)));
			if eval_count == eval_budget
				breakOut = true;
				break;
			end
            fitnessEvaluated = f(V);
            eval_count = eval_count + 1;
            if (fitnessEvaluated < fit(i))
                X(:,i) = V;
                fit(i) = fitnessEvaluated;
                counter(i) = 0;
            else
                counter(i) = counter(i) + 1;
            end
        end
				
        if breakOut
            break;
        end
        
        % Phase 2: onlookers
        for o = 1:n_onlookers
            i = tournament_selection(fit); % select an EB  
            
            j = randi(D); 
            k = randi(n_employed); 
            V = X(:,i);
            V(j) = X(j,i) + phi(X(j,i) - X(j,k)); 
            V(j) = max(-5, min(5, V(j)));
			if eval_count == eval_budget
				breakOut = true;
				break;
			end
            fitnessEvaluated = f(V);
            eval_count = eval_count + 1;
            if (fitnessEvaluated < fit(i))
                X(:,i) = V;
                fit(i) = fitnessEvaluated;
                counter(i) = 0;
            else
                counter(i) = counter(i) + 1;
            end
        end

      	if breakOut
			break;
		end  

        % Phase 3: scouts
        for i = 1:n_employed
            if (counter(i) > L)
    			if eval_count == eval_budget
					breakOut = true;
					break;
				end
                X(:,i) = rand(D,1) * 8 - 4;
                fit(i) = f(X(:,i));
                eval_count = eval_count + 1;
            end
        end
        
        % Finished the 3 phases, update the heuristics                
        [M,I] = min(fit);
        if (M < fx)
            x = X(:,I); %best solution found so far
            fx = M; %the corresponding best fitness
        end
    end
    
    % Find the optimal fitness and solution
    [M,I] = min(fit);
    if (M < fx)
      x = X(:,I); 
      fx = M; 
    end
    
    fgeneric('finalize');
end

function y = f(x)
	y = fgeneric(x);
end

function y = phi(x)
	y = x * ((rand() * 2) - 1);
end
