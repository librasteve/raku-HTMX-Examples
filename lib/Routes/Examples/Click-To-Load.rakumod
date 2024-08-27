use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub click_to_load-routes() is export {
    my $size = 10;

    sub gen-id { ('A'..'Z',0..9).flat.roll($size).join }

    sub gen-contact($i, $page) {
        {name=>"Agent Smith", email=>"void{$page*$size+$i}@null.org", id=>gen-id}
    }
    
    sub gen-contacts($page=1) { [.&gen-contact($page) for ^$size] }

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
