use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub infinite_scroll-routes() is export {

    sub gen-id($size) { ('A'..'Z',^10).flat.roll($size).join }

    sub gen-contact($i, $page, $size) {
        {name=>"Agent Smith", email=>"void{$page*$size+$i}@null.org", id=>gen-id($size), last=>False}
    }
    
    sub gen-contacts($page=0, $size=20) {
        sleep(0.4);       #<= delay to make spinner visible
        my @result = [.&gen-contact($page, $size) for ^$size];
        @result[*-1]<last> = True;
        @result;
    }

    route {
        template-location 'templates/infinite_scroll';

        get -> {
            template 'index.crotmp', {contacts=>gen-contacts, next=>2};
        }

        get -> 'contacts', :$page! {
            sleep 1;
            template 'partial.crotmp', {contacts=>gen-contacts($page), next=>($page+1)};
        }
    }
}