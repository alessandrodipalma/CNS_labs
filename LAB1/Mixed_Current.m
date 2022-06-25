classdef Mixed_Current < Current
    % This class allows to model complex currents sequences.
    properties
        currents, times
    end
    methods
        function self = Mixed_Current(currents, times)
            % currents: array of instances of Current.
            % times: array having same length of currents. currents(i) takes in at times(i).
            self.currents = currents;
            self.times = [times inf];
        end

        function I = compute(self, t)
            time = 1;
            while (true)
                if (t >= self.times(time) ...
                        && t < self.times(time+1))
                    I = self.currents(time).compute(t);
                    return
                else
                    time = time  + 1;
                end
            end
        end
    end
end
