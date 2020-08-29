# wccargo

## steps taken

1. install node
1. install pico-engine
1. install ngrok
1. obtain a reserved subdomain
1. register the rulesets in `krl` folder
1. install `io.picolabs.account_management` ruleset in Root pico
1. create a new owner pico named "Cargo Tracking" and record its login secret channel
1. run DP report to generate orders `txt` files in `public` folder
1. create `orders.txt` file in `public` folder
1. in Testing tab for support ruleset, import the orders
1. register a shortcut (using `io.picolabs.rewrite` ruleset in root pico) for "/com.wccargo.tracking" and an ECI of Cargo Tracking pico

