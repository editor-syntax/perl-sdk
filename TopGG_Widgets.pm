package TopGG::Widgets;

use strict;
use warnings;

sub new {
  my ($class, %args) = @_;
  my $self = \%args;
  bless $self, $class;
  return $self;
}

sub get_widget_url {
  my ($self, $type, $id, %options) = @_;
  my $base_url = "https://top.gg/api/widget/$type/$id.svg";
  my $query = join('&', map { "$_=$options{$_}" } keys %options);
  return $query ? "$base_url?$query" : $base_url;
}

1;
