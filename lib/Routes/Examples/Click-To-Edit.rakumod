use Cro::HTTP::Router;

##################### Utility Subroutines ####################

#| hydrate & send Response as function arg
sub hydrate( &html, $data ) {
    content 'text/html', &html($data);
}

#| convert camel case fieldnames like 'firstName' to labels like 'First Name: '
sub camel2label(Str $camel) {
    $camel.match(/ (<lower>+) (<upper><lower>+)* /)>>.tc.trim~":";
}

############################ Model ############################

my $base = 'click_to_edit/contact/0';

my $data = {
    :firstName("Joe"),
    :lastName("Blow"),
    :email("joe@blow.com"),
};

my @keys  = <firstName lastName email>;  #in order
my @labels = @keys.map: &camel2label;
my @types  = @keys.map: { $_ ne 'email' ?? 'text' !! $_ };

############################ View ############################

my &index = -> $data {
    use HTML::Functional;
    #warn $data{@names}.raku; $*ERR.flush;

    given $data {
        div(:hx-target<this> :hx-swap<outerHTML>, [

            zip(@labels, $_{@keys}).flat.map: { p $^label, $^value }

            button :hx-get("$base/edit"), 'Click To Edit',
        ]);
    }
}

my &edit = -> $data {
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
            hydrate &index, $data;
        }

        get -> 'contact', Int $id, Str $action='index'  {
            given $action {
                when 'index' {
                    content 'text/html', &index($data);
                }
                when 'edit' {
                    content 'text/html', &edit($data);
                }
            }
        }

        put -> 'contact', Int $id  {
            request-body -> %fields {
                $data{$_} = %fields{$_} for $data.keys;
            }

            content 'text/html', &index($data);
        }
    }
}
