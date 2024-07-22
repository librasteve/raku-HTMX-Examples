unit class HTMX;

constant term:<¶> = $?NL;

has $.head;
has $.body is rw;
has $.foot;

method TWEAK {

    $!head //= q:to/ENDHEAD/;
        <!doctype html>
            <html lang="en">
            <head>
            <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <meta name="description" content="blah, blah...">
                <title>Raku HTMX</title>
                <link rel="canonical" href="https://mysiteurl">
                <link rel="stylesheet" href="/css/site.css">
                <script src="/js/htmx.js"></script>
                <script src="/js/class-tools.js"></script>
                <script src="/js/preload.js"></script>
                <script src="/js/_hyperscript.js"></script>
            </head>
            <body>
    ENDHEAD

    $!foot //= q:to/ENDFOOT/;
                <script async defer src="https://buttons.github.io/buttons.js"></script>
            </body>
            </html>
    ENDFOOT

}

method render {
    $!head ~ $!body ~ $!foot
}


##### HTMX Tag Export #####

my Str @tags = "$*HOME/.rahx-config/html5-tags-list.csv".IO.lines;

# Export them so that `h1("text")` makes `<h1>text</h1>` and so on
# eg sub h1(Str $inner) {do-tag 'h1', $inner}

sub do-tag( $tag, $inner, *%h ) {

    my Str $attrs = (+%h ?? ' ' !! '') ~ %h.map({ .key ~ '="' ~ .value ~ '"'  }).join(' ');

    '<' ~ $tag ~ $attrs ~ '>' ~ $inner ~ '</' ~ $tag ~ '>'
}

# put in all the tags programmatically
# viz. https://docs.raku.org/language/modules#Exporting_and_selective_importing

my package EXPORT::DEFAULT {
    for @tags -> $tag {
        OUR::{'&' ~ $tag} := sub ($inner, *%h) { do-tag( "$tag", $inner, |%h ) }
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
