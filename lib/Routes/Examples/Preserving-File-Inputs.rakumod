use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub preserving_file_inputs-routes() is export {

    my $upload-dir = "$*HOME/Downloads/uploads/";

    unless $upload-dir.IO.e {
        $upload-dir.IO.mkdir or die "Failed to create upload directory: $!";
    }

    route {
        template-location 'templates/preserving_file_inputs';

        get -> {
            template 'index.crotmp';
        }

        post -> 'upload' {
            content 'text/html', "Uploaded!";
        }
    }
}
