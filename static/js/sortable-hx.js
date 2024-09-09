// in the example the sortable initialization runs on htmx.onLoad() like this: htmx.onLoad(function (content) {
// but load doesn't get triggered here (because htmx is already loaded in the index page), so instead we initialize it directly:
var sortables = content.querySelectorAll(".sortable");
for (var i = 0; i < sortables.length; i++) {
    var sortable = sortables[i];
    new Sortable(sortable, {
        animation: 150,
        ghostClass: 'blue-background-class'
    });
};
