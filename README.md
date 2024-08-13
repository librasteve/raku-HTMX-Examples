**WORK IN PROGRESS**

Contributions welcome - by PR please if possible.

See [Issues](https://github.com/librasteve/raku-HTMX/issues/1) for active feature discussions.

NAME
====

This module provides a programmatic style for HTML and HTMX ([htmx.org]) web content.

For now it's missing the server side piece, likely will start with Cro.

SYNOPSIS
========

```raku
use HTMX;

my $head = head [
    meta( :charset<utf-8> ),
    meta( :name<viewport>, :content<width=device-width, initial-scale=1> ),
    meta( :name<description>, :content<raku does htmx> ),

    title( "Raku HTMX" ),

    script( src  => "https://unpkg.com/htmx.org@1.7.0", ),

    link(   rel  => "stylesheet",
            href => "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css",
    ),
    style(
        q:to/END/;
            .jumbotron {
              background-color: #e6ffe6;
              text-align: center;
            }
        END
    ),
];

my $body = body [
    div( :class<jumbotron>, [
        h1("Welcome to Dunder Mifflin!"),                          #use parens to stop <h1> slurping <p>
        p  "Dunder Mifflin Inc. (stock symbol {strong 'DMI'}) " ~
            q:to/END/;
            is a micro-cap regional paper and office
            supply distributor with an emphasis on servicing
            small-business clients.
            END
    ]),

    p :hx-get<https://v2.jokeapi.dev/joke/Any?format=txt&safe-mode>,
        "Click Me",
];

my $html = html :lang<en>, [
    $head,
    $body,
];

say "<!doctype html>$html";
```

DESCRIPTION
===========

HTMX is ...

TODOS
=====

#### Minimum Lovable Product (`MLP`)

- [x] Get a definitive list of HTML tags
- [x] Export them so that `h1("text")` makes `<h1>text</h1>` and so on
- [x] Pass and format the HTMX attributes
- [x] Bring in synopsis from design
- [ ] Make a parse script (& instructions how to watch a dir)
- [x] Write some tests
- [ ] Write some docs in POD6
- [ ] Release with App::Mi6
- [ ] Publish as raku-htmx on the htmx Discord

Typical deployment dir structure:
~/foo > tree
.
├── Dockerfile
├── META6.json
├── README.md
├── lib
│   └── Routes.rakumod
├── service.raku
└── static
    ├── css
    ├── images
    ├── index.html
    └── js


How to launch cro + HTMX:
- Install modules `zef install --/test cro HTMX`
- Use cro to make a stub service `cro stub http foo foo`
- `cd foo`
- Use HTMX / HTMOO to make your website and place it in `./static`
  -  
- Use rahx to htmx `rahx stub foo`
  - reads .rahx.yml for config data
  - make static index.html, place in foo/static and with static route
  - puts static js, css, etc in static/ with static route
  - make dynamic routes based on 


#### Follow On

- [ ] consider adding back end template to this module (like this https://github.com/Konfuzian/htmx-examples-with-flask/tree/main)
- [ ] CSS - try some alternatives, read some stuff, make a plan
- [ ] Cro - how to integrate HTMX Static pages with Cro backend
- [ ] Hummingbird - ditto for HB
- [ ] Attribute checking (need deeper list of attr names and set of types)

#### Rejected
- [ ] Do the ¶ term - NOPE this messes with editor code preview


AUTHOR
======

librasteve <librasteve@furnival.net>

COPYRIGHT AND LICENSE
=====================

Copyright 2024 librasteve

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

