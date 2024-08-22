**WORK IN PROGRESS**

Contributions welcome - by PR please if possible.

See [Issues](https://github.com/librasteve/raku-HTMX-Examples/issues) for feature discussions.

HTMX EXAMPLES
=============

This repository provides a raku [Cro](https://cro.raku.org) implementation of the HTMX examples from [https://htmx.org/examples](https://htmx.org/examples).

CONTRIBUTING
============

Contributing to this repo is a great way to quickly get hands on HTMX and Raku Cro to get a feel for these technologies.

These raku implementation are inspired by the Python [equivalent](https://github.com/Konfuzian/htmx-examples-with-flask/tree/main) and contributors of new example items are encouraged to review the Python equivalent first as well as the raku click_to_edit implementation already provided.

To contribute an example, please fork this repo, follow the Getting Started (see below) and the submit a PR with your proposed changes. Please delete your cro service from the repo before the PR so that new starters can build a clean service.


GETTING STARTED
===============

Install raku - eg. from [rakubrew](https://rakubrew.org), then:

- `zef install --/test cro`
- `zef install Cro::WebApp`
- `git clone https://github.com/librasteve/raku-HTMX-Examples.git`
- `cd raku-HTMX-Examples`
- `cro stub http examples examples`  (OK all the defaults)
- `cp -R lib static templates ./examples`
- `cd examples`
- `cro run`
- Open a browser and go to `http://localhost:20000`
- Click `1 Click to Edit`

You will note that cro has many other options as documented at [Cro](https://cro.raku.org) if you want to deploy to a production server.


AUTHOR
======

librasteve <librasteve@furnival.net>

COPYRIGHT AND LICENSE
=====================

Copyright 2024 Contributors

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

