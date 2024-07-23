unit class HTMX;

##### Declare Constants #####

#| viz. https://www.w3schools.com/tags/default.asp
constant @all-tags = <a abbr address area article aside audio b base bdi bdo blockquote body br
    button canvas caption cite code col colgroup data datalist dd del details dfn dialog div
    dl dt em embed fieldset figcaption figure footer form h1 h2 h3 h4 h5 h6 head header hgroup
    hr html i iframe img input ins kbd label legend li link main map mark menu meta meter nav
    noscript object ol optgroup option output p param picture pre progress q rp rt ruby s samp
    script search section select small source span strong style sub summary sup svg table tbody
    td template textarea tfoot th thead time title tr track u ul var video wbr>;

#| of which "empty" / "singular" tags from https://www.tutsinsider.com/html/html-empty-elements/
constant @singular-tags = <area base br col embed hr img input link meta param source track wbr>;

##### HTMX Tag Export #####

my @regular-tags = (@all-tags.Set (-) @singular-tags.Set).keys;

# Export them so that `h1("text")` makes `<h1>text</h1>` and so on
# eg sub h1(Str $inner) {do-tag 'h1', $inner}
# inners are already Str

sub attrs(%h) {
    +%h ?? (' ' ~ %h.map({.key ~ '="' ~ .value ~ '"'}).join(' ') ) !! ''
}

sub do-regular-tag( $tag, *@inners, *%h ) {

    my $opener = '<'  ~ $tag ~ attrs(%h) ~ '>';
    my $closer = '</' ~ $tag ~ '>';

    given @inners {
        when * <= 1 {
            $opener ~ @inners.join ~ $closer
        }
        when * >= 2 {
            $opener ~ "\n  " ~ @inners.join("\n  ") ~ "\n" ~ $closer
        }
    }

}

sub do-singular-tag( $tag, *%h ) {

    '<' ~ $tag ~ attrs(%h) ~ ' />'

}

# put in all the tags programmatically
# viz. https://docs.raku.org/language/modules#Exporting_and_selective_importing

my package EXPORT::DEFAULT {
    for @regular-tags -> $tag {
        OUR::{'&' ~ $tag} := sub (*@inners, *%h) { do-regular-tag( "$tag", @inners, |%h ) }
    }

    for @singular-tags -> $tag {
        OUR::{'&' ~ $tag} := sub (*%h) { do-singular-tag( "$tag", |%h ) }
    }
}



=begin pod

=head1 NAME

HTMX - blah blah blah

=head1 SYNOPSIS

=begin code :lang<raku>

use HTMX;

=end code

=head1 DESCRIPTION

HTMX is ...

=head1 AUTHOR

librasteve <librasteve@furnival.net>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2024 Henley Cloud Consulting Ltd.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
