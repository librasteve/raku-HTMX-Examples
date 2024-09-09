use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub sortable-routes() is export {

    route {
        template-location 'templates/sortable';

        get -> {
            template 'index.crotmp';
        }

        post -> 'items'  {
            request-body -> %fields {
                warn %fields<item>.raku; $*ERR.flush;
            }
            # no op == 204
        }
    }
}
