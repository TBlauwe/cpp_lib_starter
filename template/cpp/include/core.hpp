/*****************************************************************//**
@file   core.hpp
@brief  Main file.

@defgroup {{ tmplr.namespace }} Topic's title

@details 

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

@example getting_started.cpp
This is an example of how to get started with the library.

@author {{ tmplr.owner_name }}
@date   {{ tmplr.now }}
 *********************************************************************/
#pragma once
#include <{{tmplr.repo_name | lowercase}}/export.hpp>


/**
    @namespace {{tmplr.namespace}}
    @brief Library namespace
**/
namespace {{tmplr.namespace}}
{
	/**
		@brief A simple function returning an int.
		@return Always 1;
	**/
	{{tmplr.repo_name | CONSTANT_CASE}}_EXPORT
    int success();
}
