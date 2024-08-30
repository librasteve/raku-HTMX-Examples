use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub lazy_loading-routes() is export {

    route {
        template-location 'templates/lazy_loading';

        get -> {
            template 'index.crotmp';
        }

        get -> 'graph' {
            sleep 1;    # delay to showcase htmx-indicator
            template 'image.crotmp';
        }
    }
}
