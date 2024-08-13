use Cro::HTTP::Router;
use Cro::HTTP::Server;

my $application = route {
    get -> 'greet', $name {
        content 'text/plain', "Hello, $name!";
    }
    get -> {
        static 'index.html';
    }
}

my Cro::Service $service = Cro::HTTP::Server.new:
    :host<localhost>, :port<10000>, :$application;

$service.start;

react whenever signal(SIGINT) { $service.stop; exit; }

#raku server.raku
#lynx localhost:10000/greet/librasteve