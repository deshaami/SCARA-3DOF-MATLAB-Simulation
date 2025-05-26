function [tau1, tau2] = gravityTorqueSCARA(theta1, theta2, L1, L2, m1, m2)
    g = 9.81; % gravity m/s^2

    tau1 = -g * (m1 * (L1/2) * cosd(theta1) + m2 * (L1 * cosd(theta1) + (L2/2) * cosd(theta1 + theta2)));
    tau2 = -g * m2 * (L2/2) * cosd(theta1 + theta2);
end
