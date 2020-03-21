within PropulsionSystem.Examples.Elements.BasicElements;

model TrbCharFixed00_ex02
  extends Modelica.Icons.Example;
  //-----
  package engineAir = Modelica.Media.Air.DryAirNasa;
  //redeclare package Medium = engineAir
  //-----
  inner PropulsionSystem.EngineSimEnvironment environment annotation(
    Placement(visible = true, transformation(origin = {-50, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium = engineAir, T = 1600, nPorts = 1, p = 20 * 101.325 * 1000) annotation(
    Placement(visible = true, transformation(origin = {-50, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T boundary1(redeclare package Medium = engineAir, T = 288.15, m_flow = -10, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {50, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PropulsionSystem.Elements.BasicElements.TrbCharFixed00 Trb1(redeclare package Medium = engineAir, switchDetermine_PR = PropulsionSystem.Types.switches.switchHowToDetVar.asCalculated, switchDetermine_eff = PropulsionSystem.Types.switches.switchHowToDetVar.viaRealInput) annotation(
    Placement(visible = true, transformation(origin = {10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed1(w_fixed = 3000 * 2.0 * Modelica.Constants.pi / 60.0) annotation(
    Placement(visible = true, transformation(origin = {-90, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_eff(duration = 10, height = 0, offset = 0.8, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-10, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor1 annotation(
    Placement(visible = true, transformation(origin = {-60, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PropulsionSystem.Utilities.SetConstraint setConstraint1 annotation(
    Placement(visible = true, transformation(origin = {-52, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Ramp ramp_pwr(duration = 10, height = 1000 * 1000, offset = 3000 * 1000, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-52, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(powerSensor1.flange_a, Trb1.flange_1) annotation(
    Line(points = {{-50, 20}, {2.08615e-06, 20}, {2.08615e-06, 20}, {2.08615e-06, 20}}));
  connect(ramp_eff.y, Trb1.u_eff) annotation(
    Line(points = {{1, -40}, {10, -40}, {10, 14}}, color = {0, 0, 127}));
  connect(boundary.ports[1], Trb1.port_1) annotation(
    Line(points = {{-40, 60}, {-34, 60}, {-34, 28}, {0, 28}}, color = {0, 127, 255}));
  connect(Trb1.port_2, boundary1.ports[1]) annotation(
    Line(points = {{20, 28}, {30, 28}, {30, 60}, {40, 60}}, color = {0, 127, 255}));
  connect(ramp_pwr.y, setConstraint1.u_targetValue) annotation(
    Line(points = {{-52, -29}, {-52, -29}, {-52, -25}, {-52, -25}}, color = {0, 0, 127}));
  connect(powerSensor1.power, setConstraint1.u_variable) annotation(
    Line(points = {{-52, 9}, {-52, 9}, {-52, 1}, {-52, 1}}, color = {0, 0, 127}));
  connect(constantSpeed1.flange, powerSensor1.flange_b) annotation(
    Line(points = {{-80, 20}, {-70, 20}, {-70, 20}, {-70, 20}}));

annotation(
    experiment(StartTime = 0, StopTime = 40, Tolerance = 1e-6, Interval = 0.08),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
  Diagram(graphics = {Text(origin = {-34, 11}, extent = {{-12, 5}, {22, -3}}, textString = "pwr, trq are given"), Text(origin = {32, 1}, extent = {{-12, 5}, {22, -3}}, textString = "PR is calculated"), Text(origin = {18, -49}, extent = {{-12, 5}, {18, -1}}, textString = "eff is given"), Line(origin = {1, 1}, points = {{-13, 7}, {15, 1}}, arrow = {Arrow.None, Arrow.Open})}));
  
end TrbCharFixed00_ex02;
