
#`[
Model page using OO
This has the superpowers of defaults and overrrides
Newline is inner to outer
#]

use HTML::Functional;

subset Tag  of Str;
subset Attr of Str;

role Meta {
    has Tag  $.tag = 'meta';
    has Attr() %.attrs;   #coercion is friendly to attr values with spaces

    method render {
        do-singular-tag( $!tag, |%!attrs )
    }
}

role Title {
    has Tag  $.tag = 'title';
    has Str  $.inner;

    method render {
        do-regular-tag($!tag, [$!inner])
    }
}

role Script {
    has Tag  $.tag = 'script';
    has Str  $.src;

    method attrs {
        {src => $!src}
    }

    method render {
        do-regular-tag( $!tag, |$.attrs )
    }
}

role Link {
    has Tag  $.tag  = 'link';
    has Attr %.attrs;

    method render {
        do-singular-tag( $!tag, |%!attrs )
    }
}

role Style {
    has Tag  $.tag  = 'style';
    has Str  $.css;

    method render {
        do-regular-tag( $!tag, [$!css] )
    }
}

role Head {
    has Tag    $.tag = 'head';
    has Meta   @.metas;
    has Title  $.title is rw;
    has Script @.scripts;
    has Link   @.links;
    has Style  $.style is rw;

    #some basic defaults
    submethod TWEAK {
        self.metas.append: Meta.new: attrs => {:charset<utf-8>};
        self.metas.append: Meta.new: attrs => {:name<viewport>, :content<width=device-width, initial-scale=1>};
    }

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

role Body {
    has Tag   $.tag = 'body';
    has Str() $.inner;

    method render {
        opener($!tag)   ~ "\n" ~
        $!inner         ~ "\n" ~
        closer($!tag)
    }
}

role Html {
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

role Page {
    has $.doctype = 'html';
    has Html $.html .= new;

    has $.description;
    has $.title;

    method defaults {
        self.meta: {:name<description>, :content($!description)};
        self.Page::title: $!title;   #ie call title method on parent role
    }

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


