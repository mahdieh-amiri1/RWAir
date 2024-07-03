import { Manifest } from "@redstone-finance/oracle-node/src/types";

export const getNotBroadcastedDataFeeds = (manifest: Manifest) =>
  Object.keys(manifest.tokens).filter(
    (dataFeedId) => !manifest.tokens[dataFeedId].skipBroadcasting
  );
