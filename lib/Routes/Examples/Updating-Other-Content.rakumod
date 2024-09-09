use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub updating_other_content-routes() is export {

    my $data = { contacts => [
        {
            name => "Joe Smith",
            email => "joe@smith.org",
        },
        {
            name => "Angie MacDowell",
            email => "angie@macdowell.org",
        },
    ]};

    route {
        template-location 'templates/updating_other_content';

        get -> {
            template 'index.crotmp', $data;
        }

        post -> 'contacts1' {

            request-body -> %fields {
                $data<contacts>.push:
                {
                    name => %fields<name>,
                    email => %fields<email>,
                };
            }

            template 'partial_1.crotmp', $data;
        }

        post -> 'contacts2' {
            my $contact;

            request-body -> %fields {
                $contact = {
                    name => %fields<name>,
                    email => %fields<email>,
                };
            }

            template 'partial_2.crotmp', $contact;
        }

        post -> 'contacts3' {

            request-body -> %fields {
                $data<contacts>.push:
                    {
                        name => %fields<name>,
                        email => %fields<email>,
                    };
            }

            header 'HX-Trigger', 'newContact';
        }

        get -> 'contacts3', 'table' {
            template 'partial_table.crotmp', $data;
        }

        post -> 'contacts4' {

            request-body -> %fields {
                $data<contacts>.push:
                    {
                        name => %fields<name>,
                        email => %fields<email>,
                    };
            }

            template 'partial_4.crotmp';
        }

        get -> 'contacts4', 'table' {
            template 'partial_table.crotmp', $data;
        }

    }
}
