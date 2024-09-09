use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub keyboard_shortcuts-routes() is export {

    route {
        template-location 'templates/keyboard_shortcuts';

        get -> {
            template 'index.crotmp';
        }

        post -> 'doit' {
            content 'text/html', "Did it!";
        }
    }
}
