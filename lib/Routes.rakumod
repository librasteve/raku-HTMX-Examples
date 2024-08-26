use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub routes() is export {
    route {
        template-location 'templates';

        get -> {
            template 'index.crotmp';
        }

        get -> *@path {
            static 'static', @path;
        }

        use Routes::Examples::Click-To-Edit;
        include click_to_edit => click_to_edit-routes;

        use Routes::Examples::Bulk-Update;
        include bulk_update => bulk_update-routes;

    }
}
