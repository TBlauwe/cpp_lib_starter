/**
    @file      my_lib_header.hpp
    @brief     A simple header file 

    @details   

Usage:

@code{.cpp}
#include <my_lib/my_lib_header.hpp>
// Somewhere in your code ...
my_namespace::success();
@endcode

    @author    Tristan
    @date      2.08.2023

**/
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
