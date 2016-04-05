#! /usr/bin/env perl

use v5.10.0;
use strict;
use warnings;

use POSIX;
use Gradebook;

=head1 About

The school I teach at uses Haiku Learning for its course gradebooks and websites.
Despite the gradebook being able to do quite a lot, it will not find the lowest
remaining score in a category. This is a perl script that is designed to do that.

The intended audience is teachers who can run a script from the command line on
a mac/linux system. It may also work on windows, but I have not tested it there.

=head2 Getting the CSV File

The script is meant to be run on the CSV exported version of the gradebook. To
export a CSV file of the gradebook:

1. go to a class site on your Haiku instance
2. go to the Assess tab
3. select the Reports option from the drop-down menu
4. in the sub-menu across the top, from Reports, select Gradebook Export
5. select All Assignments and click Export
6. the CSV file should download after a short time

=head2 Running the Script

After cloning/downloading this repository (and having Perl installed on your system),
you can run the script by calling

    ./lowest_score.pl csv_file [category]

The argument `csv_file` should be the path to the csv file that you downloaded
for your class.

The optional argument `category` is the name of the category you would like to
find the lowest score for. The default value is "Quizzes and Practice Problems",
but that is unlikely to be useful for you.

=cut

my $num_args = $#ARGV + 1;
if ($num_args < 1) {
    die "\nUsage: lowest_quiz.pl csv_file [category]\n";
}

my $filename = $ARGV[0];
my $category = $ARGV[1] || "Quizzes and Practice Problems";

my $gradebook = Gradebook->new($filename);

foreach my $class (sort keys $gradebook->classes)
{
  my $num_students = keys $gradebook->classes->{$class};
  print "$class ($num_students)\n";

  foreach my $student_name (sort keys $gradebook->classes->{$class})
  {
    my $student = $gradebook->classes->{$class}->{$student_name};
    my $lowest = $student->lowest_assignment($category);
    if (!$lowest)
    {
      print "\t", $student->name, ": none\n";
    }
    else
    {
      print "\t", $student->name, ": ", $lowest->name, " (", POSIX::floor($lowest->pct * 10000) / 100, "%)\n";
    }
  }
}
