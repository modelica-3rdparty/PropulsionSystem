within PropulsionSystem.BaseClasses.BasicElements;

partial model NozzleBase00
  /********************************************************
        imports
  ********************************************************/
  import Modelica.Constants;
  import Modelica.Utilities.Streams;
  import PropulsionSystem.Types.switches;
  
  /********************************************************
               Declaration
  ********************************************************/
  /* ---------------------------------------------
      Package
  --------------------------------------------- */
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching = true);
  
  
  /* ---------------------------------------------
      parameters
  --------------------------------------------- */
  //********** Initialization Parameters **********
  //--- fluid_1, port_1 ---
  parameter Modelica.SIunits.MassFlowRate m_flow1_init(displayUnit = "kg/s") = 1.0 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_1"));
  parameter Modelica.SIunits.Pressure p1_init(displayUnit = "Pa") = 101.3 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_1"));
  parameter Modelica.SIunits.Temperature T1_init(displayUnit = "K") = 288.15 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_1"));
  parameter Modelica.SIunits.SpecificEnthalpy h1_init(displayUnit = "J/kg") = 1.004 * 1000 * 288.15 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_1"));
  //--- fluid_2, port_2 ---
  parameter Modelica.SIunits.MassFlowRate m_flow2_init(displayUnit = "kg/s") = -1.0 * m_flow1_init "" annotation(
    Dialog(tab = "Initialization", group = "fluid_2"));
  parameter Modelica.SIunits.Pressure p2_init(displayUnit = "Pa") = 101.3 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_2"));
  parameter Modelica.SIunits.Temperature T2_init(displayUnit = "K") = 288.15 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_2"));
  parameter Modelica.SIunits.SpecificEnthalpy h2_init(displayUnit = "J/kg") = 1.004 * 1000 * 288.15 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_2"));
  
  
  /* ---------------------------------------------
      Internal variables
  --------------------------------------------- */
  inner outer PropulsionSystem.EngineSimEnvironment environment "System wide properties";
  
  Medium.BaseProperties fluid_1(p.start = p1_init, T.start = T1_init, state.p.start = p1_init, state.T.start = T1_init, h.start = h1_init) "flow station of inlet";
  Medium.BaseProperties fluid_2(p.start = p2_init, T.start = T2_init, state.p.start = p2_init, state.T.start = T2_init, h.start = h2_init) "flow station of outlet (ambient)";
  Medium.BaseProperties fluid_2Tot(p.start = p1_init, T.start = T1_init, state.p.start = p1_init, state.T.start = T1_init, h.start = h1_init) "flow station of outlet, total";
  Medium.BaseProperties fluidStat_th(p.start = p2_init, T.start = T2_init, state.p.start = p2_init, state.T.start = T2_init, h.start = h2_init) "static flow station of throat";
  Medium.BaseProperties fluid_th(p.start = p1_init, T.start = T1_init, state.p.start = p1_init, state.T.start = T1_init, h.start = h1_init) "flow station of throat";
  Medium.BaseProperties fluidStat_th_fullExp(p.start = p1_init, T.start = T1_init, state.p.start = p1_init, state.T.start = T1_init, h.start = h1_init) "";
  Medium.BaseProperties fluidStat_th_choked(p.start = p1_init, T.start = T1_init, state.p.start = p1_init, state.T.start = T1_init, h.start = h1_init) "";
  
  Modelica.SIunits.SpecificEntropy s_fluid_1 "specific entropy, fluid_1";
  Modelica.SIunits.SpecificEntropy s_fluid_2 "specific entropy, fluid_2";
  Modelica.SIunits.SpecificEntropy s_fluid_th "specific entropy, fluid_th";
  Modelica.SIunits.SpecificEntropy s_fluid_2Tot "specific entropy, fluid_2Tot";
  
  Modelica.SIunits.MassFlowRate m_flow_max;
  Modelica.SIunits.MassFlowRate m_flow_min;
  
  Modelica.SIunits.Velocity V_2;
  Modelica.SIunits.Velocity V_2is;
  Real PR;
  Real CdTh;
  Real Cv;
  Modelica.SIunits.SpecificEnthalpy h_2is "";
  Modelica.SIunits.Force Fg "";
  
  //-throat-
  Modelica.SIunits.MassFlowRate m_flow_th(start = 0.0);
  Modelica.SIunits.Area AmechTh;
  Modelica.SIunits.Area AeTh;
  Modelica.SIunits.Velocity V_th(start = 0.0);
  Real MNth;
  
  //--full expansion--
  Modelica.SIunits.Velocity V_th_fullExp(start = 0.0);
  
  //--choked--
  Modelica.SIunits.Velocity V_th_choked(start = 0.0);
  
  //********** Design point variables **********
  Modelica.SIunits.Area AeThDes;
  Real PRdes;
  Real CdThDes;
  Real CvDes;
  
  
  /* ---------------------------------------------
      Interface
  --------------------------------------------- */
  Modelica.Fluid.Interfaces.FluidPort_a port_1
  (
    redeclare package Medium = Medium, m_flow(start = m_flow1_init), h_outflow.start = h1_init
  ) "" annotation(
    Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_2
  (
    redeclare package Medium = Medium, m_flow(start = m_flow2_init), h_outflow.start = h2_init
  ) "" annotation(
    Placement(visible = true, transformation(origin = {100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Blocks.Interfaces.RealOutput Fg_out(quantity="Force", unit="N",displayUnit="N") "[N], gross thrust by nozzle" annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 2.9976e-15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  PropulsionSystem.Types.ElementBus elementBus1 annotation(
    Placement(visible = true, transformation(origin = {70, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  
  
equation
  /* ---------------------------------------------
  Connections, interface <-> internal variables
  --------------------------------------------- */
  Fg_out = Fg;
  
  //-- fluidPort_1 --
  fluid_1.p = port_1.p;
  fluid_1.h = actualStream(port_1.h_outflow);
  fluid_1.Xi = actualStream(port_1.Xi_outflow);
  
  //-- fluidPort_2 --
  fluid_2.p = port_2.p;
  fluid_2.h = actualStream(port_2.h_outflow);
  fluid_2.Xi = actualStream(port_2.Xi_outflow);
  
  // distinguish inlet side
  m_flow_max= max(port_1.m_flow, port_2.m_flow);
  m_flow_min= min(port_1.m_flow, port_2.m_flow);
  
  if(m_flow_max == port_1.m_flow)then
    port_1.h_outflow= fluid_1.h;
  elseif(m_flow_max == port_2.m_flow)then
    port_2.h_outflow= fluid_2.h;
  else
    port_1.h_outflow= fluid_1.h;
  end if;
  
  
  /* ---------------------------------------------
  Eqns describing physics
  --------------------------------------------- */
  //-- mass conservation --
  port_1.m_flow + port_2.m_flow = 0;
  fluid_2.Xi = fluid_1.Xi;
  fluid_2Tot.p = fluid_1.p;
  PR = fluid_1.p / fluid_2.p;
  //-- full expansion --
  fluid_1.h = h_2is + sign(V_2is) * abs(V_2is) ^ 2.0 * (1.0 / 2.0);
  h_2is = Medium.isentropicEnthalpy(fluid_2.p, fluid_1.state);
  V_2 = Cv * V_2is;
  fluid_1.h = fluid_2.h + sign(V_2) * abs(V_2) ^ 2.0 / 2.0;
  //-- energy conservation --
  port_1.m_flow * fluid_1.h + port_2.m_flow * fluid_2Tot.h = 0;
  //--- throat, p, T ---
  fluid_th.p = fluid_1.p;
  fluid_th.h = fluid_1.h;
  //--- throat, static, p, T ---
  fluidStat_th_fullExp.p = fluid_2.p;
  fluidStat_th_choked.p = fluid_2.p;
  /*
  //--- fully-expanded ---
  fluidStat_th_fullExp.h = Medium.isentropicEnthalpy(fluidStat_th_fullExp.p, fluid_1.state);
  */
  //V_th_fullExp= sqrt( 2.0*(fluid_1.h - fluidStat_th_fullExp.h ) );
  fluid_1.h - fluidStat_th_fullExp.h = 1.0 / 2.0 * (sign(V_th_fullExp) * abs(V_th_fullExp) ^ 2.0);
  //--- velocity if choked state ---
  V_th_choked = 1.0 * Medium.velocityOfSound(fluidStat_th_choked.state);
  fluidStat_th_choked.h = fluid_1.h - 1.0 / 2.0 * (sign(V_th_choked) * abs(V_th_choked) ^ 2.0);
  //evaluate choked or not
  if V_th_fullExp >= V_th_choked then
  //--- case of choked ---
    V_th = V_th_choked;
  else
  //--- case of unchoked ---
    V_th = V_th_fullExp;
  end if;
  //--- throat state ---
  MNth = V_th / Medium.velocityOfSound(fluidStat_th.state);
  fluidStat_th.h = fluid_1.h - 1.0 / 2.0 * (sign(V_th) * abs(V_th) ^ 2.0);
  fluidStat_th.h = Medium.isentropicEnthalpy(fluidStat_th.p, fluid_1.state);
  dmTh = fluid_th.d * V_th * AeTh;
  dmTh = abs(port_1.m_flow);
  AeTh = Amech_th * CdTh;
  //-- performance characteristics --
  if switchCalc_Fg == switch_calcFg.FullyExpandedFlow then
    Fg = (-1) * port_2.m_flow * V_2;
  elseif switchCalc_Fg == switch_calcFg.NozzleExitFlow then
    Fg = Cv * V_th * dmTh + (fluidStat_th.p - fluid_2.p) * AeTh;
  end if;
  
  /* ---------------------------------------------
  reinit invalid state variables
  --------------------------------------------- */
  when fluidStat_th_fullExp.p <= 0.0 then
    reinit(fluidStat_th_fullExp.p, -1.0 * fluidStat_th_fullExp.p);
  end when;
  
  when fluidStat_th.p <= 0.0 then
    reinit(fluidStat_th.p, -1.0 * fluidStat_th.p);
  end when;
  
  
  
  
algorithm
  assert(fluid_1.h < fluidStat_th_fullExp.h, "nozzle inverse flow condition, fluid_1.h < fluidStat_th_fullExp.h" + "\n" + ", fluid_1.h=" + String(fluid_1.h) + ", fluidStat_th_fullExp.h=" + String(fluidStat_th_fullExp.h), AssertionLevel.warning);
/*
  //--- isentropic expansion ---
  if((0.0<=fluid_2.p)and(0.0<=fluid_1.state.p))then
    
    h_2is:= Medium.isentropicEnthalpy(fluid_2.p, fluid_1.state);
    
  elseif((fluid_2.p<0.0)and(fluid_1.state.p<0.0))then
    
    h_2is:= Medium.isentropicEnthalpy(fluid_2.p, fluid_1.state);
    
  else
    h_2is:= Medium.isentropicEnthalpy(-1.0*fluid_2.p, fluid_1.state);
  end if;
  */
//--- throat fully-expanded ---
  if 0.0 < fluidStat_th_fullExp.p and 0.0 < fluid_1.state.p then
    fluidStat_th_fullExp.h := Medium.isentropicEnthalpy(fluidStat_th_fullExp.p, fluid_1.state);
  elseif fluidStat_th_fullExp.p < 0.0 and fluid_1.state.p < 0.0 then
    fluidStat_th_fullExp.h := Medium.isentropicEnthalpy(fluidStat_th_fullExp.p, fluid_1.state);
  else
    fluidStat_th_fullExp.h := Medium.isentropicEnthalpy(-1.0 * fluidStat_th_fullExp.p, fluid_1.state);
  end if;
/*
  //--- throat ---
  if((0.0<fluidStat_th.p)and(0.0<fluid_1.state.p))then
    
    fluidStat_th.h:= Medium.isentropicEnthalpy(fluidStat_th.p, fluid_1.state);
    
  elseif((fluidStat_th.p<0.0)and(fluid_1.state.p<0.0))then
    
    fluidStat_th.h:= Medium.isentropicEnthalpy(fluidStat_th.p, fluid_1.state);
    
  else
    fluidStat_th.h:= Medium.isentropicEnthalpy(-1.0*fluidStat_th.p, fluid_1.state);
  end if;
  */
initial equation
  port_1.m_flow = dmTh;
initial algorithm
//##### none #####
/********************************************************
  Graphics
********************************************************/
  annotation(
    Icon(graphics = {Polygon(origin = {0, 10}, fillColor = {255, 221, 96}, fillPattern = FillPattern.Solid, points = {{-80, 70}, {-80, -90}, {60, -50}, {60, 30}, {-80, 70}}), Text(origin = {-54, 108}, extent = {{-26, -8}, {134, -28}}, textString = "%name"), Rectangle(origin = {-94, 80}, fillColor = {112, 112, 112}, fillPattern = FillPattern.Solid, extent = {{-6, 2}, {14, -2}}), Text(origin = {80, 63}, extent = {{-16, 17}, {10, -3}}, textString = "amb"), Line(origin = {81.88, 37.0395}, points = {{-23, 2}, {17, 2}, {17, 42}}, pattern = LinePattern.Dot, thickness = 0.5), Text(origin = {-58, 22}, extent = {{-22, -2}, {78, -42}}, textString = "Nzl")}, coordinateSystem(initialScale = 0.1)));
  
  
end NozzleBase00;
