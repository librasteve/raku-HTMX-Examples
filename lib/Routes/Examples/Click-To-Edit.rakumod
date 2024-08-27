use Cro::HTTP::Router;
use Cro::WebApp::Template;
use Cro::WebApp::Template::Repository;

####################### Some Utility Subroutines ########################

#| send Response from crotmp formatted text supplied as 'immediate' argument
sub immediate(Str $template-text, $inital-topic ) {
    content 'text/html', (parse-template($template-text)).render($inital-topic);
}


#| convert camel case fieldnames like 'firstName' to labels like 'First Name: '
sub camel2label(Str $camel) {
    $camel.match(/ (<lower>+) (<upper><lower>+)* /)>>.tc.trim~":";
}


#| convert name to crotmp variable form eg. 'firstName' => '<.firstName>'
sub crotmpvar(Str $name) {
    "<.$name>";
}


############################ Model ############################

my $base = 'click_to_edit/contact/0';

my $data = {
    firstName => "Joe",
    lastName  => "Blow",
    email     => "joe@blow.com",
};

my @names  = <firstName lastName email>;

############################ View #############################

my @labels = @names.map: &camel2label;
my @values = @names.map: &crotmpvar;
my @types  = @names.map: { $_ ne 'email' ?? 'text' !! $_ };

my @all = zip(@labels, @types, @names, @values);

my %tp;

{
    use HTML::Functional;

    %tp<default> :=
    div( :hx-target<this> :hx-swap<outerHTML>, [

        zip(@labels, @values).flat.map: {p $^label, $^value}

        button :hx-get("$base/edit"), 'Click To Edit',
    ]);

    %tp<edit> :=
    form( :hx-put("$base"), :hx-target<this> :hx-swap<outerHTML>, [

        @all.map: -> ($label, $type, $name, $value) {
            div label $label, input :$type, :$name, :$value
        }

        button('Submit'),
        button(:hx-get("$base"), 'Cancel'),
    ]);
}

######################### Controller ##########################

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
