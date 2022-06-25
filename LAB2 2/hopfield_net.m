classdef hopfield_net
    properties
        tol, w, state, N, M, patterns
    end
    methods
        function self = hopfield_net()
        end

        function self = learn(self, patterns)

            M = size(patterns,1);
            N = size(patterns,2);
            self.w = zeros(N,N);
            
            for mu = 1:M
                self.w = self.w + patterns(mu, :)' * patterns(mu, :);
            end

            self.N = N;
            self.M = M;
            self.patterns = patterns;
            self.w = (self.w  - M * eye(N))/N;
        end

        function [x, e_hist, m, x_hist] = retrieve(self, probe, epochs, tol, patience)
            x = probe;
            m = [];
            e_hist = [];
            x_hist = [x'];
            pat = 0;
            for e=1:epochs
                p = randperm(self.N);

                for j=1:self.N
                    x_new = x;
                    x_new(p(j)) = sign(self.w(p(j),:) * x');
                    
                    x_hist = [x_hist x_new'];
                    x = x_new;
                    m_new = zeros(self.M, 1);
                    for mu=1:self.M
                        m_new(mu) = (self.patterns(mu, :) * x') / self.N;
                    end
                    
                    m = [m m_new];
                    e_hist = [e_hist -0.5 * (x * self.w *  x')];

                    if j>1
                        if abs(e_hist(end) - e_hist(length(e_hist)-1)) < tol
                            if pat > patience
                                return
                            end
                            pat = pat+1;
                        else
                            pat = 0;
                        end
                    end
                end
            end
         
        end

    end
end