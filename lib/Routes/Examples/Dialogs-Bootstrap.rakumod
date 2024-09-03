use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub dialogs_bootstrap-routes() is export {

    route {
        template-location 'templates/dialogs_bootstrap';

        get -> {
            warn 'yo'; $*ERR.flush;

            template 'index.crotmp';
        }

        get -> 'modal' {
            template 'modal.crotmp';
        }
    }
}
