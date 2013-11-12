datapath = '.'; 
opt.algName = 'ABC';
opt.comments = 'PUT MORE DETAILED INFORMATION, PARAMETER SETTINGS ETC';
fgeneric('initialize', 1, 1, datapath, opt);

maxEvals = 100;
dimension = 5;
bestSolution = zeros(dim, 1);
bestSolutionValue = inf;

history = zeros(maxEvals, 1);

for i = 1:maxEvals
	solution = randn(dimension, 1);
	value = fgeneric(solution);
  if value < bestSolutionValue
      bestSolutionValue = value;
      bestSolution = solution;
  end
	history(i) = bestSolutionValue;
end 

plot(1:maxEvals, history')
