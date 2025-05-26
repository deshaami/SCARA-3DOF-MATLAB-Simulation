function tau = gravityTorqueSCARA(theta1, theta2, L1, L2, m1, m2)
    g = 9.81; % gravity acceleration m/s^2

    % Assuming center of mass at half of each link length
    r1 = L1 / 2;
    r2 = L2 / 2;

    % Convert angles to radians for sin function
    th1 = deg2rad(theta1);
    th2 = deg2rad(theta2);

    % Torque due to gravity at joint 1
    tau1 = -g * (m1 * r1 * cos(th1) + m2 * (L1 * cos(th1) + r2 * cos(th1 + th2)));

    % Torque due to gravity at joint 2
    tau2 = -g * m2 * r2 * cos(th1 + th2);

    tau = [tau1; tau2];
end
