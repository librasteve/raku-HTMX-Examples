use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub dialogs_uikit-routes() is export {

    route {
        template-location 'templates/dialogs_uikit';

        get -> {
            template 'index.crotmp';
        }

        get -> 'modal' {
            template 'modal.crotmp';
        }
    }
}
