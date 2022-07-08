const fs = require("fs");
const solidityRegex = /pragma solidity \^\d+\.\d+\.\d+/

const verifierRegex = /contract Verifier/
const plonkVerifierRegex = /contract PlonkVerifier/

function bumpSolidity(regex, contractName) {
    let contractPath = "./contracts/" + contractName + ".sol"
    let content = fs.readFileSync(contractPath, { encoding: 'utf-8' });
    let bumped = content.replace(solidityRegex, 'pragma solidity ^0.8.0');
    bumped = bumped.replace(regex, 'contract ' + contractName);
    fs.writeFileSync(contractPath, bumped);
}


bumpSolidity(verifierRegex, "HelloWorldVerifier");
bumpSolidity(verifierRegex, "Multiplier3Verifier");
bumpSolidity(plonkVerifierRegex, "Multiplier3PlonkVerifier");