%% =====================================================
%  Diesel Engine In-Line Injection System Parameters
%  Simulink.Parameter Version (Tunable)
%  =====================================================

% Helper function (updated for new MATLAB versions)
makeParam = @(value) createParam(value);

function p = createParam(value)
    p = Simulink.Parameter(value);
    p.CoderInfo.StorageClass = 'SimulinkGlobal';   % works in all new versions
end

%% ---------------------
%  Cam Shaft Parameters
%  ---------------------

start_extend        = makeParam(0);          % rad
extend_angle        = makeParam(pi/4);       % rad
start_retract       = makeParam(7*pi/4);     % rad
retract_angle       = makeParam(pi/4);       % rad
initialization_time = makeParam(0.01);       % s
engine_speed = makeParam(100);
cam_phase_angles    = makeParam(0);  % rad, we can use this-3*pi/2, -pi/2, -pi

%% 
% Diesel Fuel Properties

diesel_fuel_temp = Simulink.Parameter(35);           % °C, initial value
diesel_fuel_temp.CoderInfo.StorageClass = 'SimulinkGlobal';

diesel_fuel_pressure = Simulink.Parameter(0.101325); % MPa, initial value
diesel_fuel_pressure.CoderInfo.StorageClass = 'SimulinkGlobal';

%% Lift Pump
preload_pressure_lift_pump = makeParam(0.45);


%% -------------------------
%  Injection Pump Geometry
%  -------------------------

cam_stroke          = makeParam(0.01);       % m
safety_gap          = makeParam(0.001);      % m
plunger_area        = makeParam(1.14e-4);    % m^2

plunger_stroke      = makeParam(0.01 + 2*0.001);   % m
plunger_initial_position = makeParam((0.01 + 2*0.001) - 0.001); % m

plunger_dead_volume = makeParam(2.6e-6);     % m^3

inlet_orifice_diameter   = makeParam(0.003);     % m
inlet_offset             = makeParam(0.001);     % m
spill_orifice_diameter   = makeParam(0.0024);    % m
delivery_valve_orifice_area = makeParam(2.1e-6); % m^2


%% -----------------
%  Injector Details
%  -----------------

injector_piston_area      = makeParam(1.4e-4);   % m^2
injector_piston_stroke    = makeParam(0.001);    % m
injector_dead_volume      = makeParam(1.45e-6);  % m^3
injector_nozzle_diameter  = makeParam(4e-4);     % m
injector_preload          = makeParam(0.015);    % m


%% ---------------------
%  Lift Pump Parameters
%  ---------------------

lift_pump_cam_eccentricity = makeParam(0.02);   % m
lift_pump_piston_area      = makeParam(0.0026); % m^2

lift_pump_piston_stroke    = makeParam(2*(0.02 + 0.001)); % m
lift_pump_initial_position = makeParam(2*0.02 + 0.001);   % m

lift_pump_dead_volume      = makeParam(21e-6);  % m^3


%% ----------------------
%  Pipeline Geometry
%  ----------------------

high_pressure_pipe_diameter = makeParam(0.003); % m
low_pressure_pipe_diameter  = makeParam(0.005); % m
lift_pump_pipe_diameter     = makeParam(0.006); % m
