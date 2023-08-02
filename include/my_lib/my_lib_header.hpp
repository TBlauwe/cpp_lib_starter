/*****************************************************************//**
@file   my_lib_header.hpp
@brief  Main file.

@defgroup MY_LIB My lib

@details 

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Usage:

@code{.cpp}
#include <my_lib/my_lib_header.hpp>

my_namespace::success();
@endcode
 
@author Tristan
@date   August 2023
 *********************************************************************/
#pragma once


/**
    @namespace my_namespace
    @brief a simple namespace
**/
namespace my_namespace
{
	/**
		@brief A simple function return an int.
		@return Always 1;
	**/
    int success();
}
