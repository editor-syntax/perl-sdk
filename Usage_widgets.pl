use TopGG::Widgets;

my $widgets = TopGG::Widgets->new();

my $widget_url = $widgets->get_widget_url('status', 'BOT-ID', noavatar => 'true', leftcolor => 'FF0000', righttext => 'white');
print "Widget URL: $widget_url\n";
