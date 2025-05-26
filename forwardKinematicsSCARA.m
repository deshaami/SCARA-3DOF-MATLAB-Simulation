function [x, y, z] = forwardKinematicsSCARA(theta1, theta2, d3, L1, L2)
    x = L1*cosd(theta1) + L2*cosd(theta1 + theta2);
    y = L1*sind(theta1) + L2*sind(theta1 + theta2);
    z = d3;
end
