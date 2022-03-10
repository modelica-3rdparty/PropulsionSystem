within PropulsionSystem.Functions.PropellerFunctionPackage;

function relate_J_Jdes00
  extends Modelica.Icons.Function;
  //****************************************
  import Units= Modelica.SIunits;
  //****************************************
  input Real t;
  input Real tSwitch;
  input Real Jdes;
  input Real auxVar;
  //-----
  output Real J;
  
protected
  Real kDes;
  Real kVar;
  
algorithm
  
  if noEvent(t<=tSwitch) then
    kDes := 1;
    kVar := 0;
  else
    kDes := 0;
    kVar := 1;
  end if;
  
  J:= Jdes*kDes + auxVar*kVar;
  
end relate_J_Jdes00;
