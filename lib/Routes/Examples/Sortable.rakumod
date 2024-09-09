use Cro::HTTP::Router;
use Cro::WebApp::Template;

sub sortable-routes() is export {

    route {
        template-location 'templates/sortable';

        get -> {
            template 'index.crotmp';
        }

        post -> 'items'  {
            # no op == 204
        }
    }
}

#@bp.route("/")
#def index():
#    return render_template("sortable/index.html.j2")
#
#
#@bp.route("/items", methods=("POST",))
#def items():
#    # store order of items here
#    return ("", 204)
#
