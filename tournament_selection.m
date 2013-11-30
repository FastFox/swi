% Tournament Selection 
% returns the index from the selected Employed Bee
function employed_index = tournament_selection(employed_fitness)
    mu = length(employed_fitness); % colony size
    q = ceil(mu/2); % tournament size [Note: placeholder...]
    candidates_index = zeros(1,q);
    candidates_fitness = zeros(1,q);
    for i = 1:q
        candidates_index(i) = randi(mu);
        candidates_fitness(i) = employed_fitness(candidates_index(i));   
    end
    %[max_fitness, max_index] = max(candidates_fitness); % max_index is index of candidates vector (and not original vector)
    %employed_index = candidates_index(max_index);
    [min_fitness, min_index] = min(candidates_fitness); 
    employed_index = candidates_index(min_index);
end
