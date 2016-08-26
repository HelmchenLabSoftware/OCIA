function p = resampleAnova(A,groups,ns)
% A ... vector with observations for all variables
% group ... grouping variable identifying group of each observation in A
% ns ... number of resamplings (determines smallest p-value possible)

% ANOVA with true group labels
[p_true,table_true,stats_true] = anova1(A,groups,'off');
F_true = table_true{2,5};

% ANOVA with resamplings
F_resample = zeros(1,ns);
if matlabpool('size')
    parfor n = 1:ns
        Aresample = zeros(1,ns);
        while true
            Aresample = A(randperm(numel(A)));
            if ~isequal(Aresample,A)
                break
            end
        end
        [p_resample,table_resample,stats_resample] = anova1(Aresample,groups,'off');
        F_resample(n) = table_resample{2,5};
    end
else
    for n = 1:ns
        while true
            Aresample = A(randperm(numel(A)));
            if ~isequal(Aresample,A)
                break
            end
        end
        [p_resample,table_resample,stats_resample] = anova1(Aresample,groups,'off');
        F_resample(n) = table_resample{2,5};
    end
end

% compare true F with resampled F values
p = (numel(find(F_resample>=F_true))+1) ./ ns;

end
