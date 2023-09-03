within PropulsionSystem.BaseClasses.BasicElements;

partial model HeatInjectorBase00
  /********************************************************
      imports
  ********************************************************/
  import Modelica.Constants;
  import PropulsionSystem.Types.switches;
  import units=Modelica.Units.SI;
  
  /********************************************************
      Declaration
  ********************************************************/
  /* ---------------------------------------------
      Package
  --------------------------------------------- */
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching = true);
  
  
  
  /* ---------------------------------------------
      switch
  --------------------------------------------- */
  parameter Boolean allowFlowReversal= false
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation(
      Dialog(tab="Assumptions"), Evaluate=true);
  
  
  
  /* ---------------------------------------------
      parameters
  --------------------------------------------- */
  //********** Initialization Parameters **********
  //--- fluid_1, port_1 ---
  parameter units.MassFlowRate m_flow1_init(displayUnit = "kg/s") = 1.0 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_1"));
  parameter units.Pressure p1_init(displayUnit = "Pa") = 20*101.3 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_1"));
  parameter units.Temperature T1_init(displayUnit = "K") = 800 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_1"));
  parameter units.SpecificEnthalpy h1_init(displayUnit = "J/kg") = T1_init*1.004 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_1"));
  //--- fluid_2, port_2 ---
  parameter units.MassFlowRate m_flow2_init(displayUnit = "kg/s") = -1.0 * m_flow1_init "" annotation(
    Dialog(tab = "Initialization", group = "fluid_2"));
  parameter units.Pressure p2_init(displayUnit = "Pa") = p1_init "" annotation(
    Dialog(tab = "Initialization", group = "fluid_2"));
  parameter units.Temperature T2_init(displayUnit = "K") = 1600.0 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_2"));
  parameter units.SpecificEnthalpy h2_init(displayUnit = "J/kg") = T2_init*1.004 * 1000 "" annotation(
    Dialog(tab = "Initialization", group = "fluid_2"));
  //--- HeatPort_1 ---
  parameter units.HeatFlowRate Q_flow1_init=m_flow1_init*(h2_init-h1_init) "" annotation(
    Dialog(tab = "Initialization", group = "HeatPort_1"));
  parameter units.Temperature Twall1_init= T2_init "" annotation(
    Dialog(tab = "Initialization", group = "HeatPort_1"));
  //--- others ---
  parameter units.SpecificEntropy s_fluid_1_init=7000.0 "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  parameter units.SpecificEntropy s_fluid_2_init=7800.0 "" annotation(
    Dialog(tab = "Initialization", group = "others")
  );
  
  
  
  /* ---------------------------------------------
      Internal variables
  --------------------------------------------- */
  units.SpecificEntropy s_fluid_1(start=s_fluid_1_init) "specific entropy, fluid_1" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  units.SpecificEntropy s_fluid_2(start=s_fluid_2_init) "specific entropy, fluid_2" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  
  units.MassFlowRate m_flow_max(start=m_flow1_init) "" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  units.MassFlowRate m_flow_min(start=m_flow2_init) "" annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  
  
  
  /* ---------------------------------------------
      Internal objects
  --------------------------------------------- */
  Medium.BaseProperties fluid_1(
    p(start = p1_init, min=0.0+1.0e-10), 
    T(start = T1_init, min=0.0+1.0e-10), 
    state.p(start = p1_init, min=0.0+1.0e-10), 
    state.T(start = T1_init, min=0.0+1.0e-10), 
    h(start = h1_init, min=0.0+1.0e-10)
  ) "flow station of inlet";
  Medium.BaseProperties fluid_2(
    p(start = p2_init, min=0.0+1.0e-10), 
    T(start = T2_init, min=0.0+1.0e-10), 
    state.p(start = p2_init, min=0.0+1.0e-10), 
    state.T(start = T2_init, min=0.0+1.0e-10), 
    h(start = h2_init, min=0.0+1.0e-10)
  ) "flow station of outlet";
  
  
  
  /* ---------------------------------------------
      Interface
  --------------------------------------------- */
  Modelica.Fluid.Interfaces.FluidPort_a port_1(
    redeclare package Medium = Medium, 
    m_flow(start = m_flow1_init), 
    h_outflow(start = h1_init, min=0.0+1.0e-10), 
    p(start=p1_init, min=0.0+1.0e-10)
  ) "" annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_2(
    redeclare package Medium = Medium, 
    m_flow(start = m_flow2_init), 
    h_outflow(start = h2_init, min=0.0+1.0e-10), 
    p(start=p2_init, min=0.0+1.0e-10)
  ) "" annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_1(
    Q_flow(start=Q_flow1_init), 
    T(start=Twall1_init, min=0.0+1.0e-10)
  )
    ""
    annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Types.ElementBus elementBus1 annotation(
    Placement(visible = true, transformation(origin = {70, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  
algorithm
//##### none #####

initial equation
//##### none #####

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
  m_flow_max= max(port_1.m_flow, port_2.m_flow);
  m_flow_min= min(port_1.m_flow, port_2.m_flow);
  
  if(allowFlowReversal==false)then
    port_1.h_outflow= fluid_1.h;
    port_1.Xi_outflow= fluid_1.Xi;
  else
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
  end if;
  
  
  /* ---------------------------------------------
  Eqns describing physics
  --------------------------------------------- */
  fluid_2.p = fluid_1.p;  //no pressure drop
  //-- mass conservation --
  port_1.m_flow + port_2.m_flow = 0.0;
  fluid_1.Xi = fluid_2.Xi;
  //-- energy conservation --
  (port_1.m_flow * fluid_1.h) + HeatPort_1.Q_flow + (port_2.m_flow * fluid_2.h) = 0.0;
  
  //-- wall temperature --
  HeatPort_1.T = fluid_2.T;
  
  s_fluid_1= Medium.specificEntropy(fluid_1.state);
  s_fluid_2= Medium.specificEntropy(fluid_2.state);
  
  
/********************************************************
  Graphics
********************************************************/
  annotation(
    Icon(graphics = {Text(origin = {-17, -51}, extent = {{-63, 11}, {97, -9}}, textString = "%name"), Rectangle(origin = {-51, 1}, rotation = -90, fillColor = {118, 118, 118}, fillPattern = FillPattern.Solid, extent = {{-2, -9}, {2, -49}}), Text(origin = {16, 78}, extent = {{0, 10}, {82, -30}}, textString = "Q_flow"), Rectangle(origin = {7, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-67, 40}, {53, -40}}), Line(origin = {-0.119719, 70.9859}, points = {{0, 26}, {0, -70}}, thickness = 4, arrow = {Arrow.None, Arrow.Open}, arrowSize = 10), Rectangle(origin = {109, 0}, rotation = -90, fillColor = {118, 118, 118}, fillPattern = FillPattern.Solid, extent = {{-2, -9}, {2, -49}})}, coordinateSystem(initialScale = 0.1)),
    Diagram(graphics = {Line(origin = {-3.37324, 53.9296}, points = {{0, 37}, {0, -27}}, thickness = 1, arrow = {Arrow.None, Arrow.Filled}), Text(origin = {30, 52}, extent = {{-22, 4}, {22, -4}}, textString = "heat injected into fluid")}, coordinateSystem(initialScale = 0.1)));
end HeatInjectorBase00;
