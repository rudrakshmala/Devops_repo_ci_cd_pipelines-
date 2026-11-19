import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("PrimeCheckerModule", (m) => {
  const primechecker = m.contract("PrimeChecker");
  return { primechecker };
});
