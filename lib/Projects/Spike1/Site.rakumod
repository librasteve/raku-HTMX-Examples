use v6.d;

#https://www.perplexity.ai/search/please-show-me-an-example-of-a-itT4bd2vTo6I5fyfM3oiZg
#
#Rails ViewComponents on steroids
#Intended for low JS frameworks - e.g. HTMX
#
#Note that the [Style|Layout|Content] Tree may each be different

role Node {
	has Path $.path;
    has Name $.name;

    has $.parent;
    has @.children;

    method siblings {...}
    method add_child {...}
    method rm_child {...}

    #| to roll up CSS from Nodes
    method css {...}

    #| to roll up HTML from Nodes
    method html {...}

    #| to roll up Javascript from Nodes
    method script {...}
}

role Style does Node {
    has @.vars;   #some way to inject SCSS vars (downwards)
}

class RootStyle is Style {
    has $.parent = Nil;
}




role Layout does Node { ... }

role Render {
    has Renderer $.renderer;

    #|get rolled up and integrated dir
    method render {
        #assemble HTML as div tree
        #enqueue Scripts
        #run & mixin SCSS
    }
}

class Project {
    has Dir $.target;
    has Island @.islands;

    method build {...}
}

class Model is Red {...}

class Routes {
    use Cro::HTTP::Router;
    use Cro::WebApp::Template;

    sub routes() is export {
        route {
            template-location 'templates';

            get -> {
                template 'index.crotmp';
            }

            get -> 'js', *@path {
                static 'static/js', @path;
            }

            get -> *@path {

                            static 'static', @path;
            }

            use Routes::Examples;

            use Routes::Examples::Click-To-Edit5;
            include click_to_edit => click_to_edit-routes;

            use Routes::Examples::Bulk-Update;
            include bulk_update => bulk_update-routes;
        }
    }
}

role Island[$view-name] does Render {
    has Style   $.style;
    has Layout  $.layout;
    has Content $.content;
    has Model   $.model;
    has Routes  $.routes;
    has Views   @.views;   ??
}


subset Html of Str;
subset Css of Str;
subset Js of Str;

class Content {
    has Html $.html is required;
    has Css  $.css;
    has Js   $.js;
}

subset BodyCall of Callable;     #<== returns Content object (not sure how to specify that)

role HTML::Component::API {

    #| render should return a Content object which must have some HTML and may also
    #| add custom CSS and JS if needed which render will "append" to the final
    #| web page content that is emitted
    #|
    #| chains of render methods are permitted to eg permeate down a tree to child
    #| roles and classes and then to be aggregated back up
    #|
    #| optionally a body may be provided by the caller, typically (in the same way
    #| as a Cro Template "macro"), this allows for render to top and tail some content
    #| in a pattern that echoes the final HTML tree structure
    #|
    multi method render(-> Content) { ... }
multi method render(Content % -> Content) { ... }
multi method render(BodyCall & -> Content) { ... }
}

class HTML::Component does HTML::Component::API {
    ...    #your simple code example would go here
}


---

#use Cro::WebApp::Island;
#
#class Section is Island {
#
#
#
#}
#
#Section.new: style => RootStyle.new, layout => RootLayout.new
#    ==>
#    .render
#
#
#
#
#    ---
#
#    # Later
#    role PubSub {...}
#role Hook does PubSub {...}