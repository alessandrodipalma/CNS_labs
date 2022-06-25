classdef Step_Current < Current
    % Allows to create step currents.
    properties
        times, I_values, I0,
        current_time
    end
    methods

        function self = Step_Current(times, I_values, I0)
            % times: array of integes describing when the intensity changes
            % from I0 to the intensities in I_values.
            % NOTE: times and I_values should have same size. Meaning: after times(i), 
            % the current assumes the value I_values(i)
            self.times = [0 times inf];
            self.I_values = [I0 I_values];
            self.I0 = I0;
            self.current_time = 1;
   
        end

        function I = compute(self, t)
            time = 1;
            while (true)
                if (t >= self.times(time) ...
                        && t < self.times(time+1))
                    I = self.I_values(time);
                    return
                else
                    time = time  + 1;
                end
            end 
        end
    end
end
