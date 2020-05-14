within PropulsionSystem.Elements.BasicElements;

model CmpCharTable01
  //********************************************************************************
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
  parameter Boolean use_u_s_WcAud = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_a_WcAud = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_s_PRaud = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_a_PRaud = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_s_effAud = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  parameter Boolean use_u_a_effAud = false "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch"));
  //----------
  parameter Boolean use_tableFile_Wc = true "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch about table file reading"));
  parameter Boolean use_tableFile_PR = true "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch about table file reading"));
  parameter Boolean use_tableFile_eff = true "" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "switch about table file reading"));
  parameter PropulsionSystem.Types.switches.switchTableDataResource switchTableDataLocation = PropulsionSystem.Types.switches.switchTableDataResource.inLibraryDirectory "where table data file is located, valid if use_tableFile_..==true" annotation(
    Dialog(group = "switch about table file reading"));
  parameter Modelica.Blocks.Types.Smoothness switchSmoothness_Wc = Modelica.Blocks.Types.Smoothness.ContinuousDerivative "" annotation(
    Dialog(group = "switch about interpolation"));
  parameter Modelica.Blocks.Types.Smoothness switchSmoothness_PR = Modelica.Blocks.Types.Smoothness.ContinuousDerivative "" annotation(
    Dialog(group = "switch about interpolation"));
  parameter Modelica.Blocks.Types.Smoothness switchSmoothness_eff = Modelica.Blocks.Types.Smoothness.ContinuousDerivative "" annotation(
    Dialog(group = "switch about interpolation"));
  /* ---------------------------------------------
                    parameters
      --------------------------------------------- */
  inner parameter Real PRdes_paramInput = 10 "pressure ratio, valid only when switchDetermine_PR==param, value fixed through simulation" annotation(
    Dialog(group = "Component characteristics"));
  inner parameter Real effDes_paramInput = 0.80 "adiabatic efficiency, valid only when use_u_eff==false, value fixed through simulation" annotation(
    Dialog(group = "Component characteristics"));
  //----------
  parameter Modelica.SIunits.MassFlowRate m_flow_des_1_paramInput = 1.0 "" annotation(
    Dialog(group = "Component sizing"));
  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm NmechDes_paramInput = 3000.0 "" annotation(
    Dialog(group = "Component sizing"));
  parameter Real NcTblDes_paramInput = 1.0 "design point definition on characteristics table" annotation(
    Dialog(group = "Component sizing"));
  parameter Real RlineTblDes_paramInput = 0.774 "design point definition on table" annotation(
    Dialog(group = "Component sizing"));
  //----------
  parameter String pathName_tableFileInSimExeDir = "./tableData/table_Compressor_WcPReff_NcRline00.txt" "relative path under sim. exe. file directory" annotation(
    Dialog(group = "table file read setting"));
  parameter String pathName_tableFileInLibPackage = "modelica://PropulsionSystem/tableData/table_Compressor_WcPReff_NcRline00.txt" "path in library sub-directory" annotation(
    Dialog(group = "table file read setting"));
  parameter String tableName_Wc = "Wc_NcRline" "" annotation(
    Dialog(group = "table file read setting"));
  parameter String tableName_PR = "PR_NcRline" "" annotation(
    Dialog(group = "table file read setting"));
  parameter String tableName_eff = "eff_NcRline" "" annotation(
    Dialog(group = "table file read setting"));
  /* ---------------------------------------------
                    Internal variables
        --------------------------------------------- */
  Real Rline(start=Modelica.Constants.pi/4.0) annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Real s_WcAud(start=1.0) annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Real s_PRaud(start=1.0) annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Real s_effAud(start=1.0) annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Real a_WcAud(start=0.0) annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Real a_PRaud(start=0.0) annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  Real a_effAud(start=0.0) annotation(
    Dialog(tab="Variables", group="start attribute" ,enable=false, showStartAttribute=true)
  );
  
  
  /* ---------------------------------------------
                    Internal objects
  --------------------------------------------- */
  PropulsionSystem.Subelements.CompressorTable_WcPReff_NcRline00 CmpTbl_WcPReff_NcRline(use_tableFile_Wc = use_tableFile_Wc, use_tableFile_PR = use_tableFile_PR, use_tableFile_eff = use_tableFile_eff, switchTableDataLocation = switchTableDataLocation, switchSmoothness_Wc = switchSmoothness_Wc, switchSmoothness_PR = switchSmoothness_PR, switchSmoothness_eff = switchSmoothness_eff, pathName_tableFileInSimExeDir = pathName_tableFileInSimExeDir, pathName_tableFileInLibPackage = pathName_tableFileInLibPackage, tableName_Wc = tableName_Wc, tableName_PR = tableName_PR, tableName_eff = tableName_eff) annotation(
    Placement(visible = true, transformation(origin = {20, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Subelements.SclCmp_WcPReff00 SclCmp annotation(
    Placement(visible = true, transformation(origin = {50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PropulsionSystem.Subelements.ScalerDesCmp_WcPReffNc00 ScalerDesCmp(use_tableFile_Wc = use_tableFile_Wc, use_tableFile_PR = use_tableFile_PR, use_tableFile_eff = use_tableFile_eff, switchTableDataLocation = switchTableDataLocation, switchSmoothness_Wc = switchSmoothness_Wc, switchSmoothness_PR = switchSmoothness_PR, switchSmoothness_eff = switchSmoothness_eff, pathName_tableFileInSimExeDir = pathName_tableFileInSimExeDir, pathName_tableFileInLibPackage = pathName_tableFileInLibPackage, tableName_Wc = tableName_Wc, tableName_PR = tableName_PR, tableName_eff = tableName_eff) annotation(
    Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Division division_NcTbl(
    u1(start=1.0, min=1.0e-10),
    u2(start=3000.0, min=1.0e-10)
  ) annotation(
    Placement(visible = true, transformation(origin = {-10, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(
    limitsAtInit = true, uMax = Modelica.Constants.inf, uMin = 1e-10,
    u(start=3000.0, min=1.0e-10),
    y(start=3000.0, min=1.0e-10)
  )  annotation(
    Placement(visible = true, transformation(origin = {-40, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  
  /* ---------------------------------------------
                    Interface
    --------------------------------------------- */
  input Modelica.Blocks.Interfaces.RealInput u_s_WcAud if use_u_s_WcAud "" annotation(
    Placement(visible = true, transformation(origin = {-100, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {-100, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  input Modelica.Blocks.Interfaces.RealInput u_s_PRaud if use_u_s_PRaud "" annotation(
    Placement(visible = true, transformation(origin = {-20, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {-20, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  input Modelica.Blocks.Interfaces.RealInput u_s_effAud if use_u_s_effAud "" annotation(
    Placement(visible = true, transformation(origin = {60, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {60, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  input Modelica.Blocks.Interfaces.RealInput u_a_WcAud if use_u_a_WcAud "" annotation(
    Placement(visible = true, transformation(origin = {-60, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {-60, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  input Modelica.Blocks.Interfaces.RealInput u_a_PRaud if use_u_a_PRaud "" annotation(
    Placement(visible = true, transformation(origin = {20, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {20, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  input Modelica.Blocks.Interfaces.RealInput u_a_effAud if use_u_a_effAud "" annotation(
    Placement(visible = true, transformation(origin = {100, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {100, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
initial algorithm
/* ---------------------------------------------
    determine design point
  --------------------------------------------- */
  /*
  
  m_flow_des_1 := m_flow_des_1_paramInput;
  */
  effDes := effDes_paramInput;
  PRdes := PRdes_paramInput;
  
  //eff:=effDes;
  //PR:=PRdes;
  //Wc_1:= WcDes_1;
  //NmechDes := NmechDes_paramInput;
  NmechDes:= Modelica.SIunits.Conversions.NonSIunits.to_rpm(omega);
  m_flow_des_1:= port_1.m_flow;
  
  
  
initial equation
/* ---------------------------------------------
    determine design point
  --------------------------------------------- */
  /*
  pDes_1 = fluid_1.p;
  Tdes_1 = fluid_1.T;
  */
  
  
  //effDes = effDes_paramInput;
  //PRdes = PRdes_paramInput;
  /**/
  //NmechDes = NmechDes_paramInput;
  //m_flow_des_1 = m_flow_des_1_paramInput;
  
  //port_1.m_flow=m_flow_des_1;
  
algorithm
/* ---------------------------------------------
    interface
  --------------------------------------------- */
//-- scalers --
//--------------------
  if use_u_s_WcAud == false then
    s_WcAud := 1.0;
  elseif use_u_s_WcAud == true then
    s_WcAud := u_s_WcAud;
  end if;
//--------------------
  if use_u_s_PRaud == false then
    s_PRaud := 1.0;
  elseif use_u_s_PRaud == true then
    s_PRaud := u_s_PRaud;
  end if;
//--------------------
  if use_u_s_effAud == false then
    s_effAud := 1.0;
  elseif use_u_s_effAud == true then
    s_effAud := u_s_effAud;
  end if;
//-- adders --
//--------------------
  if use_u_a_WcAud == false then
    a_WcAud := 0.0;
  elseif use_u_a_WcAud == true then
    a_WcAud := u_a_WcAud;
  end if;
//--------------------
  if use_u_a_PRaud == false then
    a_PRaud := 0.0;
  elseif use_u_a_PRaud == true then
    a_PRaud := u_a_PRaud;
  end if;
//--------------------
  if use_u_a_effAud == false then
    a_effAud := 0.0;
  elseif use_u_a_effAud == true then
    a_effAud := u_a_effAud;
  end if;
equation
  connect(limiter1.y, division_NcTbl.u2) annotation(
    Line(points = {{-28, 34}, {-22, 34}, {-22, 34}, {-22, 34}}, color = {0, 0, 127}));
  connect(ScalerDesCmp.y_s_NcDes, limiter1.u) annotation(
    Line(points = {{-58, 78}, {-56, 78}, {-56, 34}, {-52, 34}, {-52, 34}}, color = {0, 0, 127}));
  connect(division_NcTbl.y, CmpTbl_WcPReff_NcRline.u_NcTbl) annotation(
    Line(points = {{1, 40}, {5.5, 40}, {5.5, 34}, {10, 34}}, color = {0, 0, 127}));
  connect(CmpTbl_WcPReff_NcRline.y_eff, SclCmp.u_eff) annotation(
    Line(points = {{31, 24}, {39, 24}}, color = {0, 0, 127}));
  connect(CmpTbl_WcPReff_NcRline.y_PR, SclCmp.u_PR) annotation(
    Line(points = {{31, 30}, {39, 30}}, color = {0, 0, 127}));
  connect(CmpTbl_WcPReff_NcRline.y_Wc, SclCmp.u_Wc) annotation(
    Line(points = {{31, 36}, {39, 36}}, color = {0, 0, 127}));
  connect(ScalerDesCmp.y_s_effDes, SclCmp.u_s_eff) annotation(
    Line(points = {{-58, 62}, {56, 62}, {56, 41}}, color = {0, 0, 127}));
  connect(ScalerDesCmp.y_s_PRdes, SclCmp.u_s_PR) annotation(
    Line(points = {{-58, 66}, {50, 66}, {50, 41}}, color = {0, 0, 127}));
  connect(ScalerDesCmp.y_s_WcDes, SclCmp.u_s_Wc) annotation(
    Line(points = {{-58, 74}, {44, 74}, {44, 41}}, color = {0, 0, 127}));
//----------
  ScalerDesCmp.u_NcTblDes = NcTblDes_paramInput;
  ScalerDesCmp.u_RlineTblDes = RlineTblDes_paramInput;
  ScalerDesCmp.u_NcDes = NcDes_1;
  ScalerDesCmp.u_WcDes = WcDes_1;
  ScalerDesCmp.u_PRdes = PRdes;
  ScalerDesCmp.u_effDes = effDes;
  
  division_NcTbl.u1 = Nc_1;
  CmpTbl_WcPReff_NcRline.u_RlineTbl = Rline;
  
//----------
  
//----------
/* ---------------------------------------------
    component characteristics
  --------------------------------------------- */
  /*
  eff = SclCmp.y_effScld * s_effAud + a_effAud;
  PR = (SclCmp.y_PRscld - 1.0) * s_PRaud + 1.0 + a_PRaud;
  Wc_1 = SclCmp.y_WcScld * s_WcAud + a_WcAud;
  
  */
  
  if(time==0.0)then
    //m_flow_des_1 = m_flow_des_1_paramInput;
    /**/
    
    eff=effDes;
    PR=PRdes;
    Wc_1=WcDes_1;
    /*
    division_NcTbl.u1 = NcTblDes_paramInput;
    CmpTbl_WcPReff_NcRline.u_RlineTbl = RlineTblDes_paramInput;
    */
  else
    eff = SclCmp.y_effScld * s_effAud + a_effAud;
    PR = (SclCmp.y_PRscld - 1.0) * s_PRaud + 1.0 + a_PRaud;
    Wc_1 = SclCmp.y_WcScld * s_WcAud + a_WcAud;
    
    
  end if;
  
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

</html>"),
    Diagram,
    __OpenModelica_commandLineOptions = "");
end CmpCharTable01;
