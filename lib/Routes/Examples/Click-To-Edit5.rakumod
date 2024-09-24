use Cro::HTTP::Router;

##################### Utility Subroutines ####################


#| hydrate & send Response as function arg
sub hydrate( &html, $data ) {
    content 'text/html', &html($data);
}

############################ Model ############################

my $base = 'click_to_edit/contact/0';

my $data = {
    firstName => "Joe",
    lastName  => "Blow",
    email     => "joe@blow.com",
};

class Key {
    has $.name;

    #| camelCase to Sentence Case
    method label { $!name.match(/ (<lower>+) (<upper><lower>+)* /)>>.tc.trim~":" }

    method type  { $!name eq 'email' ?? 'email' !! 'text' }

    method value { $data{$!name} }
}

my @names = <firstName lastName email>;  #in order
my @keys  = @names.map: -> $name { Key.new(:$name) };


############################ View ############################

my &index = -> $data {
    use HTML::Functional;
    #warn $data{@names}.raku; $*ERR.flush;

    div(:hx-target<this> :hx-swap<outerHTML>, [

        for @keys {
            p .label, .value
        }

        button :hx-get("$base/edit"), 'Click To Edit',
    ]);
}

my &edit = -> $data {
    use HTML::Functional;

    form( :hx-put("$base"), :hx-target<this> :hx-swap<outerHTML>, [

        for @keys {
            div label .label, input type=>.type, name=>.name, value=>.value
        }

        button('Submit'),
        button(:hx-get("$base"), 'Cancel'),
    ]);

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
                    hydrate &index, $data;
                }
                when 'edit' {
                    hydrate &edit, $data;
                }
            }
        }

        put -> 'contact', Int $id  {

            request-body -> %fields {
                $data{$_} = %fields{$_} for $data.keys;
            }

            hydrate &index, $data;
        }
    }
}
