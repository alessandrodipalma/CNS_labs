classdef esn
    %ESN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        W, U, V, Nw , Nin, Nout, sparsity
    end
    
    methods
        function self = esn(n_in, n_reservoir, n_readout, ro, input_scale, sparsity)
           
            % initialize W
            self.Nw = n_reservoir;
            W = -1 + 2. * sprand(n_reservoir,n_reservoir,sparsity);
            self.W = W * (ro/ eigs(W,1));
            
            % initialize U
            self.Nin= n_in;
            U = -1 + 2. * sprand(n_reservoir, n_in, sparsity);
            self.U = U * (input_scale / norm(U));

            self.Nout = n_readout;
            self.sparsity = sparsity;

        end

        function h_t = state_transition(self, x_t, h_prev)
            h_t = tanh(self.U * x_t + self.W * h_prev);
        end

        function y_t = readout(h_t)
            y_t = self.V * h_t;
        end

        
        function [self, train_err, H, d_pred] = train(self, x, d, washout, penalty)
            % train the readout layer given the training set {(x(t),d(t))}
            
            % collect reservoir states for each element of the input 
            % sequence
            H = zeros(self.Nw, length(x));
            h_prev = zeros(size(self.U));
            for t = 1:length(x)
                h_prev = state_transition(self, x(t), h_prev);
                H(:,t) = h_prev;
            end
            
            H = H(:,washout+1:end);
 
            % train the readout
            self.V = d(:,washout+1:end)*H'*inv(H*H'+ penalty * eye(self.Nw));
            
            % compute training error
            d_pred = self.V * H;
            train_err = immse(d_pred, d(:, washout+1:end));
        end


        function Y = predict(self,initial_state, x)
            state =  initial_state;
         
            Y = zeros(1, length(x));
            for t = 1:length(x)
                state = state_transition(self, x(t), state);
                Y(:,t) = self.V*state;
            end 
        end


    end
end

