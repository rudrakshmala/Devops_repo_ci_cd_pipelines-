import hardhatToolboxViemPlugin from "@nomicfoundation/hardhat-toolbox-viem";
import { configVariable, defineConfig } from "hardhat/config";

export default defineConfig({
  plugins: [hardhatToolboxViemPlugin],
  solidity: "0.8.21",
  networks: {
    localhost: {
      type: "http",
      url: "http://127.0.0.1:8545",
    },
  },
});
