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
        for ^$data<contacts> -> \i {
            { $data<contacts> .= splice(i, 1) } if $data<contacts>[i]<id> == $id;
        }
    }

    route {
        template-location 'templates/delete_row';

        get -> {
            template 'index.crotmp', $data;
        }

        delete -> 'contact', Int $id {
            warn $id.raku;
            delete-row($id);

            template 'index.crotmp', $data;
        }
    }
}
