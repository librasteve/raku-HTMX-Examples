
#`[
Model page using OO
This has the superpowers of defaults and overrrides
Newline is inner to outer
#]

use HTML::Functional;

enum TagType <Singular Regular>;
subset Attr of Str;

role Tag[Str $name, TagType $tag-type] {
    has Str    $.name = $name;
    has Attr() %.attrs;   #coercion is friendly to attr values with spaces
    has        $.inner;

    multi method render {
        samewith $tag-type
    }
    multi method render(Singular) {
        do-singular-tag( $!name, |%!attrs )
    }
    multi method render(Regular) {
        do-regular-tag( $!name, [$!inner // ''], |%!attrs )
    }
}

role Meta does Tag['meta', Singular] { }

role Title does Tag['title', Regular] { }

role Script does Tag['script', Regular] {
    has Str $.src;

    method attrs {
        {src => $!src}
    }
}

role Link does Tag['link', Singular] { }

role Style does Tag['style', Regular] { }

role Head does Tag['head', Regular] {
    has Meta   @.metas;
    has Title  $.title is rw;
    has Script @.scripts;
    has Link   @.links;
    has Style  $.style is rw;

    #some basic defaults
    method defaults {
        self.metas.append: Meta.new: attrs => {:charset<utf-8>};
        self.metas.append: Meta.new: attrs => {:name<viewport>, :content<width=device-width, initial-scale=1>};
    }

    multi method render {
        opener($.name)                 ~ "\n" ~
        "{ (.render for  @!metas   ).join }" ~
        "{ (.render with $!title   )}"       ~
        "{ (.render for  @!scripts ).join }" ~
        "{ (.render for  @!links   ).join }" ~
        "{ (.render with $!style   )}"       ~
        closer($.name)
    }
}

role Body does Tag['body', Regular] { }

role Html does Tag['html', Regular] {
    has Head $.head .= new;
    has Body $.body is rw;

    method defaults {
        self.head.defaults;
        %.attrs.push: :lang<en>;
    }

    multi method render {
        opener($.name, |%.attrs) ~ "\n" ~
        $!head.render           ~
        $!body.render           ~
        closer($.name)
    }
}

role Page {
    has $.doctype = 'html';
    has Html $.html .= new;

    has $.title;
    has $.description;

    method defaults {
        self.html.defaults;
        self.html.head.title = Title.new(inner => $!title);
        self.meta: {:name<description>, :content($!description)};
    }

    multi method render {
        "<!doctype $!doctype>\n" ~
        $!html.render
    }

    #some setter methods
    method meta(%attrs) {
        self.html.head.metas.append: Meta.new(:%attrs)
    }

    method title($inner) {
        self.html.head.title = Title.new(inner => $!title)
    }

    method script(:$src) {
        self.html.head.scripts.append: Script.new(:$src)
    }

    method link(%attrs) {
        self.html.head.links.append: Link.new(:%attrs)
    }

    method style($inner) {
        self.html.head.style = Style.new(:$inner)
    }

    method body($inner) {
        self.html.body = Body.new(:$inner)
    }
}

role Container {

}

role Layout {

}

role Template {

}

role Component {

}

role Site {

}

role Nav {

}

#`[
my $static = './static/index.html';
my %assets = ( js => './static/js', css => './static/js', images => './static/images' );
my $routes = './lib/Routes.rakumod';

spurt $page.render-static $static;
spurt $page.render-assets %assets;
spurt $page.render-routes $routes;
#]


