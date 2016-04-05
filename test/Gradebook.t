#!/usr/bin/env perl -w

use Test::More tests => 9;

use Gradebook;

my $filename = "./test_data.csv";

my $gradebook = Gradebook->new($filename);

ok(defined($gradebook) && ref $gradebook eq 'Gradebook', 'new() works');

my @class_keys = sort keys $gradebook->classes;
is(@class_keys, 2, 'correct number of classes');
is($class_keys[0], "30-35000-2", "first class code extracted okay");
is($class_keys[1], "30-35000-3", "second class code extracted okay");

my @student_keys0 = sort keys $gradebook->classes->{$class_keys[0]};
is(@student_keys0, 2, "first class has 2 students");
is($student_keys0[0], "Test 1", "first class first student key okay");
is($student_keys0[1], "Test 2", "first class second student key okay");

my @student_keys1 = sort keys $gradebook->classes->{$class_keys[1]};
is(@student_keys1, 1, "second class has 1 student");
is($student_keys1[0], "Test 3", "second class first student key okay");
