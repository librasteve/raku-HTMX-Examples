unit class HTMOO;

#`[
I found this lying around (in Cro?) and think it would be good to repurpose for the HTMX world so that we have examples of OO htmx pages

This has the superpower of defaults and overrrides
#]

class Meta {
    has $.name;
    has $.content;

    method render {
        '<meta name="' ~ $!name ~ '" content="' ~ $!content ~ '">' ~ "\n"
    }
}

class Title {
    has $.title;

    method render {
        '<title>' ~ $!title ~ '</title>' ~ "\n"
    }
}

class Script {
    has $.src;

    method render {
        '<script src="' ~ $!src ~ '"></script>' ~ "\n"
    }
}

class Link {
    has $.rel;
    has $.href;

    method render {
        '<link rel="' ~ $!rel ~ '" href="' ~ $!href ~ '">' ~ "\n"
    }
}

class Style {
    has $.css;

    method render {
        "$!css\n"
    }
}

class Head {
    has Meta   @.metas;
    has Title  $.title;
    has Script @.scripts;
    has Link   @.links;
    has Style  $.style;

    method render {
        { .render for @!metas   } ~ "\n" ~
        $!title.render            ~ "\n" ~
        { .render for @!scripts } ~ "\n" ~
        { .render for @!links   } ~ "\n" ~
        $!style.render            ~ "\n"
    }
}

class Body {
    has $.text;

    method render {
        "$!text\n"
    }
}

class Html {
    has Head $.head;
    has Body $.body;

    method render {
        $!head.render ~ "\n" ~
        $!body.render ~ "\n"
    }
}

class Page {
    has $.doctype = 'html';
    has Html $.html;

    method render {
        "<!doctype $!doctype>\n" ~
        $!html.render ~ "\n"
    }
}

# example ... refactor to .new iamerejh
my $page = Page.new:
    Html => Html.new:
        Head => Head.new:
            Meta => [
                Meta.new: m1,
                Meta.new: m2
            ],
            Title => Title.new:

