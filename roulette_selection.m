% Roulette Wheel Selection (default from Karaboga's ABC (2005))
% returns the index from the selected Employed Bee
function employed_index = roulette_selection(employed_fitness)
    sumfit = sum(employed_fitness);
    cumfit = cumsum(employed_fitness);
    r = rand() * sumfit;
    for i = 1:length(employed_fitness) % EB individuals are represented in column
        if (cumfit(i) > r)
            employed_index = i;
            break;
        end
    end
end
