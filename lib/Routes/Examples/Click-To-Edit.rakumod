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

############################ Model ############################

my $base = 'click_to_edit/contact/0';

my $data = {
    firstName => "Joe",
    lastName  => "Blow",
    email     => "joe@blow.com",
};

my @keys  = <firstName lastName email>;  #in order

############################ View #############################

my @labels = @keys.map: &camel2label;
my @values = @keys.map: { "<.$_>" };
my @types  = @keys.map: { $_ ne 'email' ?? 'text' !! $_ };


sub sindex($data) {
    use HTML::Functional;

#        warn $data<@names>.raku; $*ERR.flush;

    given $data {

        div(:hx-target<this> :hx-swap<outerHTML>, [

            zip(@labels, $_{@keys}).flat.map: { p $^label, $^value }

            button :hx-get("$base/edit"), 'Click To Edit',
        ]);

    }
}

sub sedit($data) {
    use HTML::Functional;

    given $data {

        my @all = zip(@labels, @types, @keys, $_{@keys});

        form( :hx-put("$base"), :hx-target<this> :hx-swap<outerHTML>, [

            @all.map: -> ($label, $type, $name, $value) {
                div label $label, input :$type, :$name, :$value
            }

            button('Submit'),
            button(:hx-get("$base"), 'Cancel'),
        ]);

    }
}


######################### Controller ##########################

sub click_to_edit-routes() is export {
    route {
        get -> {
            content 'text/html', sindex($data);
        }

        get -> 'contact', Int $id, Str $action='index'  {

            given $action {
                when 'index' {
                    content 'text/html', sindex($data);
                }
                when 'edit' {
                    content 'text/html', sedit($data);
                }

            }

        }

        put -> 'contact', Int $id  {

            request-body -> %fields {
                $data{$_} = %fields{$_} for $data.keys;
            }

            content 'text/html', sindex($data);
        }
    }
}
