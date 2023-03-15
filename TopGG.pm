package TopGG;

use strict;
use warnings;
use LWP::UserAgent;
use JSON;
use HTTP::Request;

sub new {
  my ($class, %args) = @_;
  my $self = \%args;
  bless $self, $class;
  $self->{ua} = LWP::UserAgent->new();
  return $self;
}

sub _req {
  my ($self, $method, $url, $data) = @_;
  my $req = HTTP::Request->new($method => $url);
  $req->header('Authorization', $self->{token});
  $req->header('Content-Type', 'application/json');
  $req->content(encode_json($data)) if $data;
  my $res = $self->{ua}->request($req);
  return decode_json($res->content);
}

sub get_bot {
  my ($self, $bot_id) = @_;
  return $self->_req('GET', "https://top.gg/api/bots/$bot_id", undef);
}

sub get_user {
  my ($self, $user_id) = @_;
  return $self->_req('GET', "https://top.gg/api/users/$user_id", undef);
}

sub get_bot_stats {
  my ($self, $bot_id) = @_;
  return $self->_req('GET', "https://top.gg/api/bots/$bot_id/stats", undef);
}

sub post_bot_stats {
  my ($self, $bot_id, $data) = @_;
  return $self->_req('POST', "https://top.gg/api/bots/$bot_id/stats", $data);
}

sub get_bot_votes {
  my ($self, $bot_id) = @_;
  return $self->_req('GET', "https://top.gg/api/bots/$bot_id/votes", undef);
}

sub has_voted {
  my ($self, $bot_id, $user_id) = @_;
  return $self->_req('GET', "https://top.gg/api/bots/$bot_id/check?userId=$user_id", undef);
}

sub search_bots {
  my ($self, %args) = @_;
  my $query = join('&', map { "$_=$args{$_}" } keys %args);
  return $self->_req('GET', "https://top.gg/api/search?q=$query", undef);
}

1;
