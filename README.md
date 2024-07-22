**WORK IN PROGRESS**

Contributions welcome - by PR please if possible.

See [Issues](https://github.com/librasteve/raku-HTMX/issues/1) for active feature dicsussions.

TODOS
=====

#### Minimum Lovable Product (`MLP`)

- [x] Get a definitive list of HTML tags
- [x] Export them so that `h1("text")` makes `<h1>text</h1>` and so on
- [ ] Pass and format the HTMX attributes
- [ ] Bring in synopsis from design
- [ ] Do the ¶ term
- [ ] Make a parse script (& instructions how to watch a dir)
- [ ] Write some tests
- [ ] Write some docs in POD6
- [ ] Release with App::Mi6
- [ ] Publish as raku-htmx on the htmx Discord

#### Follow On

- [ ] CSS - try some alternatives, read some stuff, make a plan
- [ ] Cro - how to integrate HTMX Static pages with Cro backend
- [ ] Hummingbird - ditto for HB
- [ ] Attribute checking (need deeper list of attr names and set of types)

NAME
====

This module provides a programmatic style for HTML and HTMX ([htmx.org]) web content.

SYNOPSIS
========

```raku
use HTMX;
```

DESCRIPTION
===========

HTMX is ...

AUTHOR
======

librasteve <librasteve@furnival.net>

COPYRIGHT AND LICENSE
=====================

Copyright 2024 librasteve

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

