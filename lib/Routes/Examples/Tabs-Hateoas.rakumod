use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub tabs_hateoas-routes() is export {

    route {
        template-location 'templates/tabs_hateoas';

        get -> {
            template 'index.crotmp';
        }

        get -> $target where /^ tab\d $/ {
            template "$target.crotmp";
        }
    }
}
