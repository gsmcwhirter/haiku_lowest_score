package Gradebook;

use Gradebook::Student;

use v5.10.0;
use strict;
use warnings;

=head1 NAME

Gradebook - This class represents a gradebook, possibly with many sections/classes

=head1 About

The gradebook parses the requested CSV file and sorts students into their classes/sections
as well as loads each student object with its assignment details.

  my $gradebook = Gradebook->new("my_file.csv");
  foreach my $class_code (keys $gradebook->classes)
  {
    say $gradebook->classes->${class_code};
  }

=head1 Constructor

=head2 new

  my $gradebook = Gradebook->new("my_file.csv");

=cut

sub new {
  my $class = shift;
  my $csvfile = shift;

  my %options = @_;

  my $self = {
    # default options go here
    %options,
  };

  bless($self, $class);

  $self->{classes} = $self->_parse_csv($csvfile);
  return($self);
}

=head1 Attributes

=head2 classes

Returns a hash whose keys are the class/section codes and whose contents are
hases of students; The hash of students has keys of student names, and values of
Gradebook::Student objects

=cut

sub classes {
  my $self = shift;
  return($self->{classes});
}

=head1 Private Helper Methods

=head2 _parse_csv

Loads in the CSV file requested

=cut

sub _parse_csv {
  my $self = shift;
  my $filename = shift(@_);

  die "A csv filename must be supplied." unless ($filename);

  open(my $fh, "<", $filename) or die "Could not open the CSV file: $filename.";

  my $classes = {};

  <$fh>; # get rid of the header row

  while (<$fh>)
  {
    s/[\r\n]+//; #csv is written on windows, apparently,
                 #so need this instead of chomp, since I don't want to do $/ = "\r\n"
    my @row = split(",");
    my $class_pd = $row[@row - 1];
    my $name = $row[3] . " " . $row[5];

    if (!$classes->{$class_pd})
    {
      $classes->{$class_pd} = {};
    }

    if (!$classes->{$class_pd}->{$name})
    {
      $classes->{$class_pd}->{$name} = Gradebook::Student->new(name => $name);
    }

    $classes->{$class_pd}->{$name}->add_assignment(type => $row[9], name => $row[6], score => $row[15], outof => $row[16]);
  }

  return($classes);
}

1;
