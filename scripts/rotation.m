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

syms x y                   % Unused symbolic variables
ANG4 = [];                 % Array to store right leg angles
ANG5 = [];                 % Array to store left leg angles

Alt4 = (PD(:, 6));          % Coordinate (height) for right leg
Alt5 = (PI(:, 6));          % Coordinate (height) for left leg

% =========================================
% ========== RIGHT LEG ROTATION ===========
% =========================================

for i = 1:1:264     % For each frame (sample), compute angle
    
    % Get coordinates from upper plaque (right leg)
    A4 = [PD(i,4) PD(i,5)]; B4 = [PD(i,10) PD(i,11)];
    u4 = A4-B4;     % Vector from plaque 2 to plaque 1
    
    for i = 1:1:264     % Loop again for lower plaque
    C4 = [MD(i,1) MD(i,2)]; D4 = [MD(i,7) MD(i,8)];
    v4 = D4-C4;     % Vector from plaque 1 to plaque 2
    end
    
    % Calculate angle between vectors u and v
    ang4 = (dot(u4,v4) / (norm(u4)*norm(v4)));
    Theta4 = acosd(ang4);     % Convert from radians to degrees
    ANG4 = [ANG4, Theta4];       % Append to right leg angle array
end

% =========================================
% ========== LEFT LEG ROTATION ===========
% =========================================

for i = 1:1:264     % For each frame (sample), compute angle
    
    % Get coordinates from upper plaque (left leg)
    A5 = [PI(i,4) PI(i,5)]; B5 = [PI(i,10) PI(i,11)];
    u5 = A5-B5;     % Vector from plaque 2 to plaque 1
    
    for i = 1:1:264     % Loop again for lower plaque
    C5 = [MI(i,4) MI(i,5)]; D5 = [MI(i,10) MI(i,11)];
    v5 = D5-C5;   % Vector from plaque 1 to plaque 2
    end
    
    % Calculate angle between vectors u1 and v1
    ang5 = (dot(u5,v5) / (norm(u5)*norm(v5)));
    Theta5 = acosd(ang5);     % Convert from radians to degrees
    ANG5 = [ANG5, Theta5];    % Append to left leg angle array
end

% ===============================
% ======== TIME VECTOR =========
% ===============================

t = 0:0.01:2.63;   % Time range for plotting (264 frames × 0.01s = 2.63s)

% -------- ANGLE PLOT --------
subplot(2,1,1);        % First subplot for flexion-extension angles
figure(1);
plot(t, ANG4);          % Plot right leg angles
hold on;
plot(t,ANG5);         % Plot left leg angles
hold off;
title('Angles of Rotation (Female - A00819216)');
xlabel('Time (s)');
ylabel('Degrees');

% Add legend for clarity
hleg1 = legend('Right leg','Left leg');
htitle1 = get(hleg1,'Title');
set(htitle1,'String','Right vs Left');
grid

% -------- HEIGHT PLOT --------
subplot(2,1,2);       % Second subplot for height over time
figure(1);
plot(t, Alt4);          % Plot right leg height
hold on;
plot(t,Alt5);         % Plot left leg height
hold off;
title('Change in height');
xlabel('Time (s)');
ylabel('Height (mm)');

% Add legend for clarity
hleg1 = legend('Right leg','Left leg');
htitle1 = get(hleg1,'Title');
set(htitle1,'String','Right vs Left');
grid


