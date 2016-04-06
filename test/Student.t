#!/usr/bin/env perl -w

use Test::More tests => 9;

use Gradebook::Student;

my $student = Gradebook::Student->new(name => "Test");

ok(defined($student) && ref $student eq "Gradebook::Student", "new() okay");

is($student->name, "Test", "name() okay");
is($student->assignments, 0, "assignments() start empty");

$student->add_assignment(name => "Test", type => "Test Category", score => 3, outof => 4);

is($student->assignments, 1, "add_assignment() adds something");
is(ref (($student->assignments)[0]), "Gradebook::Assignment", "add_assignment() adds a Gradebook::Assignment");
is(($student->assignments)[0]->name, "Test", "add_assignment() passes name correctly");
is(($student->assignments)[0]->pct, 0.75, "add_assignment() generates correct pct");
is(($student->assignments)[0]->pts_possible, 4, "add_assignment() passes total pts correctly");
is(($student->assignments)[0]->category, "Test Category", "add_assignment() passes type/category correctly");
