use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub value_select-routes() is export {

    my $data = {
        audi => { models => ["A1", "A4", "A6"] },
        toyota => { models => ["Landcruiser", "Tacoma", "Yaris"] },
        bmw => { models => ["325i", "325ix", "X5"] },
    };

    route {
        template-location 'templates/value_select';

        get -> {
            template 'index.crotmp', { models => $data<audi><models> };
        }

        get -> 'models', :$make!  {
            template 'models.crotmp', { models => $data{$make}<models> };
        }
    }
}
