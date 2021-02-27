within PropulsionSystem.Examples.Elements.BasicElements;

model PistonCylinderIdealOttoMV01_ex03
  extends Modelica.Icons.Example;
  //-----
  package engineAir = Modelica.Media.Air.DryAirNasa;
  //package engineAir = PropulsionSystem.Media.EngineBreathingAir.DryAirMethaneMixture00;
  //redeclare package Medium = engineAir
  //-----
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium = engineAir, T = 15 + 273.15, nPorts = 2, p = 101.325 * 1000, use_T_in = true, use_p_in = true) annotation(
    Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_fracFuel(duration = 10, height = 0, offset = 0.01, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_T1(duration = 10, height = 0, offset = 15 + 273.15, startTime = 30) annotation(
    Placement(visible = true, transformation(origin = {-130, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner PropulsionSystem.EngineSimEnvironment environment annotation(
    Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor1 annotation(
    Placement(visible = true, transformation(origin = {20, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_trq(duration = 10, height = 0, offset = 0, startTime = 50) annotation(
    Placement(visible = true, transformation(origin = {110, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary1(redeclare package Medium = engineAir, T = 15 + 273.15, nPorts = 1, p = 101.325 * 1000) annotation(
    Placement(visible = true, transformation(origin = {56, 60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PropulsionSystem.Elements.BasicElements.PistonCylinderIdealOttoMV01 PistonCylinder(redeclare package Medium = engineAir) annotation(
    Placement(visible = true, transformation(origin = {-20.3333, -10.6}, extent = {{-19.6667, -23.6}, {19.6667, 23.6}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveLinear valveLinear1(redeclare package Medium = engineAir, dp_nominal(displayUnit = "Pa") = 500, m_flow_nominal = 0.001)  annotation(
    Placement(visible = true, transformation(origin = {-60, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_throttle(duration = 10, height = -0.3, offset = 1, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveLinear valveLinear2(redeclare package Medium = engineAir, dp_nominal(displayUnit = "Pa") = 500, m_flow_nominal = 0.001) annotation(
    Placement(visible = true, transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_exhValve(duration = 10, height = -0.5, offset = 1, startTime = 30) annotation(
    Placement(visible = true, transformation(origin = {10, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 1e-3, w(fixed = true, start = 2000 * (2 * Modelica.Constants.pi / 60)))  annotation(
    Placement(visible = true, transformation(origin = {50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(
    Placement(visible = true, transformation(origin = {80, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Damper damper1(d = 1e-2)  annotation(
    Placement(visible = true, transformation(origin = {80, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation(
    Placement(visible = true, transformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_p1(duration = 10, height = 5 * 1000, offset = 101.325 * 1000, startTime = 50) annotation(
    Placement(visible = true, transformation(origin = {-130, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ramp_T1.y, boundary.T_in) annotation(
    Line(points = {{-119, 20}, {-115, 20}, {-115, 34}, {-102, 34}}, color = {0, 0, 127}));
  connect(ramp_p1.y, boundary.p_in) annotation(
    Line(points = {{-118, 50}, {-110, 50}, {-110, 38}, {-102, 38}}, color = {0, 0, 127}));
  connect(boundary.ports[1], valveLinear1.port_a) annotation(
    Line(points = {{-80, 30}, {-70, 30}, {-70, 30}, {-70, 30}}, color = {0, 127, 255}));
  connect(valveLinear1.port_b, PistonCylinder.port_1) annotation(
    Line(points = {{-50, 30}, {-40, 30}, {-40, 10}}, color = {0, 127, 255}));
  connect(ramp_throttle.y, valveLinear1.opening) annotation(
    Line(points = {{-69, 60}, {-60, 60}, {-60, 38}}, color = {0, 0, 127}));
  connect(ramp_exhValve.y, valveLinear2.opening) annotation(
    Line(points = {{21, 60}, {30, 60}, {30, 18}}, color = {0, 0, 127}));
  connect(inertia1.flange_b, damper1.flange_a) annotation(
    Line(points = {{60, -30}, {66, -30}, {66, -60}, {70, -60}, {70, -60}}));
  connect(damper1.flange_b, fixed1.flange) annotation(
    Line(points = {{90, -60}, {110, -60}, {110, -60}, {110, -60}}));
  connect(torque1.tau, ramp_trq.y) annotation(
    Line(points = {{92, -30}, {98, -30}, {98, -30}, {100, -30}}, color = {0, 0, 127}));
  connect(inertia1.flange_b, torque1.flange) annotation(
    Line(points = {{60, -30}, {70, -30}, {70, -30}, {70, -30}}));
  connect(powerSensor1.flange_b, inertia1.flange_a) annotation(
    Line(points = {{30, -30}, {40, -30}, {40, -30}, {40, -30}}));
  connect(valveLinear2.port_b, boundary1.ports[1]) annotation(
    Line(points = {{40, 10}, {56, 10}, {56, 50}, {56, 50}}, color = {0, 127, 255}));
  connect(PistonCylinder.port_2, valveLinear2.port_a) annotation(
    Line(points = {{0, 10}, {20, 10}, {20, 10}, {20, 10}}, color = {0, 127, 255}));
  connect(ramp_fracFuel.y, PistonCylinder.u_fracFuel) annotation(
    Line(points = {{-59, -30}, {-50, -30}, {-50, 3}, {-35, 3}}, color = {0, 0, 127}));
  connect(PistonCylinder.flange_2, powerSensor1.flange_a) annotation(
    Line(points = {{-1, -30}, {10, -30}}));
  annotation(
    experiment(StartTime = 0, StopTime = 70, Tolerance = 1e-06, Interval = 0.140562),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
    Diagram(coordinateSystem(extent = {{-140, -100}, {120, 100}})),
    __OpenModelica_commandLineOptions = "");
end PistonCylinderIdealOttoMV01_ex03;
