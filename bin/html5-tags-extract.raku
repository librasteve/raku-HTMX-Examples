#!/usr/bin/env/raku

# This script extracts HTML5 tag names from the table at
# https://www.w3schools.com/tags/default.asp

my @lines = "../resources/html5-tags-w3schools.csv".IO.lines;

@lines.shift;                                       # remove header row
@lines.shift;                                       # remove !-- -- 
@lines.shift;                                       # remove !DOCTYPE
@lines .= grep: {! /'Not supported in HTML5'/};     # remove deprecated
@lines .= map: *.split(",")[0];                     # take column 1
@lines .= map: *.subst('<', '');                    # \  rm angle brackets
@lines .= map: *.subst('>', '');                    # /
@lines .= grep: {! /'h1'/};                         # remove '<h1> to <h6>' row
for ^6 { @lines.append: 'h' ~ ++$ };                # put in h1..h6 rows

spurt "../resources/html5-tags-list.csv", @lines.sort.join: "\n";
