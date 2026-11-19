import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("PerfectNumberModule", (m) => {
  const perfectnumber = m.contract("PerfectNumber");
  return { perfectnumber };
});
