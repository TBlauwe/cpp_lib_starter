#include <doctest/doctest.h>
#include <my_project/lib.hpp>

TEST_CASE("Basic")
{
	CHECK(mp::success() == 1);
}