#include <doctest/doctest.h>
#include <my_lib/my_lib_header.hpp>

TEST_CASE("Basic")
{
	CHECK(ml::success() == 1);
}