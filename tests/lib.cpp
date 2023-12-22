#include <doctest/doctest.h>
#include <{{tmplr.repo_name}}/{{tmplr.repo_name}}.hpp>

TEST_CASE("Basic")
{
	CHECK({{tmplr.namespace}}::success() == 1);
}