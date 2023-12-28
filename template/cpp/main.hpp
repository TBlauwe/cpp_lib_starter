/*****************************************************************//**
@file   {{ tmplr.repo_name | lowercase}}.hpp
@brief  Main file.

@defgroup {{ tmplr.namespace }} Your title

@details 

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Usage:

@code{.cpp}
#include <{{tmplr.repo_name | lowercase}}/{{tmplr.repo_name | lowercase}}.hpp>

{{tmplr.namespace}}::success();
@endcode
 
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


/** 
	\example 00_GettingStarted/main.cpp
	This is an example of how to get started with the library.
**/
