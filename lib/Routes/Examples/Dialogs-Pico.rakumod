use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub dialogs_pico-routes() is export {

    route {
        template-location 'templates/dialogs_pico';

        get -> {
            template 'index.crotmp';
        }

        get -> 'modal' {
            template 'modal.crotmp';
        }
    }
}