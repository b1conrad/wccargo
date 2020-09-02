# Rulesets

## wccargo

### com.wccargo.html

This contains the "chrome" for the website in which a tracking page is embedded.
It was obtained by copying the source code of the placeholder cargo tracking page
and identifying the header (portion of HTML above the "coming soon" message) and
the footer (portion of HTML after that).

This ruleset is not installed in any pico, but is registered with the pico-eninge
and used as a module by the tracking and order rulesets.

### com.wccargo.tracking

This ruleset is the main application and is installed in a single owner pico,
named "Cargo Tracking".

Its purpose is to provide the HTML to be embedded in the wccargo.com website,
and to know about all of the orders that have updates (i.e. that are tracked).
This collection of order picos is maintained as the array of `children` by the
`io.picolabs.wrangler` ruleset.

There are three kinds of pages produced (by the `index` function):

1. The main tracking page, which contains a form prompting for the "Order#"
1. A page reporting "Order #{id} not found"
1. A page showing the "Tracking Services for order #{id}"

Usage is that the client goes to the first page, enters an order number, and presses the Enter key.

If the Cargo Tracking pico has an order pico named by the order number, the third page is displayed,
but if there is no order pico of that name, the second page is displayed.

### com.wccargo.order.ui

This ruleset is registered with the engine, but not installed in any pico.
It is used as a module by the order ruleset.

Its purpose is to produce the HTML for the third kind of page displayed by the tracking ruleeset.

### com.wccargo.order

This ruleset must be installed in each order pico.

### com.wccargo.support

The purpose of this ruleset was to provide operations that could be performed by 
customer service agents.
It is installed in the Cargo Tracking pico.

It can display an internal web page allowing an operator to create an order pico.

It has rules to allow importing a list of order numbers and creating an order pico for each one.

This ruleset is now deprecated, as customer service action was not wanted.

### com.wccargo.internal

The purpose of this ruleset is to react to changes in the filesystem,
and to create order picos as needed.
It is installed in the Cargo Tracking pico.

