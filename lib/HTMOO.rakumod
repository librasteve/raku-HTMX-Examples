
#`[
Model page using OO
This has the superpowers of defaults and overrrides
Newline is inner to outer
#]

role Meta {
    has Pair $.pair = :charset<utf-8>;

    method render {
        '<meta name="' ~ $!pair.key ~ '" content="' ~ $!pair.value ~ '">' ~ "\n"
    }
}

role Title {
    has Str $.text = '';

    method render {
        '<title>' ~ $!text ~ '</title>' ~ "\n"
    }
}

role Script {
    has Str $.src = '';

    method render {
        '<script src="' ~ $!src ~ '"></script>' ~ "\n"
    }
}

role Link {
    has Str $.rel = '';
    has Str $.href = '';

    method render {
        '<link rel="' ~ $!rel ~ '" href="' ~ $!href ~ '">' ~ "\n"
    }
}

role Style {
    has Str $.css = 'p {color: blue;}';

    method render {
        "<style>\n" ~
        "$!css\n" ~
        "</style>\n"
    }
}

role Head {
    has Meta   @.metas   = [Meta.new];
    has Title  $.title   =  Title.new;
    has Script @.scripts = [Script.new];
    has Link   @.links   = [Link.new];
    has Style  $.style   =  Style.new;

    method render {
        "<head>\n"                         ~
        "{ (.render for @!metas  ).join }" ~
        $!title.render                     ~
        "{ (.render for @!scripts).join }" ~
        "{ (.render for @!links  ).join }" ~
        $!style.render                     ~
        "</head>\n"

    }
}

role Body {
    has Str $.text = "<p>Hello World!</p>";

    method render {
        "<body>\n" ~
        "$!text\n" ~
        "</body>\n"
    }
}

role Html {
    has Head $.head .= new;
    has Body $.body .= new;

    method render {
        $!head.render ~
        $!body.render
    }
}

role Page {
    has $.doctype = 'html';
    has Html $.html .= new;

    method render {
        "<!doctype $!doctype>\n" ~
        "<html>\n"               ~
        $!html.render            ~
        "</html>"
    }
}


#`[
my $static = './static/index.html';
my %assets = ( js => './static/js', css => './static/js', images => './static/images' );
my $routes = './lib/Routes.rakumod';

spurt $page.render-static $static;
spurt $page.render-assets %assets;
spurt $page.render-routes $routes;
#]


