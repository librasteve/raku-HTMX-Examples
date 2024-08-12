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

my Cro::Service $hello = Cro::HTTP::Server.new:
    :host<localhost>, :port<10000>, :$application;

$hello.start;

react whenever signal(SIGINT) { $hello.stop; exit; }

#raku server.raku
#lynx localhost:10000/greet/librasteve