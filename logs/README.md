# Possible wrangler error

This `pb.log` is from an attempt to delete all of the order picos with empty status,
using the `com.wccargo.cleanup` ruleset.
It correctly identified the picos to be deleted and started the process of deleting them.
But failed during the first such deletion, 
which caused the entire event to end.
