#!/usr/bin/env perl -w

use Test::More tests => 10;

use Gradebook::Assignment;

my $a1 = Gradebook::Assignment->new(name => "Test 1", score => 2, outof => 4, type => "Quiz");
my $a2 = Gradebook::Assignment->new(name => "Test 2", score => "DR", outof => 6, type => "Test");

ok(defined($a1) && ref $a1 eq "Gradebook::Assignment", "new() okay 1");
ok(defined($a2) && ref $a2 eq "Gradebook::Assignment", "new() okay 2");

is($a1->name, "Test 1", "name() okay 1");
is($a2->name, "Test 2", "name() okay 2");

is($a1->pct, 0.5, "pct() okay 1");
is($a2->pct, "inf", "pct() okay 2");

is($a1->category, "Quiz", "category() okay 1");
is($a2->category, "Test", "category() okay 2");

is($a1->pts_possible, 4, "pts_possible() okay 1");
is($a2->pts_possible, 6, "pts_possible() okay 2");
