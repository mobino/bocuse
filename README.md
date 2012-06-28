bocuse
======

A front-end language to chef-solo.

Usage
=====

1. Create a structure

    ./config
      /nodes/namespace/nodename*
      ...
      /templates/templatename*
      ...

2. Run `bocuse namespace/nodename`

This will spit out a nice JSON configuration.

Templates can be included in node definitions using `include_template :templatename`

Development
===========

Run specs: `rspec`