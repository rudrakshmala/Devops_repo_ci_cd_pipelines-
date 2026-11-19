import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("AdditionModule", (m) => {
  const addition = m.contract("Addition");
  return { addition };
});
