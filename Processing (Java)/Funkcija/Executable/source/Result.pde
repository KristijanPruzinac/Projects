
double result(float x, String function){
  double return_val = 0;
  
  Expression e = new ExpressionBuilder(function)
                .variables("x")
                .build()
                .setVariable("x", x);
  
  return_val = e.evaluate();
  
  return return_val;
}
