package TopGG::Webhook;

use strict;
use warnings;
use Plack::Request;
use Plack::Response;
use JSON;

sub new {
  my ($class, %args) = @_;
  my $self = \%args;
  bless $self, $class;
  return $self;
}

sub _verify_signature {
  my ($self, $req) = @_;
  my $signature = $req->headers->header('X-Signature');
  return if !$signature;
  return if !defined $self->{auth};
  return if $signature ne $self->{auth};
  return 1;
}

sub _handle_vote {
  my ($self, $env) = @_;
  my $req = Plack::Request->new($env);
  my $res = Plack::Response->new(200);
  
  return $res->finalize if !$self->_verify_signature($req);
  
  my $data = decode_json($req->content);
  $self->{on_vote}->($data) if $self->{on_vote};
  
  $res->content_type('application/json');
  $res->content(encode_json({status => 'success'}));
  return $res->finalize;
}

sub to_app {
  my ($self) = @_;
  return sub {
    my $env = shift;
    return $self->_handle_vote($env);
  };
}

1;
