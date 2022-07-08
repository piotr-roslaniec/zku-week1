pragma circom 2.0.0;

template Multiplier3 () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;
   signal input c;
   signal tmp;
   signal output d;  

   // Constraints.
   tmp <== a * b;  
   d <== tmp * c;  
}

component main = Multiplier3();