classdef Izi_model
    % Class implementing the Izihikevich equations, and allows to specify all 
    % the nedeed parameters to implement the 20 neuro-computational features.
    % Specify all the model paraemters in the constructor, then call the
    % compute method to simulate the model response to currents.

    properties
        a,b,c,d, V0, u0, V_coeff, Vmax, name, accomodation=false
    end

    methods
        function V = v_for_accomodation(self, V)
            if self.accomodation
                V = V+65;
            end
        end

        function u = u_for_accomodation(self, u)
            if self.accomodation
                u = 0;
            end
        end
        
        
        function self = Izi_model(a,b,c,d,V, V_coeff, Vmax, name)
            self.a = a;
            self.b = b;
            self.c = c;
            self.d = d;
            self.V0 = V;
            self.u0 = V*b;
            self.Vmax = Vmax;
            self.name = name;
            self.V_coeff = V_coeff;
        end


        function compute(self, tau, I_self, t0, t_end, figname)
            V = self.V0;
            u = self.u0;

            V_history = [];
            u_history = [];
            I_history = [];
            tspan = t0:tau:t_end;
            for t=tspan
                I = I_self.compute(t);
                I_history(end+1) = I;
                V = V + tau * ( ...
                    self.V_coeff(3)*V^2 + ...
                    self.V_coeff(2)*V + ...
                    self.V_coeff(1) ...
                    - u + I);
                u = u + tau * self.a * (self.b * self.v_for_accomodation(V) - self.u_for_accomodation(u));
                if V > self.Vmax
                    V_history(end+1) = self.Vmax;
                    V = self.c;
                    u = u + self.d;
                else
                    V_history(end+1)=V;
                end
                u_history(end+1)=u;

            end

            subplot(1,2,1);

            plot(tspan,V_history, tspan,I_history + (min(V_history)-max(I_history)-10));
            % axis([0 max(tspan) -90 30])
            title(append(self.name, " membrane potential VS I"));
            xlabel('time');
            ylabel('V');

            subplot(1,2,2);

            
            plot(u_history,V_history);
            title(append(self.name, " phase portrait"));
            xlabel('u');
            ylabel('V');

            savefig(figname)



        end

        function self = set_u(self, u)
            self.u0 = u;
        end


        function self = set_accomdodation(self)
            self.accomodation = true;
        end

    end
end
