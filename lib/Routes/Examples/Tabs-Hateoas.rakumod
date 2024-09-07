use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub tabs_hateoas-routes() is export {

    route {
        template-location 'templates/tabs_hateoas';

        get -> {
            template 'index.crotmp';
        }

        get -> 'tab1' {
            template 'tab1.crotmp';
        }

        get -> 'tab2' {
            template 'tab2.crotmp';
        }

        get -> 'tab3' {
            template 'tab3.crotmp';
        }
    }
}
