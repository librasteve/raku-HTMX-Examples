unit class HTMX;




##### HTMX Tag Export #####

my Str @tags = "$*HOME/.rahx-config/html5-tags-list.csv".IO.lines;

# Export them so that `h1("text")` makes `<h1>text</h1>` and so on
# eg sub h1(Str $inner) {do-tag 'h1', $inner}

sub do-tag( $tag, $inner ) {
    '<' ~ $tag ~ '>' ~ $inner ~ '</' ~ $tag ~ '>'
}

# put in all the tags programmatically
# viz. https://docs.raku.org/language/modules#Exporting_and_selective_importing

my package EXPORT::DEFAULT {
    for @tags -> $tag {
        OUR::{'&' ~ $tag} := sub ($inner) { do-tag( "$tag", $inner ) }
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
