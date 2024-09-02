use Cro::HTTP::Router;
use Cro::WebApp::Template;

use JSON::Fast;

sub animations-routes() is export {
    route {
        template-location 'templates/animations';

        get -> 'styles' {
            template 'styles.crotmp';
        }

        my @choices = <red blue green orange>;
        my $i = 0;

        get -> {
#            warn 'ho'; $*ERR.flush;
            template 'index.crotmp', { color => @choices[$i] };
        }

        get -> 'colors' {
            $i = ($i + 1) % +@choices;
            template 'color_swap.crotmp', { color => @choices[$i] };
        }

        delete -> 'fade_out_demo' {
            content 'application/json', '';   #200 OK (no content)
        }

        post -> 'fade_in_demo' {
            template 'fade_in_on_addition.crotmp';
        }

        post -> 'name' {
            sleep 0.5;
            content 'application/json', 'Submitted!';
        }

        get -> 'initial-content' {
            template 'view_transition_initial.crotmp';
        }

        get -> 'new-content' {
            template 'view_transition_new.crotmp';
        }
    }
}
