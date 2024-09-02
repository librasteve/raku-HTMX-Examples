use Cro::HTTP::Router;
use Cro::WebApp::Template;

my ($percentage, $complete);

sub progress_bar-routes() is export {

    route {
        template-location 'templates/progress_bar';

        get -> {
            template 'index.crotmp';
        }

        post -> 'start' {
            $percentage = 0;
            $complete = False;

            template 'in_progress.crotmp', {:$percentage, :$complete};
        }

        get -> 'job' {
            $complete = $percentage >= 100;

            template 'in_progress.crotmp', {:$percentage, :$complete};
        }

        get -> 'job', 'progress' {
            $percentage += floor(33 * rand);

            header 'HX-Trigger', 'done';
            template 'progress_bar.crotmp', { :$percentage };
        }
    }
}