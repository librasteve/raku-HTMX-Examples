use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub click_to_load-routes() is export {

    sub gen-id { ('A'..'Z',0..9).flat.roll(10).join }

    sub gen-contact($i, $page) {
        {name=>"Agent Smith", email=>"void{$page*10+$i}@null.org", id=>gen-id}
    }
    
    sub gen-contacts($page=1) {
        sleep(0.4);       #<= delay to make spinner visible
        [.&gen-contact($page) for ^10]
    }

    route {
        template-location 'templates/click_to_load';

        get -> {
            template 'index.crotmp', {contacts=>gen-contacts, next=>2};
        }

        get -> 'contacts', :$page! {
            template 'partial.crotmp', {contacts=>gen-contacts($page), next=>($page+1)};
        }
    }
}