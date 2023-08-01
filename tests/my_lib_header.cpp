#include <doctest/doctest.h>
#include <my_lib/my_lib_header.hpp>

TEST_CASE("Basic")
{
	CHECK(my_namespace::success() == 1);
}