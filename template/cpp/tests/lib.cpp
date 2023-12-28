#include <doctest/doctest.h>
#include <{{tmplr.repo_name | lowercase}}/{{tmplr.repo_name | lowercase}}.hpp>

TEST_CASE("Basic")
{
	CHECK({{tmplr.namespace}}::success() == 1);
}