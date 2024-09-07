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

        use Routes::Examples::Click-To-Load;
        include click_to_load => click_to_load-routes;

        use Routes::Examples::Delete-Row;
        include delete_row => delete_row-routes;

        use Routes::Examples::Edit-Row;
        include edit_row => edit_row-routes;

        use Routes::Examples::Lazy-Loading;
        include lazy_loading => lazy_loading-routes;

        use Routes::Examples::Inline-Validation;
        include inline_validation => inline_validation-routes;

        use Routes::Examples::Infinite-Scroll;
        include infinite_scroll => infinite_scroll-routes;

        use Routes::Examples::Active-Search;
        include active_search => active_search-routes;

        use Routes::Examples::Progress-Bar;
        include progress_bar => progress_bar-routes;

        use Routes::Examples::Value-Select;
        include value_select => value_select-routes;

        use Routes::Examples::Animations;
        include animations => animations-routes;

        use Routes::Examples::File-Upload;
        include file_upload => file_upload-routes;

        use Routes::Examples::Dialogs-Browser;
        include dialogs_browser => dialogs_browser-routes;

        use Routes::Examples::Dialogs-UIKit;
        include dialogs_uikit => dialogs_uikit-routes;

        use Routes::Examples::Dialogs-Bootstrap;
        include dialogs_bootstrap => dialogs_bootstrap-routes;

        use Routes::Examples::Dialogs-Custom;
        include dialogs_custom => dialogs_custom-routes;

        use Routes::Examples::Dialogs-Pico;
        include dialogs_pico => dialogs_pico-routes;

        use Routes::Examples::Tabs-Hateoas;
        include tabs_hateoas => tabs_hateoas-routes;
    }
}
