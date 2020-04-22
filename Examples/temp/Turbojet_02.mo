within PropulsionSystem.Examples.temp;

model Turbojet_02
  extends Modelica.Icons.Example;
  package engineAir = Modelica.Media.Air.DryAirNasa;
  //-----
  PropulsionSystem.Elements.BasicElements.FlightToEngine flightToEngine1(redeclare package Medium = engineAir, MN = 0.8, alt = 10000) annotation(
    Placement(visible = true, transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Elements.BasicElements.Inlet Inlt010(redeclare package Medium = engineAir) annotation(
    Placement(visible = true, transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Elements.BasicElements.Duct Duct030(redeclare package Medium = engineAir, dPqPdes = 0.02) annotation(
    Placement(visible = true, transformation(origin = {10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Elements.BasicElements.HeatInjector Brn036(redeclare package Medium = engineAir, TtOutletDes(displayUnit = "K") = 1600, switchInput_TtOutlet = PropulsionSystem.Types.switches.switch_parameter_input.use_inputSignal) annotation(
    Placement(visible = true, transformation(origin = {40, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Elements.BasicElements.CombustFuel combustFuel1 annotation(
    Placement(visible = true, transformation(origin = {20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Elements.BasicElements.Duct Duct045(redeclare package Medium = engineAir, dPqPdes = 0.03) annotation(
    Placement(visible = true, transformation(origin = {110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Elements.BasicElements.EnginePerformance perf001 annotation(
    Placement(visible = true, transformation(origin = {180, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //-----
  Modelica.Blocks.Sources.Ramp ramp_TIT(duration = 10, height = 200, offset = 1600, startTime = 20) annotation(
    Placement(visible = true, transformation(origin = {30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner EngineSimEnvironment environment annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Elements.BasicElements.CmpCharTable00 Cmp(redeclare package Medium = engineAir) annotation(
    Placement(visible = true, transformation(origin = {-30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Elements.BasicElements.TrbCharTable00 Trb(redeclare package Medium = engineAir) annotation(
    Placement(visible = true, transformation(origin = {80, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Elements.BasicElements.NzlCharFixed00 Nzl(redeclare package Medium = engineAir, AmechTh_paramInput = 0.0014, switchDetermine_AmechTh = PropulsionSystem.Types.switches.switchHowToDetVar.param) annotation(
    Placement(visible = true, transformation(origin = {140, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(flightToEngine1.port_fluidAmb, Nzl.port_2) annotation(
    Line(points = {{-90, 0}, {-90, 0}, {-90, 10}, {150, 10}, {150, -2}, {150, -2}}, color = {0, 127, 255}));
  connect(Nzl.y_Fg, perf001.u_Fg) annotation(
    Line(points = {{146, -10}, {162, -10}, {162, -42}, {170, -42}, {170, -42}}, color = {0, 0, 127}));
  connect(Duct045.port_2, Nzl.port_1) annotation(
    Line(points = {{120, -2}, {130, -2}, {130, -2}, {130, -2}}, color = {0, 127, 255}));
  connect(Cmp.flange_2, Trb.flange_1) annotation(
    Line(points = {{-20, -10}, {-14, -10}, {-14, -32}, {64, -32}, {64, -10}, {70, -10}, {70, -10}}));
  connect(Trb.port_2, Duct045.port_1) annotation(
    Line(points = {{90, -2}, {100, -2}, {100, -2}, {100, -2}}, color = {0, 127, 255}));
  connect(Brn036.port_2, Trb.port_1) annotation(
    Line(points = {{50, -2}, {70, -2}, {70, -2}, {70, -2}}, color = {0, 127, 255}));
  connect(Brn036.TtOutlet_in, ramp_TIT.y) annotation(
    Line(points = {{49, -6}, {54, -6}, {54, 70}, {41, 70}}, color = {0, 0, 127}));
  connect(combustFuel1.HeatPort_b, Brn036.HeatPort_1) annotation(
    Line(points = {{30, 21}, {40, 21}, {40, 1}}, color = {191, 0, 0}));
  connect(Duct030.port_2, Brn036.port_1) annotation(
    Line(points = {{20, -1}, {30, -1}}, color = {0, 127, 255}));
  connect(Cmp.port_2, Duct030.port_1) annotation(
    Line(points = {{-20, -2}, {0, -2}, {0, -2}, {0, -2}}, color = {0, 127, 255}));
  connect(Inlt010.port_2, Cmp.port_1) annotation(
    Line(points = {{-50, -2}, {-40, -2}, {-40, -2}, {-40, -2}}, color = {0, 127, 255}));
  connect(Inlt010.Fram_out, perf001.u_Fram) annotation(
    Line(points = {{-52, -14}, {-46, -14}, {-46, -46}, {170, -46}, {170, -46}}, color = {0, 0, 127}));
  connect(flightToEngine1.V_tot_out, Inlt010.V_tot_in) annotation(
    Line(points = {{-79, -13}, {-67, -13}}, color = {0, 0, 127}));
  connect(flightToEngine1.port_fluid2Eng, Inlt010.port_1) annotation(
    Line(points = {{-80, -1}, {-68, -1}}, color = {0, 127, 255}));
  connect(combustFuel1.dm_fuel_out, perf001.u_m_flow_fuel) annotation(
    Line(points = {{32, 16}, {34, 16}, {34, -58}, {170, -58}, {170, -58}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(extent = {{-100, -60}, {200, 100}}), graphics = {Rectangle(origin = {25, 5}, pattern = LinePattern.Dash, extent = {{-33, 29}, {35, -31}}), Text(origin = {10, 37}, extent = {{-18, 2}, {4, -2}}, textString = "Combustor")}),
    Icon(coordinateSystem(extent = {{-100, -100}, {200, 100}})),
    version = "",
    __OpenModelica_commandLineOptions = "",
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-06, Interval = 0.0166722),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", outputFormat = "mat"));
end Turbojet_02;
