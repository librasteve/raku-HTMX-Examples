use v6.d;

class Build {
    method build($dist-path) {

        #| also specified in en_SI.rakumod
        my $rahx = '.rahx-config';
        my $file = 'html5-tags-list.csv';

        #| mkdir will use existing if present
        mkdir "$*HOME/$rahx";

        copy "resources/$file", "$*HOME/$rahx/$file";

        exit 0
    }
}

