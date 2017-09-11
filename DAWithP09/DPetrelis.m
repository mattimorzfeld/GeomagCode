function theta = DPetrelis(theta,dt)
% one deterministic step with the model
a0 = -185;
a1 = a0/.9;
theta = theta +dt*(a0+a1*sin(2*theta));
end
