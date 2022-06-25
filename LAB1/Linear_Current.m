classdef Linear_Current < Current
    % Allows to define currents with a linear increase in their intensity
    % that starts at specified time.
    properties
        t0, scaling_factor, I0
    end
    methods
        function self = Linear_Current(t0, I0, scaling_factor)
            % t0 describes when the intensity start to increase.
            % I0 describes the initial current intensity.
            % scaling factor is multiplied at each timestep by the current
            % intensity.
            self.t0 = t0;
            self.scaling_factor = scaling_factor;
            self.I0 = I0;
        end

        function I = compute(self, t)
            if (t>self.t0)
                I=self.scaling_factor*(t-self.t0);
            else
                I=self.I0;
            end
        end
    end
end
