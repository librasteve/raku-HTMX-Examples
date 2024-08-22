use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub routes() is export {
    route {

        #`[  #some handy examples
        get -> {
            content 'text/html', "<h1> cte1 </h1>";
        }

        get -> {
            static 'static', 'index.html'
        }

        get -> 'click_to_edit', 'contact', Int $id, 'edit'  {
            my @res = gather {
                for request.headers {
                    take "{ .name }: { .value }";
                }
            }
            content 'text/plain', "Response (id=$id):<br />" ~ @res.join("<br \>\n");
        }
        #]

        template-location 'templates';

        get -> {
            template 'index.crotmp';
        }

        get -> *@path {
            static 'static', @path;
        }

        use Routes::Examples::Click-To-Edit;
        include click_to_edit => click_to_edit-routes;

    }
}
