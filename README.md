bocuse
======

A front-end language to chef-solo.

Usage
=====

1. Create a structure

    ./config
      /nodes/nodename*
      /nodes/namespace/nodename*
      ...
      /templates/templatename*
      /templates/namespace/templatename*
      ...

2. Run `bocuse pattern`

This will spit out configurations of all nodes matching the pattern.
(Note that all files in ./config/nodes/... will be read)

Templates can be included in node definitions using `include_template :templatename` or `include_template 'templatename'`.

Development
===========

Run specs: `rspec`