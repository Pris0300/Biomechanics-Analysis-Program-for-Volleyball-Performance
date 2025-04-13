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

syms x z                   % Unused symbolic variables
ANG2 = [];                 % Array to store right leg angles
ANG3 = [];                 % Array to store left leg angles

Alt2 = (PD(:, 6));          % Coordinate (height) for right leg
Alt3 = (PI(:, 6));          % Coordinate (height) for left leg

% =========================================
% ===== RIGHT LEG ABDUCTION/ADDUCTION =====
% =========================================

for i = 1:1:264     % For each frame (sample), compute angle

    % Get coordinates from upper plaque (right leg)
    A2 = [PD(i,4) PD(i,6)]; B2 = [PD(i,10) PD(i,12)];
    u2 = A2-B2;     % Vector from plaque 2 to plaque 1

    for i = 1:1:264     % Loop again for lower plaque
    C2 = [MD(i,1) MD(i,3)]; D2 = [MD(i,7) MD(i,9)];
    v2 = D2-C2;     % Vector from plaque 1 to plaque 2
    end
    
    % Calculate angle between vectors u and v
    ang2 = (dot(u2,v2) / (norm(u2)*norm(v2)));
    Theta2 = acosd(ang2);     % Convert from radians to degrees
    ANG2 = [ANG2, Theta2];       % Append to right leg angle array
end

% =========================================
% ===== LEFT LEG ABDUCTION/ADDUCTION ======
% =========================================

for i = 1:1:264     % For each frame (sample), compute angle

    % Get coordinates from upper plaque (left leg)
    A3 = [PI(i,4) PI(i,6)]; B3 = [PI(i,10) PI(i,12)];
    u3 = A3-B3;     % Vector from plaque 2 to plaque 1
    
    for i = 1:1:264     % Loop again for lower plaque
    C3 = [MI(i,4) MI(i,6)]; D3 = [MI(i,10) MI(i,12)];
    v3 = D3-C3;   % Vector from plaque 1 to plaque 2
    end
    
    % Calculate angle between vectors u1 and v1
    ang3 = (dot(u3,v3) / (norm(u3)*norm(v3)));
    Theta3 = acosd(ang3);     % Convert from radians to degrees
    ANG3 = [ANG3, Theta3];    % Append to left leg angle array
end

% ===============================
% ======== TIME VECTOR =========
% ===============================

t = 0:0.01:2.63;   % Time range for plotting (264 frames × 0.01s = 2.63s)

% -------- ANGLE PLOT --------
subplot(2,1,1);        % First subplot for flexion-extension angles
figure(1);
plot(t, ANG2);          % Plot right leg angles
hold on; 
plot(t,ANG3);         % Plot left leg angles
hold off;
title('Angles for Abduction - Adduction (Female - A00819216)');
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
