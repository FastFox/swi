datapath = '.'; 
opt.algName = 'ABC';
opt.comments = 'PUT MORE DETAILED INFORMATION, PARAMETER SETTINGS ETC';
fgeneric('initialize', 1, 1, datapath, opt);

maxEvals = 100;
dimension = 5;
populationSize = 10;
employedBees = 3;
onlookerBees = 5;
scoutBees = 2;
bestSolution = zeros(dimension, 1);
bestSolutionValue = inf;
alpha = 1;

history = zeros(maxEvals, 1);

population = randn(populationSize, dimension);
fitness = zeros(populationSize, 1);

% Originally the goal is to find the maximum of nectar, so it's an maximalization function. The bbob is (if I'm right) a minimaliation problem. 

% The employed bees search the food around the food source in their memory and pass their food information to the onlookers.
% Update each solution in the solution population


% Onlookers select good food sources from the employed bees and search around those food sources.
% Update rule works the same as in the previous stage

% Some employed bees are abandoning their food source and search for new ones.


for i = 1:populationSize
	fitness(i) = fgeneric(population(i, :)');
end

for g = 1:(maxEvels/populationSize)
	fID = 1; % should be looped for every solution
	foodSource = population(fID, :);
	neighbourFoodSource = foodSource + (-alpha + (2 * alpha * rand())) * (foodSource - population(ceil(rand() * 10), :)); % equation 1 of Gbest-guided abc...
	nectar = fgeneric(neighbourFoodSource');
	if nectar < fitness(fID)
		population(fID, :) = neighbourFoodSource;
	end

	if nectar < bestSolutionValue
      bestSolutionValue = value;
      bestSolution = solution;
	end
end

% Random search
%for i = 1:maxEvals
%	solution = randn(1, dimension);
%	value = fgeneric(solution');
%  if value < bestSolutionValue
%      bestSolutionValue = value;
%      bestSolution = solution;
%  end
%	history(i) = bestSolutionValue;
%	plot(1:i, history(1:i)');
%	drawnow
%end 

%plot(1:maxEvals, history')
