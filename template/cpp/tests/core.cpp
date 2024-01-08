#include <doctest/doctest.h>
#include <{{tmplr.repo_name | lowercase}}/core.hpp>

TEST_CASE("Basic")
{
	CHECK({{tmplr.namespace}}::success() == 1);
}