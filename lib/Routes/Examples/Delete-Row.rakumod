use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub delete_row-routes() is export {

    my $data = { contacts => [
        {
            name => "Joe Smith",
            email => "joe@smith.org",
            status => "Active",
        },
        {
            name => "Angie MacDowell",
            email => "angie@macdowell.org",
            status => "Active",
        },
        {
            name => "Fuqua Tarkenton",
            email => "fuqua@tarkenton.org",
            status => "Active",
        },
        {
            name => "Kim Yee",
            email => "kim@yee.org",
            status => "Inactive",
        },
    ]};

    { .<id> = $++ } for |$data<contacts>;

    sub delete-row($id) {
        #warn $data.raku; $*ERR.flush;

        $data<contacts> = $data<contacts>.grep(*.<id> != $id).Array;
    }

    route {
        template-location 'templates/delete_row';

        get -> {
            template 'index.crotmp', $data;
        }

        delete -> 'contact', Int $id {
            delete-row($id);
            content 'application/json', '';   #200 OK (no content)
        }
    }
}
