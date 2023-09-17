within PropulsionSystem.Examples.ThermoCycleSystems.DesignPoint;

model SteamTrb_with_HT_SimpleReactor_ex01
  extends Modelica.Icons.Example;
  //-----
  import units = Modelica.Units.SI;
  //-----
  parameter units.Area AreaHT = 50 "";
  parameter Real valMinTContour = 0;
  parameter Real valMaxTContour = 2500;
  //-----
  //-----
  parameter Real s_pumpDisp = 0.1;
  parameter Real s_pumpHead = 0.1;
  //-----
  Modelica.Fluid.Examples.DrumBoiler.BaseClasses.EquilibriumDrumBoiler evaporator(redeclare package Medium = Modelica.Media.Water.StandardWater, V_l(fixed = true), V_l_start = 0.5, V_t = 1, cp_D = 500, m_D = 1e-6, p(fixed = false, start = 2*101.325*1000), p_start = 2*101.325*1000) annotation(
    Placement(visible = true, transformation(origin = {50, -34}, extent = {{-20, 20}, {20, -20}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heat_evaporator annotation(
    Placement(visible = true, transformation(origin = {-84, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate massFlowVapor(redeclare package Medium = Modelica.Media.Water.StandardWater) annotation(
    Placement(visible = true, transformation(origin = {65, 144}, extent = {{5, 5}, {-5, -5}}, rotation = 180)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {378, -36}, extent = {{-160, 80}, {-140, 100}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_heat_evaporator(duration = 1, height = 1e6, offset = 5e6, startTime = 100) annotation(
    Placement(visible = true, transformation(origin = {-115, 118}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Gain fracLiquid(k = 1/evaporator.V_t) annotation(
    Placement(visible = true, transformation(origin = {108, -26}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_r_liquidLevel(duration = 100, height = 0, offset = 0.7, startTime = 100) annotation(
    Placement(visible = true, transformation(origin = {128, 4}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Continuous.PI ctrl_pi(T = 30, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 300, x_start = 2, y_start = 2) annotation(
    Placement(visible = true, transformation(origin = {128, -58}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {128, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PropulsionSystem.Elements.BasicElements.TurbineDesignPoint00 trb(redeclare package Medium = Modelica.Media.Water.StandardWater) annotation(
    Placement(visible = true, transformation(origin = {120, 128}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundaryAtm(redeclare package Medium = Modelica.Media.Water.StandardWater, nPorts = 1, p = 100*1000) annotation(
    Placement(visible = true, transformation(origin = {184, 162}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed = 3000*2.0*Modelica.Constants.pi/60.0) annotation(
    Placement(visible = true, transformation(origin = {185, 128}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerTrb annotation(
    Placement(visible = true, transformation(origin = {162, 128}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  PropulsionSystem.Utilities.ConstrainVariable constraint(tgtValue_paramInput = 2*101.325*1000, use_u_targetVal = true) annotation(
    Placement(visible = true, transformation(origin = {128, -94}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  inner PropulsionSystem.EngineSimEnvironment environment annotation(
    Placement(visible = true, transformation(origin = {228, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interaction.Show.RealValue disp_pwrTrb(significantDigits = 5, use_numberPort = true) annotation(
    Placement(visible = true, transformation(origin = {119, 101}, extent = {{13, -7}, {-13, 7}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT tankOutlet(redeclare package Medium = Modelica.Media.Water.StandardWater, T = 288.15, nPorts = 1, p = 100*1000) annotation(
    Placement(visible = true, transformation(origin = {159, -154}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PropulsionSystem.Elements.BasicElements.CompressorDesignPoint00 pump(redeclare package Medium = Modelica.Media.Water.StandardWater, PRdes_par = 25, effDes_par = 1, switchDetermine_PR = PropulsionSystem.Types.switches.switchHowToDetVar.param) annotation(
    Placement(visible = true, transformation(origin = {58, -164}, extent = {{13, -13}, {-13, 13}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed1(w_fixed = 3000*2.0*Modelica.Constants.pi/60.0) annotation(
    Placement(visible = true, transformation(origin = {4, -164}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerPump annotation(
    Placement(visible = true, transformation(origin = {22, -164}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate massFlowWater(redeclare package Medium = Modelica.Media.Water.StandardWater) annotation(
    Placement(visible = true, transformation(origin = {128, -154}, extent = {{-10, 10}, {10, -10}}, rotation = -180)));
  Modelica.Blocks.Interaction.Show.RealValue realValue(significantDigits = 5, use_numberPort = true) annotation(
    Placement(visible = true, transformation(origin = {60, -185}, extent = {{-13, -7}, {13, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1/1000) annotation(
    Placement(visible = true, transformation(origin = {32, -185}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = 1/1000) annotation(
    Placement(visible = true, transformation(origin = {145, 101}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_heat_vaporHeater(duration = 1, height = 1e5, offset = 1e6, startTime = 200) annotation(
    Placement(visible = true, transformation(origin = {-68, 130}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heat_vaporHeater annotation(
    Placement(visible = true, transformation(origin = {-17, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Vessels.ClosedVolume vaporHeater(redeclare package Medium = Modelica.Media.Water.StandardWater, V = 1, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, massDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, nPorts = 3, use_HeatTransfer = true, use_portsData = false) annotation(
    Placement(visible = true, transformation(origin = {40, 88}, extent = {{10, 10}, {-10, -10}}, rotation = -90)));
  HeatTransferComponents.ForcedConvection.Block_hFlatPlateTurbSmooth00 calc_hConv_evaporator(Amech = 0.0005, Len = 2, redeclare package Medium = Modelica.Media.Water.StandardWater) annotation(
    Placement(visible = true, transformation(origin = {50, -93.25}, extent = {{16.25, -13}, {-16.25, 13}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Components.Convection conv_evaporator annotation(
    Placement(visible = true, transformation(origin = {-2, -34}, extent = {{-14, 14}, {14, -14}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_Area_HT_evaporator(k = 100) annotation(
    Placement(visible = true, transformation(origin = {-44, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation(
    Placement(visible = true, transformation(origin = {25, -93}, extent = {{4, -4}, {-4, 4}}, rotation = -180)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(origin = {-4, -93}, extent = {{4, -4}, {-4, 4}}, rotation = -180)));
  Modelica.Blocks.Math.Gain gain2(k = 1/2) annotation(
    Placement(visible = true, transformation(origin = {10, -93}, extent = {{3, -3}, {-3, 3}}, rotation = -180)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation(
    Placement(visible = true, transformation(origin = {25, -76}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {-2, -66}, extent = {{-5, -5}, {5, 5}}, rotation = 90)));
  FluidSystemComponents.Sensor.Temperature_degC_DispColor00 temperature_pump_in(redeclare package Medium = Modelica.Media.Water.StandardWater, valMax = valMaxTContour, valMin = valMinTContour) annotation(
    Placement(visible = true, transformation(origin = {97, -163}, extent = {{-11, -7}, {11, 7}}, rotation = 0)));
  FluidSystemComponents.Sensor.Temperature_degC_DispColor00 temperature_pump_out(redeclare package Medium = Modelica.Media.Water.StandardWater, valMax = valMaxTContour, valMin = valMinTContour) annotation(
    Placement(visible = true, transformation(origin = {69, -117}, extent = {{-11, -7}, {11, 7}}, rotation = 0)));
  FluidSystemComponents.Sensor.Temperature_degC_DispColor00 temperature_evaporator_out(redeclare package Medium = Modelica.Media.Water.StandardWater, valMax = valMaxTContour, valMin = valMinTContour) annotation(
    Placement(visible = true, transformation(origin = {67, -3}, extent = {{-11, 7}, {11, -7}}, rotation = 0)));
  FluidSystemComponents.Sensor.Temperature_degC_DispColor00 temperature_vaporHeater_out(redeclare package Medium = Modelica.Media.Water.StandardWater, valMax = valMaxTContour, valMin = valMinTContour) annotation(
    Placement(visible = true, transformation(origin = {65, 97}, extent = {{-11, -7}, {11, 7}}, rotation = 0)));
  HeatTransferComponents.Sensors.Temperature_degC_DispColor00 temperature_reactor_LostCoolant(valMax = valMaxTContour, valMin = valMinTContour) annotation(
    Placement(visible = true, transformation(origin = {-34, -31}, extent = {{-12, -6}, {12, 6}}, rotation = -90)));
  FluidSystemComponents.Sensor.Temperature_degC_DispColor00 temperature_trb_out(redeclare package Medium = Modelica.Media.Water.StandardWater, valMax = valMaxTContour, valMin = valMinTContour) annotation(
    Placement(visible = true, transformation(origin = {147, 153}, extent = {{-11, -7}, {11, 7}}, rotation = 0)));
equation
  connect(ramp_heat_evaporator.y, heat_evaporator.Q_flow) annotation(
    Line(points = {{-115, 107}, {-115, -34}, {-94, -34}}, color = {0, 0, 127}));
  connect(massFlowVapor.port_b, trb.port_1) annotation(
    Line(points = {{70, 144}, {108, 144}}, color = {0, 127, 255}));
  connect(tankOutlet.ports[1], massFlowWater.port_a) annotation(
    Line(points = {{149, -154}, {138, -154}}, color = {0, 127, 255}));
  connect(trb.port_2, boundaryAtm.ports[1]) annotation(
    Line(points = {{132, 144}, {132, 162}, {174, 162}}, color = {0, 127, 255}));
  connect(gain.y, realValue.numberPort) annotation(
    Line(points = {{37.5, -185}, {45, -185}}, color = {0, 0, 127}));
  connect(gain1.y, disp_pwrTrb.numberPort) annotation(
    Line(points = {{139.5, 101}, {134, 101}}, color = {0, 0, 127}));
  connect(powerPump.power, gain.u) annotation(
    Line(points = {{26, -169.5}, {26, -185}}, color = {0, 0, 127}));
  connect(powerTrb.power, gain1.u) annotation(
    Line(points = {{158, 122.5}, {158, 101}, {151, 101}}, color = {0, 0, 127}));
  connect(ramp_heat_vaporHeater.y, heat_vaporHeater.Q_flow) annotation(
    Line(points = {{-68, 119}, {-68, 78}, {-27, 78}}, color = {0, 0, 127}));
  connect(vaporHeater.heatPort, heat_vaporHeater.port) annotation(
    Line(points = {{40, 78}, {-7, 78}}, color = {191, 0, 0}));
  connect(vaporHeater.ports[1], massFlowVapor.port_a) annotation(
    Line(points = {{50, 88}, {50, 144}, {60, 144}}, color = {0, 127, 255}));
  connect(conv_evaporator.solid, heat_evaporator.port) annotation(
    Line(points = {{-16, -34}, {-74, -34}}, color = {191, 0, 0}));
  connect(evaporator.heatPort, conv_evaporator.fluid) annotation(
    Line(points = {{30, -34}, {12, -34}}, color = {191, 0, 0}));
  connect(calc_hConv_evaporator.heatPort, prescribedTemperature.port) annotation(
    Line(points = {{37, -93.25}, {29, -93.25}}, color = {191, 0, 0}));
  connect(gain2.y, prescribedTemperature.T) annotation(
    Line(points = {{13.3, -93}, {20, -93}}, color = {0, 0, 127}));
  connect(gain2.u, add.y) annotation(
    Line(points = {{6.4, -93}, {0.8, -93}}, color = {0, 0, 127}));
  connect(trb.flange_2, powerTrb.flange_a) annotation(
    Line(points = {{140, 128}, {158, 128}}));
  connect(powerTrb.flange_b, constantSpeed.flange) annotation(
    Line(points = {{168, 128}, {178, 128}}));
  connect(evaporator.port_b, vaporHeater.ports[2]) annotation(
    Line(points = {{50, -14}, {50, 88}}, color = {0, 127, 255}));
  connect(calc_hConv_evaporator.port_2, evaporator.port_a) annotation(
    Line(points = {{50, -77}, {50, -54}}, color = {0, 127, 255}));
  connect(evaporator.heatPort, temperatureSensor.port) annotation(
    Line(points = {{30, -34}, {30, -76}}, color = {191, 0, 0}));
  connect(temperatureSensor.T, add.u2) annotation(
    Line(points = {{19.5, -76}, {-9, -76}, {-9, -91}}, color = {0, 0, 127}));
  connect(calc_hConv_evaporator.y_T_fluid, add.u1) annotation(
    Line(points = {{41.225, -109.5}, {-8.325, -109.5}, {-8.325, -95}}, color = {0, 0, 127}));
  connect(pump.port_2, calc_hConv_evaporator.port_1) annotation(
    Line(points = {{50, -154}, {50, -109.5}}, color = {0, 127, 255}));
  connect(massFlowWater.port_b, pump.port_1) annotation(
    Line(points = {{118, -154}, {66, -154}}, color = {0, 127, 255}));
  connect(powerPump.flange_a, pump.flange_2) annotation(
    Line(points = {{27, -164}, {45, -164}}));
  connect(constantSpeed1.flange, powerPump.flange_b) annotation(
    Line(points = {{11, -164}, {17, -164}}));
  connect(conv_evaporator.Gc, product.y) annotation(
    Line(points = {{-2, -48}, {-2, -60.5}}, color = {0, 0, 127}));
  connect(calc_hConv_evaporator.y_h, product.u2) annotation(
    Line(points = {{36.025, -83.5}, {1.025, -83.5}, {1.025, -72}}, color = {0, 0, 127}));
  connect(const_Area_HT_evaporator.y, product.u1) annotation(
    Line(points = {{-33, -72}, {-5, -72}}, color = {0, 0, 127}));
  connect(massFlowWater.m_flow, constraint.u_variable) annotation(
    Line(points = {{128, -143}, {128, -105}}, color = {0, 0, 127}));
  connect(fracLiquid.y, feedback.u2) annotation(
    Line(points = {{113.5, -26}, {119.5, -26}}, color = {0, 0, 127}));
  connect(feedback.y, ctrl_pi.u) annotation(
    Line(points = {{128, -35}, {128, -46}}, color = {0, 0, 127}));
  connect(ramp_r_liquidLevel.y, feedback.u1) annotation(
    Line(points = {{128, -7}, {128, -19}}, color = {0, 0, 127}));
  connect(evaporator.V, fracLiquid.u) annotation(
    Line(points = {{72, -26}, {102, -26}}, color = {0, 0, 127}));
  connect(ctrl_pi.y, constraint.u_targetValue) annotation(
    Line(points = {{128, -69}, {128, -82}}, color = {0, 0, 127}));
  connect(pump.port_1, temperature_pump_in.port) annotation(
    Line(points = {{66, -154}, {86, -154}, {86, -163}}, color = {0, 127, 255}));
  connect(temperature_pump_out.port, calc_hConv_evaporator.port_1) annotation(
    Line(points = {{58, -117.35}, {50, -117.35}, {50, -109.85}}, color = {0, 127, 255}));
  connect(temperature_evaporator_out.port, evaporator.port_b) annotation(
    Line(points = {{56, -3}, {50, -3}, {50, -14}}, color = {0, 127, 255}));
  connect(temperature_vaporHeater_out.port, vaporHeater.ports[3]) annotation(
    Line(points = {{54, 97}, {50, 97}, {50, 88}}, color = {0, 127, 255}));
  connect(temperature_reactor_LostCoolant.heatPort, conv_evaporator.solid) annotation(
    Line(points = {{-34, -19}, {-24, -19}, {-24, -34}, {-16, -34}}, color = {191, 0, 0}));
  connect(temperature_trb_out.port, trb.port_2) annotation(
    Line(points = {{136, 153}, {132, 153}, {132, 144}}, color = {0, 127, 255}));
  annotation(
    Icon(coordinateSystem(extent = {{-280, -200}, {260, 200}}), graphics = {Text(textColor = {0, 0, 255}, extent = {{-151, 165}, {138, 102}}, textString = "%name")}),
    experiment(StopTime = 400, StartTime = 0, Tolerance = 1e-06, Interval = 0.1),
    Documentation(info = "<html>

</html>"),
    Diagram(coordinateSystem(extent = {{-280, -200}, {260, 200}})));
end SteamTrb_with_HT_SimpleReactor_ex01;
