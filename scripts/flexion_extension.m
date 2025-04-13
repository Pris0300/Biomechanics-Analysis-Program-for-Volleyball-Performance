clc

% ===============================
% ======== DATA LOADING =========
% ===============================

PI = xlsread('Data.xlsx','A00819216_PI','A3:L266');  % Left leg initial markers
MI = xlsread('Data.xlsx','A00819216_MI','A3:L266');  % Left leg dynamic markers
PD = xlsread('Data.xlsx','A00819216_PD','A3:L266');  % Right leg initial markers
MD = xlsread('Data.xlsx','A00819216_MD','A3:L266');  % Right leg dynamic markers

% ===============================
% ======== VARIABLES INIT =======
% ===============================

syms y z                   % Unused symbolic variables (could be removed if not needed)
ANG = [];                  % Array to store right leg angles
ANG1 = [];                 % Array to store left leg angles

Alt = (PD(:, 6));          % Coordinate (height) for right leg
Alt1 = (PI(:,6));          % Coordinate (height) for left leg

% =========================================
% ===== RIGHT LEG FLEXION/EXTENSION =======
% =========================================

for i = 1:1:264     % For each frame (sample), compute angle

    % Get coordinates from upper plaque (right leg)
    A = [PD(i,5) PD(i,6)];
    B = [PD(i,11) PD(i,12)];
    u = A - B;     % Vector from plaque 2 to plaque 1

    for i = 1:1:264     % Loop again for lower plaque
        C = [MD(i,2) MD(i,3)];
        D = [MD(i,8) MD(i,9)];
        v = D - C;     % Vector from plaque 1 to plaque 2
    end

    % Calculate angle between vectors u and v
    ang = (dot(u,v) / (norm(u)*norm(v)));
    Theta = acosd(ang);       % Convert from radians to degrees
    ANG = [ANG, Theta];       % Append to right leg angle array

end

% =========================================
% ===== LEFT LEG FLEXION/EXTENSION ========
% =========================================

for i = 1:1:264     % For each frame (sample), compute angle

    % Get coordinates from upper plaque (left leg)
    A1 = [PI(i,5) PI(i,6)];
    B1 = [PI(i,11) PI(i,12)];
    u1 = A1 - B1;     % Vector from plaque 2 to plaque 1

    for i = 1:1:264     % Loop again for lower plaque
        C1 = [MI(i,5) MI(i,6)];
        D1 = [MI(i,11) MI(i,12)];
        v1 = D1 - C1;   % Vector from plaque 1 to plaque 2
    end

    % Calculate angle between vectors u1 and v1
    ang1 = (dot(u1,v1) / (norm(u1)*norm(v1)));
    Theta1 = acosd(ang1);     % Convert from radians to degrees
    ANG1 = [ANG1, Theta1];    % Append to left leg angle array

end

% ===============================
% ======== TIME VECTOR =========
% ===============================

t = 0:0.01:2.63;   % Time range for plotting (264 frames × 0.01s = 2.63s)

% ===============================
% ========= PLOTTING ============
% ===============================

% -------- ANGLE PLOT --------
subplot(2,1,1);        % First subplot for flexion-extension angles
figure(1);
plot(t, ANG);          % Plot right leg angles
hold on;
plot(t, ANG1);         % Plot left leg angles
hold off;
title('Angles for Flexion - Extension (Female - A00819216)');
xlabel('Time (s)');
ylabel('Degrees');

% Add legend for clarity
hleg1 = legend('Right leg','Left leg');
htitle1 = get(hleg1,'Title');
set(htitle1,'String','Right vs Left');
grid

% -------- HEIGHT PLOT --------
subplot(2,1,2);        % Second subplot for height over time
figure(1);
plot(t, Alt);          % Plot right leg height
hold on;
plot(t, Alt1);         % Plot left leg height
hold off;
title('Change in height');
xlabel('Time (s)');
ylabel('Height (mm)');

% Add legend for clarity
hleg1 = legend('Right leg','Left leg');
htitle1 = get(hleg1,'Title');
set(htitle1,'String','Right vs Left');
grid
