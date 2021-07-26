within PropulsionSystem.Subelements.Functions.Combustion;

function effCombGasoline00
  extends Modelica.Icons.Function;
  /* ************************************************************
  ref:
    https://x-engineer.org/automotive-engineering/internal-combustion-engines/performance/air-fuel-ratio-lambda-engine-performance/
  ************************************************************ */
  
  //********** declare inputs **********
  input Real fracAir;
  input Real fracFuel;
  //********** declare outputs **********
  output Real effComb;
  output Real lambda;
  output Real AFR;
  output Boolean flagValid;
protected
  //********** declare local variables **********
  Real LboundLambdaValid = 0.8;
  Real UboundLambdaValid = 1.2;
  Real AFRstoichiometric = 14.7;
algorithm
  AFR := fracAir / fracFuel;
  lambda := AFR / AFRstoichiometric;
  //----------
  if lambda < LboundLambdaValid then
    flagValid := false;
  elseif UboundLambdaValid < lambda then
    flagValid := false;
  else
    flagValid := true;
  end if;
  //----------
  if (UboundLambdaValid < lambda) then
    effComb := (-1.6082) + 4.6509 * UboundLambdaValid - 2.0746 * UboundLambdaValid ^ 2.0;
  else
    effComb := (-1.6082) + 4.6509 * lambda - 2.0746 * lambda ^ 2.0;
  end if;
  //----------
  if effComb < 0.0 then
    effComb := 0.0;
  elseif 1.0 < effComb then
    effComb := 1.0;
  end if;
end effCombGasoline00;
