pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/comparators.circom";
include "../../node_modules/circomlib-matrix/circuits/matMul.circom";

template SystemOfEquations(n) { // n is the number of variables in the system of equations
    signal input x[n]; // this is the solution to the system of equations
    signal input A[n][n]; // this is the coefficient matrix
    signal input b[n]; // this are the constants in the system of equations
    signal output out; // 1 for correct solution, 0 for incorrect solution

    // calculate A*b    
    component matMul = matMul(n, n, 1);
    for (var i=0; i < n; i++) {
        matMul.b[i][0] <== x[i];
        for (var j=0; j < n; j++) {
            matMul.a[i][j] <== A[i][j];    
        }
    }

    // check whether A*b is equal to x
    component isEqual[n];
    var equalCounter = 0;
    for (var i=0; i < n; i++) {
        isEqual[i] = IsEqual();
        isEqual[i].in[0] <== matMul.out[i][0];
        isEqual[i].in[1] <== b[i];
        equalCounter += isEqual[i].out;
    }

    component allAreEqual = IsEqual();
    allAreEqual.in[0] <== equalCounter;
    allAreEqual.in[1] <== n;

    out <== allAreEqual.out;
}

component main {public [A, b]} = SystemOfEquations(3);