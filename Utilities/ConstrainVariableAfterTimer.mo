within PropulsionSystem.Utilities;

model ConstrainVariableAfterTimer
  import Modelica.SIunits;
  /* ---------------------------------------------
                parameters    
    --------------------------------------------- */
  parameter SIunits.Time timeToEndConstraint = 0.1 "Variable is constrained before and including this time" annotation(
    Dialog(group = "Characteristics"));
  /* ---------------------------------------------
        Internal variables
    --------------------------------------------- */
  Real augVar1;
  Real k_u_variable;
  Real k_augVar1;
  /* ---------------------------------------------
                internal objects    
    --------------------------------------------- */
  PropulsionSystem.Utilities.ConstrainVariable Constraint annotation(
    Placement(visible = true, transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  /* ---------------------------------------------
                interface    
    --------------------------------------------- */
  Modelica.Blocks.Interfaces.RealInput u_variable annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_targetValue "" annotation(
    Placement(visible = true, transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
  //******************************************************************************************
protected
  //******************************************************************************************
initial equation
  k_u_variable = 0.0;
  k_augVar1 = 1.0;
//******************************************************************************************
algorithm
//******************************************************************************************
equation
  connect(Constraint.u_targetValue, u_targetValue) annotation(
    Line(points = {{62, 0}, {104, 0}, {104, 0}, {120, 0}}, color = {0, 0, 127}));
  if time <= timeToEndConstraint then
    k_u_variable = 0;
    k_augVar1 = 1;
  else
    k_u_variable = 1;
    k_augVar1 = 0;
  end if;
  Constraint.u_variable = k_u_variable * u_variable + augVar1*k_augVar1;
  annotation(
    defaultComponentName = "Constraint",
    Diagram,
    Icon(graphics = {Rectangle(fillColor = {170, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-3, -83}, lineColor = {255, 255, 255}, extent = {{-97, 3}, {103, -17}}, textString = "%name"), Text(origin = {-3, 37}, lineColor = {255, 255, 255}, extent = {{-97, 3}, {103, -37}}, textString = "Constraint", fontSize = 34), Text(origin = {-3, -3}, lineColor = {255, 255, 255}, extent = {{-97, 3}, {103, -37}}, textString = "Until Timer", fontSize = 34)}, coordinateSystem(initialScale = 0.1)));
end ConstrainVariableAfterTimer;
