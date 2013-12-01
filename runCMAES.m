opts.LBounds = -5;
opts.UBounds = 5;
opts.Restart = 3;
opts.maxFunEvals = 10000;
fgeneric('initialize', 1, 1, '.', opts);
X = cmaes('fgeneric', 10*rand(10, 1) - 5, 5, opts)
fgeneric('fbest')
fgeneric('ftarget')
fgeneric('finalize')
