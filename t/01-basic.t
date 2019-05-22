#!/usr/bin/env perl

use strict;
use warnings;

use lib 'blib/lib';

use Test::More;

use Geo::OSM::Overpass;
use Geo::OSM::Overpass::Plugin::FetchStreetLamps;
use Geo::BoundingBox;

my $num_tests = 0;

my $bbox = Geo::BoundingBox->new();
ok(defined $bbox && 'Geo::BoundingBox' eq ref $bbox, 'Geo::BoundingBox->new()'.": called") or BAIL_OUT('Geo::BoundingBox->new()'.": failed, can not continue."); $num_tests++;
# this is LAT,LON convention
ok(1 == $bbox->bounded_by(
	[52.3700933, 9.7530264, 52.3710933, 9.7540264]
), 'bbox->bounded_by()'." : called"); $num_tests++;

my $eng = Geo::OSM::Overpass->new();
ok(defined $eng && 'Geo::OSM::Overpass' eq ref $eng, 'Geo::OSM::Overpass->new()'.": called") or BAIL_OUT('Geo::OSM::Overpass->new()'.": failed, can not continue."); $num_tests++;
$eng->verbosity(2);
ok(defined $eng->bbox($bbox), "bbox() called"); $num_tests++;

my $plug = Geo::OSM::Overpass::Plugin::FetchStreetLamps->new({
	'engine' => $eng
});
ok(defined($plug) && 'Geo::OSM::Overpass::Plugin::FetchStreetLamps' eq ref $plug, 'Geo::OSM::Overpass::Plugin::FetchStreetLamps->new()'." : called"); $num_tests++;

ok(defined $plug->gorun(), "checking gorun()"); $num_tests++;

my $result = $eng->last_query_result();
ok(defined $result, "checking if got result"); $num_tests++;
# saturn operator, see https://perlmonks.org/?node_id=11100099
ok(defined($result) && $$result =~ m|<node.+?id="438153824".+?>.*?<tag.+?v="street_lamp".+?>|s, "checking result contains specific node."); $num_tests++;
ok(defined($result) && 1 == ( ()= $$result =~ m|<node.+?id=".+?".+?>.*?<tag.+?v="street_lamp".+?>|gs), "checking result contains exactly one node."); $num_tests++;

# END
done_testing($num_tests);
