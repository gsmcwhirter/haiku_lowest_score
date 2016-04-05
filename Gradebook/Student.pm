package Gradebook::Student;

use v5.10.0;
use strict;
use warnings;

use Gradebook::Assignment;

=head1 NAME

Student - represents a student and holds his/her assignments

=head1 About

=head1 Constructor

=head2 new

Creates a new student with a blank array of assignments.

Parameters:

=over
=item name - the student's name
=back

Example:

  my $student = Gradebook::Student->new(name => "Jane Smith");

=cut

sub new {
  my $class = shift;

  my %options = @_;

  my $self = {
    # default options go here
    assignments => [],
    %options,
  };

  die "Students require a name." unless ($self->{name});

  bless($self, $class);
  return($self);
}

=head1 Attributes

=head2 name

Returns the student's name

=cut

sub name {
  my $self = shift;
  return($self->{name});
}

=head2 lowest_assignment

Calculates the student's lowest assignment in the given category by percentage

Parameters:

=over
=item the category to search for the lowest assignment in
=back

Example:

  my $lowest_quiz = $student->lowest_assignment("Quizzes");
  my $lowest_test = $student->lowest_assignment("Tests");

This method ignores assignments that are out of 1 point and those whose name
matches /E(xtra )?C(redit)?/i

=cut

sub lowest_assignment {
  my $self = shift;
  my $category = shift;

  my $lowest_assignment;

  if ($self->{assignments})
  {
    foreach my $assignment (@{$self->{assignments}})
    {

      if ($assignment->category eq $category &&
          $assignment->pts_possible != 1 &&
          $assignment->name !~ /E(xtra )?C(redit)?/i &&
           (!$lowest_assignment || $assignment->pct < $lowest_assignment->pct) )
      {
         $lowest_assignment = $assignment;
      }
    }
  }

  return $lowest_assignment;
}

=head1 Mutators

=head2 add_assignment

Creates and records an assignment for the student

Parameters:

=over
=item name - the name of the assignment
=item type - the category/type of assignment
=item score - the student's score
=item outof - the total possible score
=back

Example:

  $student->add_assignment(name => "Test", type => "Quiz", score => 5, outof => 7);

=cut

sub add_assignment {
  my $self = shift;
  my %options = @_;

  my $assignment = Gradebook::Assignment->new(type => $options{type}, score => $options{score}, outof => $options{outof}, name => $options{name});

  push(@{$self->{assignments}}, $assignment);
}

1;
