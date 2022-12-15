within PropulsionSystem.Examples.ThermoCycleSystems.Transient;

model HeatPump_vs_Heater_ex01
  extends Modelica.Icons.Example;
  //----------
  package fluid1 = Modelica.Media.Air.DryAirNasa;
  //redeclare package Medium= fluid1,
  //----------
  PropulsionSystem.Elements.BasicElements.SimplestHeatPump00 heatPump annotation(
    Placement(visible = true, transformation(origin = {146, 6}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Fluid.Vessels.ClosedVolume room1(redeclare package Medium = fluid1, T_start = 5 + 273.15, V = 5, nPorts = 1, use_HeatTransfer = true, use_portsData = false) annotation(
    Placement(visible = true, transformation(origin = {-104, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Fluid.Vessels.ClosedVolume room2(redeclare package Medium = fluid1, T_start = 5 + 273.15, V = 5, nPorts = 1, use_HeatTransfer = true, use_portsData = false) annotation(
    Placement(visible = true, transformation(origin = {146, 70}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater annotation(
    Placement(visible = true, transformation(origin = {-104, 22}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
  Modelica.Fluid.Sensors.Temperature T_room1(redeclare package Medium = fluid1) annotation(
    Placement(visible = true, transformation(origin = {-54, 70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Fluid.Sensors.Temperature T_room2(redeclare package Medium = fluid1) annotation(
    Placement(visible = true, transformation(origin = {14, 70}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant Q_flow_heater(k = 2 * 1000) annotation(
    Placement(visible = true, transformation(origin = {-125, -53}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant dW_heatPump(k = 2 * 1000) annotation(
    Placement(visible = true, transformation(origin = {39, 31}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {-104, -19}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant r_T_room(k = 25 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {6, -81}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
  Modelica.Blocks.Logical.Less less1 annotation(
    Placement(visible = true, transformation(origin = {-70, -67}, extent = {{7, -8}, {-7, 8}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch2 annotation(
    Placement(visible = true, transformation(origin = {66, 6}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant zero1(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-78, -46}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant zero2(k = 0) annotation(
    Placement(visible = true, transformation(origin = {44, -14}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  Modelica.Blocks.Logical.Less less2 annotation(
    Placement(visible = true, transformation(origin = {30, 6}, extent = {{-7, -8}, {7, 8}}, rotation = 0)));
  Modelica.Fluid.Vessels.ClosedVolume outside(redeclare package Medium = fluid1, V = 50, nPorts = 2, use_HeatTransfer = true, use_portsData = false) annotation(
    Placement(visible = true, transformation(origin = {146, -54}, extent = {{-14, 14}, {14, -14}}, rotation = -90)));
  inner Modelica.Fluid.System system(T_ambient(displayUnit = "K") = 273.15 - 5, T_start(displayUnit = "K") = 273.15 - 5) annotation(
    Placement(visible = true, transformation(origin = {-14, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_CoP(k = 3) annotation(
    Placement(visible = true, transformation(origin = {92, -10}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integE_heater annotation(
    Placement(visible = true, transformation(origin = {-73, -5}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integE_heatPump annotation(
    Placement(visible = true, transformation(origin = {93, 23}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
equation
  connect(heatPump.port_b, room2.heatPort) annotation(
    Line(points = {{146, 26}, {146, 60}}, color = {191, 0, 0}, thickness = 2));
  connect(heater.port, room1.heatPort) annotation(
    Line(points = {{-104, 38}, {-104, 60}}, color = {191, 0, 0}, thickness = 2));
  connect(T_room1.port, room1.ports[1]) annotation(
    Line(points = {{-64, 70}, {-94, 70}}, color = {0, 127, 255}, pattern = LinePattern.DashDot, thickness = 0.5));
  connect(switch1.y, heater.Q_flow) annotation(
    Line(points = {{-104, -11}, {-104, 6}}, color = {0, 0, 127}, thickness = 1));
  connect(Q_flow_heater.y, switch1.u1) annotation(
    Line(points = {{-117.3, -53}, {-110, -53}, {-110, -27}}, color = {0, 0, 127}));
  connect(switch2.y, heatPump.u_dW) annotation(
    Line(points = {{74.8, 6}, {124.8, 6}}, color = {0, 0, 127}, thickness = 2));
  connect(dW_heatPump.y, switch2.u1) annotation(
    Line(points = {{46.7, 31}, {51.4, 31}, {51.4, 12}, {55.4, 12}}, color = {0, 0, 127}));
  connect(less1.y, switch1.u2) annotation(
    Line(points = {{-77.7, -67}, {-104, -67}, {-104, -27}}, color = {255, 0, 255}));
  connect(zero1.y, switch1.u3) annotation(
    Line(points = {{-84.6, -46}, {-98, -46}, {-98, -27}}, color = {0, 0, 127}));
  connect(T_room1.T, less1.u1) annotation(
    Line(points = {{-54, 63}, {-54, -67}, {-62, -67}}, color = {0, 0, 127}, pattern = LinePattern.DashDot));
  connect(r_T_room.y, less1.u2) annotation(
    Line(points = {{6, -73}, {-62, -73}}, color = {0, 0, 127}));
  connect(zero2.y, switch2.u3) annotation(
    Line(points = {{44, -7.4}, {44, -0.4}, {56, -0.4}}, color = {0, 0, 127}));
  connect(T_room2.port, room2.ports[1]) annotation(
    Line(points = {{24, 70}, {136, 70}}, color = {0, 127, 255}, pattern = LinePattern.DashDot, thickness = 0.5));
  connect(T_room2.T, less2.u1) annotation(
    Line(points = {{14, 63}, {14, 6}, {22, 6}}, color = {0, 0, 127}, pattern = LinePattern.DashDot));
  connect(r_T_room.y, less2.u2) annotation(
    Line(points = {{6, -73.3}, {6, 0}, {22, 0}}, color = {0, 0, 127}));
  connect(less2.y, switch2.u2) annotation(
    Line(points = {{37.7, 6}, {55.7, 6}}, color = {255, 0, 255}));
  connect(outside.heatPort, heatPump.port_a) annotation(
    Line(points = {{146, -40}, {146, -14}}, color = {191, 0, 0}, thickness = 2));
  connect(const_CoP.y, heatPump.u_CoP) annotation(
    Line(points = {{99, -10}, {123.6, -10}}, color = {0, 0, 127}));
  connect(switch1.y, integE_heater.u) annotation(
    Line(points = {{-104, -11}, {-104, -4.3}, {-81, -4.3}}, color = {0, 0, 127}, pattern = LinePattern.DashDot));
  connect(switch2.y, integE_heatPump.u) annotation(
    Line(points = {{74.8, 6}, {78.8, 6}, {78.8, 23}, {85.8, 23}}, color = {0, 0, 127}, pattern = LinePattern.DashDot));
  annotation(
    Diagram(coordinateSystem(extent = {{-160, -100}, {180, 100}})),
    experiment(StartTime = 0, StopTime = 80, Tolerance = 1e-06, Interval = 0.01));
end HeatPump_vs_Heater_ex01;
