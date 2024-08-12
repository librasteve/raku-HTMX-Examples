#!/usr/bin/env raku
use v6.d;

use Cro::HTTP::Router;
use Cro::HTTP::Server;
#use Cro::HTTP::Log;

my $dynamic-routes-supply = Supply.new;

sub create-router {
    my @dynamic-routes;
    $dynamic-routes-supply.tap(-> $route { @dynamic-routes.push($route) });

    route {
        get -> 'hello' {
            content 'text/plain', 'Hello, World!';
        }
        for @dynamic-routes -> $route {
            get -> $route.path {
                content 'text/plain', $route.response;
        }
    }
}
}

my $router = create-router();

my $server = Cro::HTTP::Server.new:
    :host<localhost>,
    :port(10000),
    :$router;

$server.start;

# Example of adding a dynamic route
$dynamic-routes-supply.emit({ path => 'dynamic', response => 'This is a dynamic route' });

react whenever signal(SIGINT) {
    $server.stop;
    exit;
}
