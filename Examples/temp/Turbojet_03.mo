within PropulsionSystem.Examples.temp;

model Turbojet_03
  extends Modelica.Icons.Example;
  package engineAir = Modelica.Media.Air.DryAirNasa;
  //-----
  PropulsionSystem.Elements.BasicElements.FlightToEngine flightToEngine1(redeclare package Medium = engineAir, MN = 0.8, alt = 10000) annotation(
    Placement(visible = true, transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //-----
  Modelica.Blocks.Sources.Ramp ramp_TIT(duration = 10, height = 200, offset = 1600, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  inner EngineSimEnvironment environment annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Elements.BasicElements.CmpCharTable00 Cmp(redeclare package Medium = engineAir) annotation(
    Placement(visible = true, transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Elements.BasicElements.TrbCharTable00 Trb(redeclare package Medium = engineAir) annotation(
    Placement(visible = true, transformation(origin = {80, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Elements.BasicElements.NzlCharFixed00 Nzl(redeclare package Medium = engineAir, AmechTh_paramInput = 0.0014, switchDetermine_AmechTh = PropulsionSystem.Types.switches.switchHowToDetVar.param) annotation(
    Placement(visible = true, transformation(origin = {140, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium = engineAir) annotation(
    Placement(visible = true, transformation(origin = {50, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  FluidSystemComponents.Utilities.VariableBySolver VarBySolver annotation(
    Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  FluidSystemComponents.Utilities.ConstrainVariable Constraint annotation(
    Placement(visible = true, transformation(origin = {70, 40}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  PropulsionSystem.Elements.BasicElements.CombCharFixed00 Comb(redeclare package Medium = engineAir, use_u_m_flow_fuel = true)  annotation(
    Placement(visible = true, transformation(origin = {30, 10}, extent = {{-10, -8}, {10, 8}}, rotation = 0)));
  PropulsionSystem.Elements.BasicElements.InltCharFixed00 Inlt(redeclare package Medium = engineAir) annotation(
    Placement(visible = true, transformation(origin = {-30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Elements.BasicElements.EnginePerformance00 Perf annotation(
    Placement(visible = true, transformation(origin = {190, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Inlt.y_FdRam, Perf.u_Fram) annotation(
    Line(points = {{-23, -14}, {-16, -14}, {-16, -46}, {178, -46}}, color = {0, 0, 127}));
  connect(flightToEngine1.port_fluid2Eng, Inlt.port_1) annotation(
    Line(points = {{-80, -2}, {-40, -2}}, color = {0, 127, 255}));
  connect(Inlt.port_2, Cmp.port_1) annotation(
    Line(points = {{-20, -2}, {-10, -2}}, color = {0, 127, 255}));
  connect(flightToEngine1.V_tot_out, Inlt.u_V_infini) annotation(
    Line(points = {{-78, -14}, {-37, -14}}, color = {0, 0, 127}));
  connect(Comb.y_m_flow_fuel, Perf.u_m_flow_fuel) annotation(
    Line(points = {{38, 2}, {38, 2}, {38, -58}, {178, -58}, {178, -58}}, color = {0, 0, 127}));
  connect(Nzl.y_Fg, Perf.u_Fg) annotation(
    Line(points = {{146, -10}, {156, -10}, {156, -42}, {178, -42}, {178, -42}}, color = {0, 0, 127}));
  connect(Cmp.flange_2, Trb.flange_1) annotation(
    Line(points = {{10, -10}, {70, -10}}));
  connect(Cmp.port_2, Comb.port_1) annotation(
    Line(points = {{10, -2}, {10, 10}, {20, 10}}, color = {0, 127, 255}));
  connect(VarBySolver.y_independent, Comb.u_m_flow_fuel) annotation(
    Line(points = {{1, 30}, {10, 30}, {10, 14}, {18, 14}}, color = {0, 0, 127}));
  connect(Comb.port_2, temperature.port) annotation(
    Line(points = {{40, 10}, {50, 10}, {50, 10}, {50, 10}}, color = {0, 127, 255}));
  connect(Constraint.u_variable, temperature.T) annotation(
    Line(points = {{70, 28}, {70, 20}, {57, 20}}, color = {0, 0, 127}));
  connect(temperature.port, Trb.port_1) annotation(
    Line(points = {{50, 10}, {60, 10}, {60, -2}, {70, -2}}, color = {0, 127, 255}));
  connect(ramp_TIT.y, Constraint.u_targetValue) annotation(
    Line(points = {{70, 60}, {70, 60}, {70, 52}, {70, 52}}, color = {0, 0, 127}));
  connect(flightToEngine1.port_fluidAmb, Nzl.port_2) annotation(
    Line(points = {{-90, 0}, {-90, 56}, {150, 56}, {150, -2}}, color = {0, 127, 255}));
  connect(Trb.port_2, Nzl.port_1) annotation(
    Line(points = {{90, -2}, {130, -2}, {130, -2}, {130, -2}}, color = {0, 127, 255}));
  annotation(
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(extent = {{-100, -60}, {200, 100}}, initialScale = 0.1)),
    Icon(coordinateSystem(extent = {{-100, -100}, {200, 100}})),
    version = "",
    __OpenModelica_commandLineOptions = "",
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-06, Interval = 0.0166722),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", outputFormat = "mat"));
end Turbojet_03;
