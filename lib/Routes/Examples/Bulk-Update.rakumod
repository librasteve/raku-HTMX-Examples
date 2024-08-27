use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub bulk_update-routes() is export {

    enum Status <Inactive Active>;

    my $data = { contacts => [
        {
            name => "Joe Smith",
            email => "joe@smith.org",
            status => Active,
        },
        {
            name => "Angie MacDowell",
            email => "angie@macdowell.org",
            status => Active,
        },
        {
            name => "Fuqua Tarkenton",
            email => "fuqua@tarkenton.org",
            status => Active,
        },
        {
            name => "Kim Yee",
            email => "kim@yee.org",
            status => Inactive,
        },
    ]};

    { .<id> = $++ } for |$data<contacts>;

    sub update(@ids, Status $status) {
        warn @ids.raku;
        for @ids -> \i {
            $data<contacts>[i]<status> = $status;
        }
    }

    route {
        template-location 'templates/bulk_update';

        get -> {
            template 'index.crotmp', $data;
        }

        put -> 'activate' {

            request-body -> %fields {
                update([|%fields<ids>], Active);
            }

            template 'index.crotmp', $data;
        }

        put -> 'deactivate' {

            request-body -> %fields {
                update([|%fields<ids>], Inactive);
            }

            template 'index.crotmp', $data;
        }
    }
}
