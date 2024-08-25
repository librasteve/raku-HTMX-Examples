use Cro::HTTP::Router;
use Cro::WebApp::Template;
use Cro::WebApp::Template::Repository;

sub immediate(Str $template-text, $inital-topic ) {
    content 'text/html', (parse-template($template-text)).render($inital-topic);
}

my $base = 'click_to_edit/contact/0';

my $data = {
    firstName => "Joe",
    lastName  => "Blow",
    email     => "joe@blow.com",
};

#use HTMX (aka HTML::Functional) or HTML::OO?

my %tp;

{
    use HTML::Functional;

    %tp<default> =

    div(:hx-target<this>, :hx-swap<outerHTML>, [
        (
        div label 'First Name: ', '<.firstName>',
        div label 'Last Name: ', '<.lastName>',
        div label 'Email: ', '<.email>',
        ),
        button :hx-get("$base/edit"), :class<btn btn-primary>, 'Click To Edit',
    ]);

    %tp<edit> =

    form :hx-put("$base"), :hx-target<this>, :hx-swap<outerHTML>,
        div( label 'First Name: ',
            input :type<text>, :name<firstName>, :value('<.firstName>'), ),
        div( label 'Last Name: ',
            input :type<text>, :name<lastName>, :value('<.lastName>'),   ),
        div( label 'Email: ',
            input :type<email>,:name<email>, :value('<.email>'),  ),
        button :class<btn>,
            'Submit',
        button :class<btn>, :hx-get("$base"),
            'Cancel',
    ;
}


sub click_to_edit-routes() is export {
    route {
        get -> {
            immediate %tp<default>, $data;
        }

        get -> 'contact', Int $id, Str $action='default'  {
            immediate %tp{$action}, $data;
        }

        put -> 'contact', Int $id  {

            request-body -> %fields {
                $data{$_} = %fields{$_} for $data.keys;
            }

            immediate %tp<default>, $data;
        }
    }
}

