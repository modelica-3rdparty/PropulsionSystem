within PropulsionSystem.Elements.BasicElements;

model CmpCharTable01
  extends PropulsionSystem.BaseClasses.BasicElements.CompressorBase00;
  /********************************************************
          imports   
    ********************************************************/
  import Modelica.Constants;
  import PropulsionSystem.Types.switches;
  /********************************************************
          Declaration   
    ********************************************************/
  /* ---------------------------------------------
          switches
    --------------------------------------------- */
  parameter PropulsionSystem.Types.switches.switchHowToDetVar switchDetermine_PR = PropulsionSystem.Types.switches.switchHowToDetVar.param "switch how to determine PR" annotation(
    Dialog(group = "switch"),
    choicesAllMatching = true,
    Evaluate = true,
    HideResult = true);
  parameter Boolean use_u_eff = false "get eff from the real input connector" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  
  
  /* ---------------------------------------------
          parameters    
    --------------------------------------------- */
  inner parameter Real PRdes_paramInput = 10 "pressure ratio, valid only when switchDetermine_PR==param, value fixed through simulation" annotation(
    Dialog(group = "Component characteristics"));
  inner parameter Real effDes_paramInput = 0.80 "adiabatic efficiency, valid only when use_u_eff==false, value fixed through simulation" annotation(
    Dialog(group = "Component characteristics"));
  
  parameter Modelica.SIunits.Time timeRemoveDesConstraint=environment.timeRemoveDesConstraint annotation(
    Dialog(group = "Simulation setting"));
  
  
  /* ---------------------------------------------
          Interface   
    --------------------------------------------- */
  Modelica.Blocks.Interfaces.RealInput u_PR if switchDetermine_PR == PropulsionSystem.Types.switches.switchHowToDetVar.viaRealInput "PR input, valid only when switchDetermine_PR==viaRealInput" annotation(
    Placement(visible = true, transformation(origin = {-60, -112}, extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {-40, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput u_eff if use_u_eff "eff input, valid only when use_u_eff==true" annotation(
    Placement(visible = true, transformation(origin = {-20, -112}, extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  //********************************************************************************
initial algorithm
//--------------------
  PRdes := PRdes_paramInput;
  effDes := effDes_paramInput;
  //********************************************************************************
initial equation
  /* ---------------------------------------------
    determine design point
  --------------------------------------------- */
  fluid_1.p=fluid_1_des.p;
  fluid_1.T=fluid_1_des.T;
  Nmech=NmechDes;
  //********************************************************************************
algorithm
//##### none #####
equation
  /* ---------------------------------------------
  design point constraint
  --------------------------------------------- */
  if (noEvent(time<=timeRemoveDesConstraint)) then
    port_1.m_flow=fluid_1_des.m_flow;
  else
    Wc_1= Wc_1_des*NqNdes;    
  end if;
  
//--------------------
  if switchDetermine_PR == PropulsionSystem.Types.switches.switchHowToDetVar.param then
    PR = PRdes_paramInput;
  elseif switchDetermine_PR == PropulsionSystem.Types.switches.switchHowToDetVar.viaRealInput then
    PR = u_PR;
  end if;
//--------------------
  if use_u_eff == false then
    eff = effDes_paramInput;
  elseif use_u_eff == true then
    eff = u_eff;
  end if;
//--------------------
/********************************************************
  Graphics
********************************************************/
  annotation(
    defaultComponentName = "Cmp",
    Documentation(info = "<html>
  <a href=modelica://PropulsionSystem/docs/Elements/BasicElements/CmpCharFixed00.html> Document html page</a>
  
  <h4>example/demo models</h4>
    <ul>
    <li><a href=\"modelica://PropulsionSystem.Examples.Elements.BasicElements.CmpCharFixed00_ex01\"> PropulsionSystem.Examples.BasicElements.CmpCharFixed00_ex01 </a> </li>
    <li><a href=\"modelica://PropulsionSystem.Examples.Elements.BasicElements.CmpCharFixed00_ex02\"> PropulsionSystem.Examples.BasicElements.CmpCharFixed00_ex02 </a> </li>
    <li><a href=\"modelica://PropulsionSystem.Examples.Elements.BasicElements.Cmp_and_Trb_ex01\"> PropulsionSystem.Examples.BasicElements.Cmp_and_Trb_ex01 </a> </li>
    <li><a href=\"modelica://PropulsionSystem.Examples.Elements.BasicElements.Cmp_and_Trb_ex02\"> PropulsionSystem.Examples.BasicElements.Cmp_and_Trb_ex02 </a> </li>
    </ul>
    
  <h4>classes which this component call (those in MSL are not listed) </h4>
    <p> -> none </p>
    
  <h4>classes from which this component extend </h4>
    <ul>
    <li><a href=\"modelica://PropulsionSystem.BaseClasses.BasicElements.CompressorBase00\"> PropulsionSystem.BaseClasses.BasicElements.CompressorBase00 </a> </li>
    </ul>

</html>"));
end CmpCharTable01;
