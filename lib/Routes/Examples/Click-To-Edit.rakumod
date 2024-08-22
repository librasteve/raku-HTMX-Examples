use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub click_to_edit-routes() is export {

    my $data = {
        firstName => "Joe",
        lastName  => "Blow",
        email     => "joe@blow.com",
    };

    route {
        template-location 'templates/click_to_edit';

        get -> {
            template 'index.crotmp', $data;
        }

        get -> 'contact', Int $id  {
            template 'index.crotmp', $data;
        }

        put -> 'contact', Int $id  {

            request-body -> %fields {
                $data{$_} = %fields{$_} for $data.keys;
            }

            template 'index.crotmp', $data;
        }

        get -> 'contact', Int $id, 'edit'  {
            template 'edit.crotmp', $data;
        }
    }
}

