function [x,fx,fnx] = ABC(CS,D,its)
% [x,fx,fnx] = ABC(its)
% Artificial Bee Colony optimization algorithm
% Runs the algorithms with colony size CS for the
% D-dimensional problem for ITS iterations and returns
%    X: the best solution found
%    FX: the value of f(X) (function to be optimized)
%    FNX: the fitness value of X
    
    n_employed = CS / 2; %number of empoyed bees
    n_onlookers = n_employed; %number of onlookers
    L = CS * D / 2; %limit
    X = rand(D,n_employed) * 10 - 5; %random initial food sources
    fit = zeros(1,n_employed);
    counter = zeros(1,n_employed);
    
    for i = 1:n_employed
        fit(i) = fitness(X(:,i));
    end
    [M,I] = max(fit);
    x_best = X(:,I);
    
    for it = 1:its
        %employed foragers
        for e = 1:n_employed
            i = e;
            j = ceil(rand() * D);
            k = ceil(rand() * n_employed);
            V = X(:,i);
            V(j) = X(j,i) + phi(X(j,i) - X(j,k));
            if (fitness(V) > fitness(X(:,i)))
                X(:,i) = V;
                counter(i) = 0;
            else
                counter(i) = counter(i) + 1;
            end
        end
        
        %onlookers
        for o = 1:n_onlookers
            % selection procedure
            %i = ceil(rand() * n_employed); 
            %i = roulette_selection(fit);      
            i = tournament_selection(fit);    
            
            j = ceil(rand() * D);
            k = ceil(rand() * n_employed);
            V = X(:,i);
            V(j) = X(j,i) + phi(X(j,i) - X(j,k));
            if (fitness(V) > fitness(X(:,i)))
                X(:,i) = V;
                counter(i) = 0;
            else
                counter(i) = counter(i) + 1;
            end
        end
        
        %scouts
        for i = 1:n_employed
            if (counter(i) > L)
                X(:,1) = rand(D,1);
            end
        end
        
        for i = 1:n_employed
            fit(i) = fitness(X(:,i));
        end
        [M,I] = max(fit);
        if (fitness(X(:,I)) > fitness(x_best))
            x_best = X(:,I); %best found so far
        end
    end
    
    x = x_best;
    fx = f(x);
    fnx = fitness(x);
end

% minimization problem: returned function value low -> high fitness
function fit = fitness(x)
    if (f(x) < 0) 
        fit = 1 + abs(f(x)); 
    else
        fit = 1 / (1 + f(x));
    end
end

function y = f(x)
    y = sum(x.^2);
end

function y = phi(x)
    y = x * ((rand() * 2) - 1);
end
