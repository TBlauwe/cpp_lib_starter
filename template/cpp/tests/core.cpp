#include <catch2/catch_test_macros.hpp>
#include <{{tmplr.repo_name | lowercase}}/core.hpp>

TEST_CASE("Basic")
{
	CHECK({{tmplr.namespace}}::success() == 1);
}