use Test::More tests => 26;

# -----------------------------------------------

sub check
{
	my($data, $page, $offset, $result)	= @_;
	my(@bounds)							= $page -> offset($offset) -> bounds();

	is(join(', ', @$data[$bounds[0] .. $bounds[1] ]), $result, "Offset: $offset. Result: $result");

}	# End of check.

# -----------------------------------------------

BEGIN{ use_ok('Data::Page::Viewport'); }

my(@data) = (qw/zero one two three four five six
seven eight nine ten eleven twelve thirteen fourteen/);
my($page) = Data::Page::Viewport -> new
(
	data_size => scalar @data,
	page_size => 4
);

isa_ok($page, 'Data::Page::Viewport');
check(\@data, $page, - 2, 'zero, one, two, three');
check(\@data, $page, 1, 'one, two, three, four');
check(\@data, $page, 4, 'five, six, seven, eight');
check(\@data, $page, 4, 'nine, ten, eleven, twelve');
check(\@data, $page, 1, 'ten, eleven, twelve, thirteen');
check(\@data, $page, 3, 'thirteen, fourteen');
check(\@data, $page, 3, 'thirteen, fourteen');
check(\@data, $page, - 2, 'eleven, twelve, thirteen, fourteen');
check(\@data, $page, 1, 'twelve, thirteen, fourteen');
check(\@data, $page, 2, 'fourteen');
check(\@data, $page, 1, 'fourteen');
check(\@data, $page, - 4, 'ten, eleven, twelve, thirteen');
check(\@data, $page, - 4, 'six, seven, eight, nine');
check(\@data, $page, - 1, 'five, six, seven, eight');
check(\@data, $page, 1, 'six, seven, eight, nine');
check(\@data, $page, 2, 'eight, nine, ten, eleven');
check(\@data, $page, - 1, 'seven, eight, nine, ten');
check(\@data, $page, - 2, 'five, six, seven, eight');
check(\@data, $page, - 2, 'three, four, five, six');
check(\@data, $page, - 1, 'two, three, four, five');
check(\@data, $page, - 4, 'two, three, four, five');
check(\@data, $page, 4, 'six, seven, eight, nine');
check(\@data, $page, 4, 'ten, eleven, twelve, thirteen');
check(\@data, $page, 4, 'fourteen');
