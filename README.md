**WORK IN PROGRESS**

Contributions welcome - by PR please if possible.

See [Issues](https://github.com/librasteve/raku-HTMX-Examples/issues) for feature discussions.

HTMX EXAMPLES
=============

This repository provides a raku [Cro](https://cro.raku.org) implementation of the HTMX examples from [https://htmx.org/examples](https://htmx.org/examples).

CONTRIBUTING
============

Contributing to this repo is a great way to quickly get hands on HTMX and Raku Cro to get a feel for these technologies.

These raku implementation are inspired by the Python [equivalent](https://github.com/Konfuzian/htmx-examples-with-flask/tree/main) and contributors of new example items are encouraged to review the Python equivalent first as well as the raku click_to_edit implementation already provided. I have left the original index page as ```/templates/index.crotmpOLD``` as imported from the Flask examples since this carries a lot of styling for the various examples. Please raise an issue if you are contemplating chamging the main index as I would be happy to work with you on ways to carry the example-specific styling in the example code instead.

To contribute an example, please fork this repo, follow the Getting Started (see below) and the submit a PR with your proposed changes. Please delete your cro service from the repo before the PR so that new starters can build a clean service.


GETTING STARTED
===============

Install raku - eg. from [rakubrew](https://rakubrew.org), then:

#### Install Cro
- `zef install --/test cro`
- `zef install Cro::WebApp`

#### Install this repo
- `git clone https://github.com/librasteve/raku-HTMX-Examples.git`
- `cd raku-HTMX-Examples` && `zef install .`

#### Make a Cro server
- `cro stub http examples examples`  (OK all the defaults)
- `cp -R lib static templates ./examples`

#### Run and view it
- `cd examples` && `cro run`
- Open a browser and go to `http://localhost:20000`

You will note that cro has many other options as documented at [Cro](https://cro.raku.org) if you want to deploy to a production server.

TIPS & EXTRAS
=============

- In development set CRO_DEV=1 in the [environment](https://cro.services/docs/reference/cro-webapp-template#Template_auto-reload)
- You can use `warn $data.raku; $*ERR.flush;` to say to the cro log window
- The Preserving File Inputs example is not implemented (also not on htmx.org/examples)
- The Dialogs - Pico example is new, using JS from the htmx.org [sandbox](https://codesandbox.io/embed/4mrnhq?view=Editor) 

AUTHOR
======

librasteve <librasteve@furnival.net>

COPYRIGHT AND LICENSE
=====================

Copyright 2024 Contributors

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
