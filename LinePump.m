clear; clc; close all;

%% Parameters
rho = 830;
beta = 1.5e9;
V_line = 8e-6;
k_leak = 5e-13;
P_tank = 1e5;

%% Line pump data
A_line = 1.2e-4;
stroke_line = 1e-2;
rpm_line = 1500;
omega_line = 2*pi*(rpm_line/60);

%% Injector pump data
A_injPump = 80e-6;
stroke_inj = 4e-3;
rpm_inj = 1500;
omega_inj = 2*pi*(rpm_inj/60);

%% Plunger kinematics
x_line = @(t) (stroke_line/2)*(1 - cos(omega_line*t));
v_line = @(t) (stroke_line/2)*omega_line.*sin(omega_line*t);

x_inj  = @(t) (stroke_inj/2)*(1 - cos(omega_inj*t));
v_inj  = @(t) (stroke_inj/2)*omega_inj.*sin(omega_inj*t);

%% ODE setup (pressure dynamics)
line_rhs = @(t,P) compute_dPdt(t,P,A_line,v_line,A_injPump,v_inj,k_leak,beta,V_line,P_tank);

%% Solve pressure ODE
tstop = 0.03;
tspan = linspace(0, tstop, 3000);
P0 = P_tank;

opts = odeset('RelTol',1e-6,'AbsTol',1e-8);
[tt, PP] = ode45(line_rhs, tspan, P0, opts);
P_line = PP;

%% Flow calculations for plotting
Qin_t    = arrayfun(@(ti) A_line    * max(v_line(ti),0), tt);
QtoInj_t = arrayfun(@(ti) A_injPump * max(v_inj(ti),0), tt);
Qleak_t  = arrayfun(@(ti) k_leak    * max(P_line(find(tt==ti))-P_tank,0), tt);

%% Plots
figure('Units','normalized','Position',[0.1 0.1 0.75 0.6]);

subplot(3,1,1)   % plunger lifts
plot(tt*1000, x_line(tt)*1000,'LineWidth',1.5); hold on;
plot(tt*1000, x_inj(tt)*1000,'--','LineWidth',1.5);
ylabel('Lift (mm)');
title('Plunger Motions'); grid on;
legend('Line pump','Injector pump');

subplot(3,1,2)   % pressure trace
plot(tt*1000, P_line/1e5,'LineWidth',1.5);
ylabel('Pressure (bar)');
title('Line Pressure'); grid on;

subplot(3,1,3)   % flows
plot(tt*1000, Qin_t*1e6,'LineWidth',1.4); hold on;
plot(tt*1000, QtoInj_t*1e6,'--','LineWidth',1.4);
plot(tt*1000, Qleak_t*1e6,'-.','LineWidth',1.2);
xlabel('Time (ms)');
ylabel('Flow (µL/s)');
title('Flows'); grid on;
legend('Q_{in}','Q_{toInj}','Q_{leak}');

%% Pressure ODE function
function dPdt = compute_dPdt(t,P,A_line,v_line,A_injPump,v_inj,k_leak,beta,V_line,P_tank)
    % inflow from line pump
    Qin  = A_line    * max(v_line(t),0);

    % outflow to injector pump
    Qout = A_injPump * max(v_inj(t),0);

    % leakage to tank
    Qleak = k_leak * (P - P_tank);

    % net flow and pressure derivative
    dPdt = (beta / V_line) * (Qin - Qout - Qleak);
end
