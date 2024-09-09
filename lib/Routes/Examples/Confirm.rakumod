use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub confirm-routes() is export {

    route {
        template-location 'templates/confirm';

        get -> {
            template 'index.crotmp';
        }
    }
}