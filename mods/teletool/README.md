# Point Teleporter [teletool]
Version: 1.3

## Description
This mod adds a new tool: The point teleporter. It is a tool which allows for short-range teleportation.
To use it, leftclick with it on any pointed node, you will be teleported next to surface of the node you have clicked.
The point teleporter has a range of 20 node lengths, but you cannot dig or attack while holding it.
However, to teleport, the destination needs to have enough space, there must be at least 1×2×1 nodes of passable space.

Point teleporters comes in three varieties, which only differ in how often you can use them and whether and which energy source they use:
* Infinite point teleporter: You can use it without limits.
* Magic point teleporter: It uses 20 mana per teleportation.
* Electronic point teleporter: It has to be charged at a battery station first. A charged one grants you about 50 teleportations. This point teleporter can be crafted.

## Dependencies
All dependencies are optional. The infinite point teleporter is always available, the existance of the other point teleporters depends on
the installed mods.

* `technic`: For electronic point teleporter
* `mana`: For magic point teleporter
* `default` and `technic`: For crafting recipe for electronic point teleporter
* `intllib`: For simple translation of item names

Also supported (but not through a direct dependency) is the `doc_items` mod from the Documentation System modpack; help texts for all tools are provided.

## Configuration
You probably do not need to configure the mod, and the settings are mostly only provided for testing and using the default
configuration is recommended. But you can change it anyways, if you wish. Configuration is done via ordinary `minetest.conf` variables:

* `teletool_avoid_collisions`: Boolean. If `true`, it is not possible to teleport somewhere where you would collide with a node. Default: `true`.
* `teletool_adjust_head`: Boolean. If `true`, you will be teleported one node lower if you clicked on the lower side of a node. Otherwise, your “head” will be initially “stuck” in the node. Default: `true`.
* `teletool_cost_mana`: Number. Cost of mana for the magic point teleporter. Default: `20`.
