use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub dialogs_browser-routes() is export {

    route {
        template-location 'templates/dialogs_browser';

        get -> {
            template 'index.crotmp';
        }

        post -> 'submit', :%headers is header {
            content 'text/html',
                "User entered <i>{%headers<HX-Prompt>}</i>";
        }
    }
}
