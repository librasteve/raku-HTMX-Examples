use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub dialogs_custom-routes() is export {

    route {
        template-location 'templates/dialogs_custom';

        get -> {
            template 'index.crotmp';
        }

        get -> 'styles' {
            template 'styles.crotmp';
        }

        get -> 'modal' {
            template 'modal.crotmp';
        }
    }
}