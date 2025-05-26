% === Step 1: Define robot link lengths and points ===
L1 = 10;  % Length of link 1
L2 = 8;   % Length of link 2

% Define start and end positions in 3D
start_pos = [10, 0, 3];
end_pos = [15, 5, 7];

% Number of points in trajectory
numPoints = 100;

% === Step 2: Generate linear 3D path ===
x_vals = linspace(start_pos(1), end_pos(1), numPoints);
y_vals = linspace(start_pos(2), end_pos(2), numPoints);
z_vals = linspace(start_pos(3), end_pos(3), numPoints);

% === Step 3: Define inverse kinematics function ===
inverseKinematicsSCARA = @(x, y, z) deal( ...
    atan2d(y, x) - acosd((x^2 + y^2 - L1^2 - L2^2)/(2*L1*L2)), ...
    acosd((x^2 + y^2 - L1^2 - L2^2)/(2*L1*L2)), ...
    z);

% === Step 4: Calculate joint values for each path point ===
theta1_list = zeros(1, numPoints);
theta2_list = zeros(1, numPoints);
d3_list = zeros(1, numPoints);

for i = 1:numPoints
    [theta1, theta2, d3] = inverseKinematicsSCARA(x_vals(i), y_vals(i), z_vals(i));
    theta1_list(i) = theta1;
    theta2_list(i) = theta2;
    d3_list(i) = d3;
end

% === Step 5: Compute simple cost to measure smoothness ===
cost = 0;
for i = 2:numPoints
    d_theta1 = abs(theta1_list(i) - theta1_list(i-1));
    d_theta2 = abs(theta2_list(i) - theta2_list(i-1));
    d_d3     = abs(d3_list(i) - d3_list(i-1));
    
    cost = cost + d_theta1 + d_theta2 + d_d3;
end

fprintf('Total joint-space movement cost: %.2f\n', cost);

% === Step 6: Plot the 3D trajectory ===
figure;
plot3(x_vals, y_vals, z_vals, 'r-', 'LineWidth', 2);
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
title('SCARA Robot Trajectory Path');
