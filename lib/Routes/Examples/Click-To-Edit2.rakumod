use Cro::HTTP::Router;
use Cro::WebApp::Template;
use Cro::WebApp::Template::Repository;

sub immediate(Str $template-text, $inital-topic ) {
    content 'text/html', (parse-template($template-text)).render($inital-topic);
}

my %tp;

%tp<default> = q:to/END/;
<div hx-target="this" hx-swap="outerHTML">
    <div><label>First Name</label>: <.firstName></div>
    <div><label>Last Name</label>: <.lastName></div>
    <div><label>Email</label>: <.email></div>
    <button hx-get="/click_to_edit/contact/0/edit" class="btn btn-primary">
        Click To Edit
    </button>
</div>
END

%tp<edit> = q:to/END/;
<form hx-put="/click_to_edit/contact/0" hx-target="this" hx-swap="outerHTML">
    <div>
        <label>First Name</label>
        <input type="text" name="firstName" value="<.firstName>">
    </div>
    <div class="form-group">
        <label>Last Name</label>
        <input type="text" name="lastName" value="<.lastName>">
    </div>
    <div class="form-group">
        <label>Email Address</label>
        <input type="email" name="email" value="<.email>">
    </div>
    <button class="btn">Submit</button>
    <button class="btn" hx-get="/click_to_edit/contact/0">Cancel</button>
</form>
END


sub click_to_edit-routes() is export {

    my $data = {
        firstName => "Joe",
        lastName  => "Blow",
        email     => "joe@blow.com",
    };

    route {
        get -> {
            immediate %tp<default>, $data;
        }

        get -> 'contact', Int $id  {
            immediate %tp<default>, $data;
        }

        put -> 'contact', Int $id  {

            request-body -> %fields {
                $data{$_} = %fields{$_} for $data.keys;
            }

            immediate %tp<default>, $data;
        }

        get -> 'contact', Int $id, 'edit'  {
            immediate %tp<edit>, $data;
        }
    }
}

