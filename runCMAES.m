opt.algName = 'CMAES';

opts.LBounds = -5;
opts.UBounds = 5;
opts.Restart = 3;
opts.maxFunEvals = 10000;

results = cell(1, 20);
for c = 1:20
	results{c} = zeros(20, 10);
end

for funcID = [1 3 6 10 15 20];
	disp(['Func: ', num2str(funcID)]);
	for dim = [5 10 20];
		disp(['    Dim ', num2str(dim)]);
		for i = 1:10
			fgeneric('initialize', funcID, 1, '.', opt);
			[xmin, fmin, counteval, stopflag] = cmaes('fgeneric', 4 * rand(dim, 1) - 4, rand(dim, 1));
			results{funcID}(dim, i) = fgeneric('fbest');
			fgeneric('finalize');
		end
		%[min(results);	max(results); mean(results); std(results)]
	end
end

