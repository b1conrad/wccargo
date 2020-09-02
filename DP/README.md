# DataPerfect report

This report is intended to be used after an update has been added to an order.

## immediate notification of an update

The operator may select this report 
(Shift-F7, select the report, F7 to returne to the panel)
and then press Alt-F7 to run the report for a single order.

This will create a file named by the Order# with a `.txt` file extenstion
(e.x. 123456.txt) and containing all of the updates for the order.

## periodic notification of updates

When a customer service agent ends their shift, this report will be
run (by the `autoexec` file of the vDOS instance) for the entire panel
of orders.

It will cause a file to be created for _each_ of the orders, named by the Order#
with a `.txt` extension and containing all of the updates for that order.
Many (thousands) of files will be created (or over-written if they already exist).
