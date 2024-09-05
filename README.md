**WORK IN PROGRESS**

This branch is for the OO style
See /bin/party-spike

HMTL::OO DESIGN
===============

site
    page[home]
        header
            nav
        content
            grid (rows, cols, fr s) | flexbox (direction, width)
                image | text | heading
        footer

nav
    home | about | services | projects | contact


aspects
    site   == nav tree
    layout == container tree
    style  == css classes

source
    md
    htmx::function
    htmoo::parts

building a website...

historically:

a site is built as a set of html pages, connected a menu, with css to style elements and javascript to handle events

this represents a separation of concerns: roughly speaking html as model, css as view and javascript as controller

the downside is that this "hcj" construction divides the aspects into 3 monoliths that must be managed in parallel

recently:

a site is built as a single page application with frameworks such as react that compose elements and ship as javascript

the elements are hooked into event driven framework which propagates events and updates up and down

the downside is that this react construction, while localizing mvc concerns, emphasizes dynamimism over content

and, alternatively:

a site is built in a functional way with elm



TODOS
=====

#### Minimum Lovable Product (`MLP`)

- [x] Get a definitive list of HTML tags
- [x] Export them so that `h1("text")` makes `<h1>text</h1>` and so on
- [x] Pass and format the HTMX attributes
- [x] Bring in synopsis from design
- [ ] Make a parse script to get routes (likely will want a grammar)
  - ```<p hx-get="https://v2.jokeapi.dev/joke/Any?format=txt&safe-mode">Click Me</p>```
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

https://cro.services/docs/reference/cro-http-router

my $app = route {
get -> 'test' {
content 'text/html', q:to/HTML/;
<h1>Did you know...</h1>
<p>
Aside from fingerprints, everyone has a unique tongue print
too. Lick to login could really be a thing.
</p>
HTML
}
}


How to launch cro + HTMX:
- Install modules `zef install --/test cro HTMX`
- Use cro to make a stub service `cro stub http foo foo`
- `cd foo`
- Use HTMX / HTMOO to make your website and place it in `./static`
  - add method chains to HTMOO
  - add image tag to HTMOO
  - add role Party (a Part is a div)
  - add Container(s) - ie flexbox and grid
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

