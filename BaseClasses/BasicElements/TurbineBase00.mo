within PropulsionSystem.BaseClasses.BasicElements;

partial model TurbineBase00
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
  parameter Modelica.SIunits.Pressure p1_init(displayUnit = "Pa") = PR_init*101.3 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_1"));
  parameter Modelica.SIunits.Temperature T1_init(displayUnit = "K") = 1600 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_1"));
  parameter Modelica.SIunits.SpecificEnthalpy h1_init(displayUnit = "J/kg") = 1600*1.004 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_1"));
  //--- fluid_2, port_2 ---
  parameter Modelica.SIunits.MassFlowRate m_flow2_init(displayUnit = "kg/s") = -1.0 * m_flow1_init "" annotation(
    Dialog(tab = "Initialization", group = "fluid_2"));
  parameter Modelica.SIunits.Pressure p2_init(displayUnit = "Pa") = 5.0*101.3 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_2"));
  parameter Modelica.SIunits.Temperature T2_init(displayUnit = "K") = 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_2"));
  parameter Modelica.SIunits.SpecificEnthalpy h2_init(displayUnit = "J/kg") = T2_init*1.004 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_2"));
  //--- flange_1 ---
  parameter Modelica.SIunits.Torque tau1_init=pwr_init/(Nmech_init*2.0*Modelica.Constants.pi/60.0) "" annotation(
    Dialog(tab = "Initialization", group = "flange_1")
  );
  parameter Modelica.SIunits.Angle phi1_init=phi_init "" annotation(
    Dialog(tab = "Initialization", group = "flange_1")
  );
  //--- flange_2 ---
  parameter Modelica.SIunits.Torque tau2_init=0.1 "" annotation(
    Dialog(tab = "Initialization", group = "flange_2")
  );
  parameter Modelica.SIunits.Angle phi2_init=phi_init "" annotation(
    Dialog(tab = "Initialization", group = "flange_2")
  );
  //--- others ---
  parameter Real PR_init=4.0 "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Real eff_init=0.8 "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm Nmech_init=3000.0 "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Real NcqNcDes_1_init=1.0 "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Real NqNdes_init=NcqNcDes_1_init "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Modelica.SIunits.MassFlowRate Wc_1_init=m_flow1_init "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm Nc_1_init=Nmech_init "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Modelica.SIunits.SpecificEnthalpy dht_init= 430000.0 "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Modelica.SIunits.SpecificEnthalpy dht_is_init= 540000.0 "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Modelica.SIunits.Power pwr_init=-4.0*10.0^(5) "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Modelica.SIunits.Torque trq_init=pwr_init/(Nmech_init*2.0*Modelica.Constants.pi/60.0) "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Modelica.SIunits.Angle phi_init=1.0 "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Modelica.SIunits.SpecificEntropy s_fluid_1_init=7800.0 "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter Modelica.SIunits.SpecificEntropy s_fluid_2_init=7900.0 "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  
  
  /* ---------------------------------------------
      Internal variables
  --------------------------------------------- */
  Modelica.SIunits.SpecificEntropy s_fluid_1(start=s_fluid_1_init) "specific entropy, fluid_1" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.SpecificEntropy s_fluid_2(start=s_fluid_2_init) "specific entropy, fluid_2" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  
  Modelica.SIunits.Power pwr(start=pwr_init) "power via shaft, positive if fluid generates power" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.Torque trq(start=trq_init) "trq via shaft" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.Power pwr_inv(start=-1.0*pwr_init) "power via shaft" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.Torque trq_inv(start=-1.0*trq_init) "trq via shaft" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  
  Modelica.SIunits.AngularVelocity omega(start=Nmech_init*2.0*Modelica.Constants.pi/60.0) "mechanical rotation speed, rad/sec" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.Angle phi(start=phi_init) "mechanical rotation displacement, rad" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm Nmech(start=Nmech_init) "mechanical rotation speed, rpm" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  
  Modelica.SIunits.MassFlowRate Wc_1(start=Wc_1_init) "corrected mass flow rate" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm Nc_1(start=Nc_1_init) "corrected rotation speed, rpm" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Real PR(start=PR_init) "pressure ratio" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Real eff(start=eff_init) "adiabatic efficiency" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.SpecificEnthalpy dht_is(start=dht_is_init) "specific enthalpy change in isentropic compression" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.SpecificEnthalpy dht(start=dht_init) "specific enthalpy change in non-isentropic compression" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.SpecificEnthalpy h_2is(start=h1_init-dht_is_init) "" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  
  
  Modelica.SIunits.MassFlowRate m_flow_max(start=m_flow1_init) "" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Modelica.SIunits.MassFlowRate m_flow_min(start=m_flow2_init) "" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  //********** variables relative to design point **********
  inner Real NcqNcDes_1(start=NcqNcDes_1_init) "ratio of corrected rotational speed with respect to design pt. speed" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Real NqNdes(start=NqNdes_init) "ratio of mech. rotational speed with respect to design pt. speed" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  
  
  /* ---------------------------------------------
      Internal objects
  --------------------------------------------- */
  inner outer PropulsionSystem.EngineSimEnvironment environment "System wide properties";
  
  Medium.BaseProperties fluid_1(
    p.start = p1_init, T.start = T1_init, state.p.start = p1_init, state.T.start = T1_init, h.start = h1_init
  ) "flow station of inlet";
  Medium.BaseProperties fluid_2(
    p.start = p2_init, T.start = T2_init, state.p.start = p2_init, state.T.start = T2_init, h.start = h2_init
  ) "flow station of outlet";
  
  
  
  
  /* ---------------------------------------------
      Interface
  --------------------------------------------- */
  Modelica.Fluid.Interfaces.FluidPort_a port_1
  (
    redeclare package Medium = Medium, m_flow(start = m_flow1_init), h_outflow(start = h1_init), p(start=p1_init)
  ) "" annotation(
    Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_2
  (
    redeclare package Medium = Medium, m_flow(start = m_flow2_init), h_outflow(start = h2_init), p(start=p2_init)
  ) "" annotation(
    Placement(visible = true, transformation(origin = {100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_1(
    tau(start=tau1_init), phi(start=phi1_init)
  ) "" annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_2(
    tau(start=tau2_init), phi(start=phi2_init)
  ) "" annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Types.ElementBus elementBus1 annotation(
    Placement(visible = true, transformation(origin = {70, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  
protected
  /* ---------------------------------------------
          Non-modifiable parameters
    --------------------------------------------- */
  parameter Modelica.SIunits.MassFlowRate m_flow_des_1(fixed=false, start=m_flow1_init) annotation(
    HideResult=false);
  parameter Modelica.SIunits.Pressure pDes_1(fixed=false, start=p1_init) annotation(
    HideResult=false);
  parameter Modelica.SIunits.Temperature Tdes_1(fixed=false, start=T1_init) annotation(
    HideResult=false);
  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm NmechDes(fixed=false, start=Nmech_init) "mechanical rotation speed, rpm" annotation(
    HideResult=false);
  inner parameter Modelica.SIunits.MassFlowRate WcDes_1(fixed=false, start=Wc_1_init) "corrected mass flow rate" annotation(
    HideResult=false);
  inner parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm NcDes_1(fixed=false, start=Nc_1_init) annotation(
    HideResult=false);
  parameter Real PRdes(fixed=false, start=PR_init) annotation(
    HideResult=false);
  parameter Real effDes(fixed=false, start=eff_init) annotation(
    HideResult=false);
  
  
initial equation
  /* ---------------------------------------------
    determine design point
  --------------------------------------------- */
  NcDes_1 = NmechDes / sqrt(Tdes_1 / environment.Tstd);
  WcDes_1 = m_flow_des_1 * sqrt(Tdes_1 / environment.Tstd) / (pDes_1 / environment.pStd);
  
  
      
algorithm
  assert(PR < 0.0, getInstanceName() + ", PR got less than 0" + ", fluid_1.p=" + String(fluid_1.p) + ", fluid_2.p=" + String(fluid_2.p), AssertionLevel.warning);

equation
/* ---------------------------------------------
  Connections, interface <-> internal variables
  --------------------------------------------- */
//-- fluidPort_1 --
  fluid_1.p = port_1.p;
  fluid_1.h = actualStream(port_1.h_outflow);
  fluid_1.Xi = actualStream(port_1.Xi_outflow);
//-- fluidPort_2 --
  fluid_2.p = port_2.p;
  fluid_2.h = actualStream(port_2.h_outflow);
  fluid_2.Xi = actualStream(port_2.Xi_outflow);
// distinguish inlet side
  m_flow_max = max(port_1.m_flow, port_2.m_flow);
  m_flow_min= min(port_1.m_flow, port_2.m_flow);
  
  if(m_flow_max == port_1.m_flow)then
    port_1.h_outflow= fluid_1.h;
    port_1.Xi_outflow= fluid_1.Xi;
  elseif(m_flow_max == port_2.m_flow)then
    port_2.h_outflow= fluid_2.h;
    port_2.Xi_outflow= fluid_2.Xi;
  else
    port_1.h_outflow= fluid_1.h;
    port_1.Xi_outflow= fluid_1.Xi;
  end if;
//-- shaft --
  flange_1.phi = phi;
  flange_2.phi = phi;
  
  
  /* ---------------------------------------------
  Eqns describing physics
  --------------------------------------------- */
  Wc_1 = port_1.m_flow * sqrt(fluid_1.T / environment.Tstd) / (fluid_1.p / environment.pStd);
  Nc_1 = Nmech / sqrt(fluid_1.T / environment.Tstd);
  
  PR = fluid_1.p / fluid_2.p;
  
  h_2is= Medium.isentropicEnthalpy(fluid_2.p, fluid_1.state);
  dht_is = fluid_1.h - h_2is;
  eff = dht / dht_is;
  dht = fluid_1.h - fluid_2.h;
  
  port_1.m_flow + port_2.m_flow = 0.0;
  fluid_2.Xi = fluid_1.Xi;
  
  trq = flange_1.tau + flange_2.tau;
  pwr = -1.0 * (port_1.m_flow * fluid_1.h + port_2.m_flow * fluid_2.h);
  der(phi) = omega;
  omega * trq = pwr;
  Nmech = Modelica.SIunits.Conversions.NonSIunits.to_rpm(omega);
  
  pwr_inv= -1*pwr;
  trq_inv= -1*trq;
  s_fluid_1= Medium.specificEntropy(fluid_1.state);
  s_fluid_2= Medium.specificEntropy(fluid_2.state);
//-- variables relative to design point --
  NqNdes = Nmech / NmechDes;
  NcqNcDes_1 = Nc_1 / NcDes_1;
  
  
/********************************************************
  Graphics
********************************************************/
  annotation(
    Icon(graphics = {Polygon(origin = {30, 0}, fillColor = {255, 157, 0}, fillPattern = FillPattern.Solid, points = {{-90, 0}, {-90, -20}, {30, -80}, {30, 80}, {-90, 20}, {-90, 0}}), Rectangle(origin = {84, 6}, fillPattern = FillPattern.Solid, extent = {{-24, 4}, {16, -16}}), Rectangle(origin = {-86, 6}, fillPattern = FillPattern.Solid, extent = {{-12, 4}, {26, -16}}), Text(origin = {-43, 95}, extent = {{-37, 5}, {123, -15}}, textString = "%name"), Rectangle(origin = {-57, 30}, fillColor = {165, 165, 165}, fillPattern = FillPattern.Solid, extent = {{-3, 52}, {1, -10}}), Rectangle(origin = {-99, 16}, fillColor = {165, 165, 165}, fillPattern = FillPattern.Solid, extent = {{-1, 66}, {43, 62}}), Rectangle(origin = {63, 16}, fillColor = {165, 165, 165}, fillPattern = FillPattern.Solid, extent = {{-3, 66}, {37, 62}}), Text(origin = {-37, 11}, extent = {{-23, 9}, {97, -31}}, textString = "Trb")}, coordinateSystem(initialScale = 0.1)),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
  
  
end TurbineBase00;
