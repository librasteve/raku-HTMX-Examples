use IO::Notification::Recursive;

my $dir = "."; # Directory to watch
my $supply = watch-recursive($dir, :update);

$supply.tap(-> $change {
    say "Change detected: $change";
    # Handle the change here
});

# Keep the program running
loop { }