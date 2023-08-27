within PropulsionSystem.Functions.TurbineFunctionPackage;

function TurbineFluidOperation00
  extends Modelica.Icons.Function;
  //****************************************
  import units= Modelica.Units.SI;
  //****************************************
  replaceable package inFuncMedium = Modelica.Media.Interfaces.PartialMedium annotation(
    choicesAllMatching = true);
  //----------
  input inFuncMedium.ThermodynamicState state_1;
  input units.MassFlowRate m_flow1;
  input Real PR;
  input Real eff;
  
  /*
  */
  //----------
  output units.Pressure p2;
  output units.SpecificEnthalpy h2;
  output inFuncMedium.MassFraction X2[:];
  output units.SpecificEnthalpy h_2is;
  output units.Power pwr;
  //----------
  
//*******************************************************
protected
  units.SpecificEnthalpy h1;
  inFuncMedium.MassFraction X1[inFuncMedium.nX];
  /**/
//*******************************************************
algorithm
  /*
  */
  X1:= if(inFuncMedium.nX==1) then inFuncMedium.X_default else state_1.X;
  h1:=inFuncMedium.specificEnthalpy(state_1);
  
  X2:=X1;
  p2:= state_1.p/PR;
  h_2is:= inFuncMedium.isentropicEnthalpy(p2, state_1);
  h2:= h1 + eff*(h_2is - h1);
  //-----
  pwr:= (h2-h1)*m_flow1;
  /**/
end TurbineFluidOperation00;
