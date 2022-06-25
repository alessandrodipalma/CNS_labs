classdef Constant_Current < Current
    % Allows to create currents with constant intensity.
    properties
        I
    end
    methods

        function self = Constant_Current(I)
            self.I = I;
   
        end

        function I = compute(self, t)
            I = self.I0;
        end
    end
end
