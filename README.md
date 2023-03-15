# TopGG-Perl-SDK

A Perl SDK for interacting with the Top.gg API, including Webhooks and Widgets support.

## Installation

Copy the `TopGG.pm`, `TopGG_Webhook.pm`, and `TopGG_Widgets.pm` files to your project's directory.

## Usage

### TopGG API

```perl
use TopGG;

my $topgg = TopGG->new(token => 'YOUR-TOKEN');
my $bot = $topgg->get_bot('BOT-ID');
```

### TopGG Webhooks

```perl
use Plack::Builder;
use TopGG::Webhook;

my $webhook = TopGG::Webhook->new(
  auth => 'YOUR-AUTH',
  on_vote => sub {
    my $data = shift;
    print "User $data->{user} voted for bot $data->{bot}\n";
  }
);

builder {
  mount '/webhook' => $webhook->to_app;
};
```

### TopGG Widgets

```perl
use TopGG::Widgets;

my $widgets = TopGG::Widgets->new();

my $widget_url = $widgets->get_widget_url('status', 'BOT-ID', noavatar => 'true', leftcolor => 'FF0000', righttext => 'white');
print "Widget URL: $widget_url\n";
```
