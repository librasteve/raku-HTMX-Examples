use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub file_upload-routes() is export {

    my $upload-dir = "$*HOME/Downloads/uploads/";

    unless $upload-dir.IO.e {
        $upload-dir.IO.mkdir or die "Failed to create upload directory: $!";
    }

    route {
        template-location 'templates/file_upload';

        get -> {
            template 'index.crotmp';
        }

        post -> 'upload' {
            request-body -> (:$file, *%rest) {
                my $file-name = $file.filename;
                my $file-content = $file.body-blob;

                spurt "$upload-dir/$file-name", $file-content;
            }
        }
    }
}
