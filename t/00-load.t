#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Geo::OSM::Overpass::Plugin::FetchStreetLamps' ) || print "Bail out!\n";
}

diag( "Testing Geo::OSM::Overpass::Plugin::FetchStreetLamps $Geo::OSM::Overpass::Plugin::FetchStreetLamps::VERSION, Perl $], $^X" );
