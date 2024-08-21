
#`[
Model page using OO
This has the superpowers of defaults and overrrides
Newline is inner to outer
#]

## FIXME these sub are [improved] dupes of HTMX.rakumod
## FIXME but had to drop the newlines to avoid spaces

sub attrs(%h) {
    +%h ?? (' ' ~ %h.map({.key ~ '="' ~ .value ~ '"'}).join(' ') ) !! ''
}

sub opener($tag, *%h) {
    '<' ~ $tag ~ attrs(%h) ~ '>'
}

sub closer($tag) {
    '</' ~ $tag ~ '>'
}

sub do-regular-tag( $tag, *@inners, *%h ) {
    given @inners {
        when * == 0 {
            opener($tag, |%h) ~ closer($tag)
        }
        when * == 1 {
            opener($tag, |%h) ~ @inners.first ~ closer($tag)
        }
        when * >= 2 {
            opener($tag, |%h) ~ @inners.join ~ closer($tag)
        }
    }
}

sub do-singular-tag( $tag, *%h ) {
    '<' ~ $tag ~ attrs(%h) ~ ' />'
}

subset Tag  of Str;
subset Attr of Str;

class Meta {
    has Tag  $.tag = 'meta';
    has Attr() %.attrs;   #coercion is friendly to attr values with spaces

    method render {
        do-singular-tag( $!tag, |%!attrs )
    }
}

class Title {
    has Tag  $.tag = 'title';
    has Str  $.inner;

    method render {
        do-regular-tag($!tag, [$!inner])
    }
}

class Script {
    has Tag  $.tag = 'script';
    has Str  $.src;

    method attrs {
        {src => $!src}
    }

    method render {
        do-regular-tag( $!tag, |$.attrs )
    }
}

class Link {
    has Tag  $.tag  = 'link';
    has Attr %.attrs;

    method render {
        do-singular-tag( $!tag, |%!attrs )
    }
}

class Style {
    has Tag  $.tag  = 'style';
    has Str  $.css;

    method render {
        do-regular-tag( $!tag, [$!css] )
    }
}

class Head {
    has Tag    $.tag = 'head';
    has Meta   @.metas;
    has Title  $.title is rw;
    has Script @.scripts;
    has Link   @.links;
    has Style  $.style is rw;

    method render {
        opener($!tag)                 ~ "\n" ~
        "{ (.render for  @!metas   ).join }" ~
        "{ (.render with $!title   )}"       ~
        "{ (.render for  @!scripts ).join }" ~
        "{ (.render for  @!links   ).join }" ~
        "{ (.render with $!style   )}"       ~
        closer($!tag)

    }
}

class Body {
    has Tag   $.tag = 'body';
    has Str() $.inner;

    method render {
        opener($!tag)   ~ "\n" ~
        $!inner         ~ "\n" ~
        closer($!tag)
    }
}

class Html {
    has Tag  $.tag   = 'html';
    has Attr() %.attrs = {:lang<en>};
    has Head $.head .= new;
    has Body $.body is rw;

    method render {
        opener($!tag, |%!attrs) ~ "\n" ~
        $!head.render           ~
        $!body.render           ~
        closer($!tag)
    }
}

class Page {
    has $.doctype = 'html';
    has Html $.html .= new;

    method render {
        "<!doctype $!doctype>\n" ~
        $!html.render
    }

    #some setter methods
    method meta(%attrs) {
        self.html.head.metas.append: Meta.new(:%attrs)
    }

    method title($inner) {
        self.html.head.title = Title.new(:$inner)
    }

    method script(:$src) {
        self.html.head.scripts.append: Script.new(:$src)
    }

    method link(%attrs) {
        self.html.head.links.append: Link.new(:%attrs)
    }

    method style($css) {
        self.html.head.style = Style.new(:$css)
    }

    method body($inner) {
        self.html.body = Body.new(:$inner)
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


