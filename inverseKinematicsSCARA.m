function [theta1, theta2, d3] = inverseKinematicsSCARA(x, y, z, L1, L2)
    cos_theta2 = (x^2 + y^2 - L1^2 - L2^2) / (2 * L1 * L2);
    theta2_1 = acosd(cos_theta2);      % elbow down
    theta2_2 = -acosd(cos_theta2);     % elbow up
    
    k1_1 = L1 + L2 * cosd(theta2_1);
    k2_1 = L2 * sind(theta2_1);
    theta1_1 = atan2d(y, x) - atan2d(k2_1, k1_1);
    
    k1_2 = L1 + L2 * cosd(theta2_2);
    k2_2 = L2 * sind(theta2_2);
    theta1_2 = atan2d(y, x) - atan2d(k2_2, k1_2);
    
    d3 = z;
    
    % Output both solutions:
    theta1 = [theta1_1, theta1_2];
    theta2 = [theta2_1, theta2_2];
end
