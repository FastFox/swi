clear all;

funcID = [1 3 6 10 15 20];
dim = [5 10 20];

for f = 1:length(funcID)
    for d = 1:length(dim)
        optimal_fitness = zeros(10,1); 
        for i = 1:10
           [xopt, fopt] = ABC_original(funcID(f),20,dim(d),10000); 
           optimal_fitness(i,1) = fopt;
        end
        
        fopt_best = min(optimal_fitness);
        fopt_worst = max(optimal_fitness);
        fopt_mean = mean(optimal_fitness);
        fopt_std = std(optimal_fitness, 1);

        % 'testje' is name of an existing directory: rename it to anything you want
        save( ['testje/' ['fun' int2str(funcID(f)) '_dim' int2str(dim(d))]], 'fopt_best','fopt_worst','fopt_mean','fopt_std','optimal_fitness');
    end
end
