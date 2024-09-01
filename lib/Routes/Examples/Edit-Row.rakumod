use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub edit_row-routes() is export {

    my $data = { contacts => [
        {
            name => "Joe Smith",
            email => "joe@smith.org",
        },
        {
            name => "Angie MacDowell",
            email => "angie@macdowell.org",
        },
        {
            name => "Fuqua Tarkenton",
            email => "fuqua@tarkenton.org",
        },
        {
            name => "Kim Yee",
            email => "kim@yee.org",
        },
    ]};

    { .<id> = $++ } for |$data<contacts>;

    route {
        template-location 'templates/edit_row';

        get -> {
            template 'index.crotmp', $data;
        }

        get -> 'contact', Int $id  {
            template 'partial.crotmp', $data<contacts>[$id];
        }

        put -> 'contact', Int $id  {

            request-body -> %fields {
#                warn %fields.raku; $*ERR.flush;
                $data<contacts>[$id]{$_} = %fields{$_} for %fields.keys;
            }

            template 'partial.crotmp', $data<contacts>[$id];
        }

        get -> 'contact', Int $id, 'edit'  {
            warn $data.raku; $*ERR.flush;
            template 'edit.crotmp', $data<contacts>[$id];
        }
    }
}

