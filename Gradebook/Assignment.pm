package Gradebook::Assignment;

use v5.10.0;
use strict;
use warnings;

use Scalar::Util;

=head1 NAME

Assignment - holds data for a student's assignment

=head1 About

=head1 Constructor

=head2 new

Creates a new assignment instance

Parameters:

=over
=item name - The assignment name
=item type - The assignment category/type
=item score - The student's score
=item outof - The total possible score
=back

Example:

  my $assignment = Gradebook::Assignment->new(name => "Quiz 1", type => "Quizzes", score => 5, outof => 7)

=cut

sub new {
  my $class = shift;
  my %options = @_;

  my $self = {
    name => "",
    type => "other",
    score => 0,
    outof => 0,
    %options,
  };

  bless($self, $class);
  return($self);
}

=head1 Attributes

=head2 pct

The percentage for the assignment

If the score is non-numeric, the value returned is "inf"

=cut

sub pct {
  my $self = shift;

  if (Scalar::Util::looks_like_number($self->{score}))
  {
    return($self->{score} / $self->{outof});
  }
  else
  {
    return "inf";
  }
}

=head2 category

Returns the category/type of the assignment

=cut

sub category {
  my $self = shift;
  return($self->{type});
}

=head2 name

Returns the name of the assignment

=cut

sub name {
  my $self = shift;

  return($self->{name});
}

=head2 pts_possible

Returns the number of points possible for the Assignment
(used to determine if it is extra credit elsewhere)

=cut

sub pts_possible {
  my $self = shift;
  return($self->{outof});
}

1;
