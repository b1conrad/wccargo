# wccargo

## steps taken to build first prototype (for wccargo)

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

## plan for the mastunited production system

The first six steps msut be done on the production server.

Then use the `pico-engine` to register the four `com.mastunited.*` rulesets from the `krl` folder,
follow step 8 above, and create a new owner pico (name TBD) and record its login secret channel.

The rulesets `com.mastunited.tracking` and `com.mastunited.internal` are to be installed in the owner pico.

The DataPerfect report (from the `DP` folder) is to be imported into the production database
adjusted for panel number, etc.

The Javascript file `watch-updates.js` is to be placed in the `npm\node_modules` folder
and started in a CMD window with a command like this one:

```
node watch-updates.js <ECI>
```

where "&lt;ECI>" is replaced by the channel ID of a new channel 
(create this manually in the Channel tab of the pico-engine UI for the owner pico).

The last two steps (from the prototype setup above) should be adapted and done for
the production system, to create a short URL for the tracking page.

## Principles of operation

Customer service agents use the database to (among (many) other things) record
shipping updates for orders.

Sometime later (either immediately if the agent so desires, or otherwise
at the end of her shift) the DataPerfect report will run.

Text files will be created for each order, named by the order number,
containing all updates for that shipment.

Whenever one of the text files is changed,
the Javascript `watch-updates` program will send a `internal:file_changed` event
to the owner pico.

The owner pico, upon receiving the `internal:file_changed` event will
determine whehter or not there is already an order pico for that order number.

If there is no such pico, it will cause it to be created.
Otherwise it will send a `order:new_status_check` event to the order pico.

When a new order pico is created, it raises the `order:new_status_check` event internally.

Either way, the order pico reads the text file, 
and if the file is larger than what it already has seen
it will replace its cached updates with the content of the text file.

Sometime later, a client will come to the cargo tracking web page,
enter an order number of interest and press the Enter key.
This makes a request to the owner pico for its web page.

The owner pico computes the appropriate web page and returns it to 
the client's browser.
