# wccargo

## steps taken

1. install node *
1. install pico-engine *
1. install ngrok *
1. obtain a reserved subdomain (from ngrok website)
1. start the pico-engine (leave CMD window open) *
1. start ngrok using the subdomain (leave CMD window open) *
1. register the rulesets in `krl` folder
1. install `io.picolabs.account_management` ruleset in Root pico
1. create a new owner pico named "Cargo Tracking" and record its login secret channel
1. install in Cargo Tracking two rulesets `com.wccargo.tracking` and `com.wccargo.support`
1. run DP report to generate orders `txt` files in `public\data` folder *
1. create `orders.txt` file in `public` folder from DIR of said folder *
1. in Testing tab for support ruleset, import the orders (url=<engine>/data/orders.txt)
1. install `io.picolabs.rewrite` ruleset in root pico
1. create a query shortcut for "/com.wccargo.tracking" and an ECI of Cargo Tracking

* are done on the Windows server

others are done using the pico-engine UI through the ngrok subdomain
unless otherwise indicated
