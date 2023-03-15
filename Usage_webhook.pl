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
