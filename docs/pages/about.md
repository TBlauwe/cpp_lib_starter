@mainpage Cpp library starter

@tableofcontents

Welcome to the documentation for the template repository [cpp_library_starter](https://github.com/TBlauwe/cpp_lib_starter).
The contents is divided into two sections :
* @ref Usage : instructions and informations related to this template.
* @ref Guide : instructions and informations to write documentation with this template (with [Doxygen](https://www.doxygen.nl/) and [MCSS](https://mcss.mosra.cz/)).


@section Usage

This is a simple and opitionated template used as a learning process and a bootstrap for my projects.


## Features

* Tests build with **[Doctest](https://github.com/doctest/doctest)**
* Benchmarks build with **[Google Benchmark](https://github.com/google/benchmark)**
* Docs build with Doxygen and **[m.css](https://mcss.mosra.cz/)** from **[Magnum Engine](https://magnum.graphics/)**
* Dependencies downloaded with **[CPM](https://github.com/cpm-cmake/)**.
* Severals cmake functions to reduce boilerplate


@subsection getting-started Getting started

Go to the [github repository](https://github.com/TBlauwe/cpp_lib_starter) and click on `Use this this template`

@image html images/instructions_github_use_template.png


Now, replace the following identifiers :

* `my_lib` : cmake target, folder name
* `MYLIB` : cmake project name and cmake variables prefix
* `ml` : namespace, only in source files.
* `my_lib_source` : in `src/`
* `my_lib_header` : in `include/my_lib`

@m_div{m-note m-warning}
  @m_div{m-text m-big}Warning@m_enddiv
  Make sure that `#include <my_lib/my_lib_header.hpp>` directives are also replaced !
@m_enddiv

### CMakePresets.json

For cross-platform compiling, we use `CMakePresets.json` (see [ref](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html) 
to share settings for configuring projects.

We provide 10 configurations :

@cb{.json}
// Windows specific
{"name": "x64-debug-msvc", "inherits": ["Base", "Ninja", "x64", "MSVC", "Debug"]},
{"name": "x64-release-msvc", "inherits": ["Base", "Ninja", "x64", "MSVC", "Release"]},
{"name": "x64-debug-clang-cl", "inherits": ["Base", "Ninja", "x64", "Clang-cl", "Debug"]},
{"name": "x64-release-clang-cl", "inherits": ["Base", "Ninja", "x64", "Clang-cl", "Release"]},
{"name": "x64-debug-gcc", "inherits": ["Base", "Ninja", "x64", "GCC", "Debug"]},
{"name": "x64-release-gcc", "inherits": ["Base", "Ninja", "x64", "GCC", "Release"]},

// For Windows Subsystem Linux (WSL), but should work on others
{"name": "x64-debug-clang", "inherits": ["Base", "Ninja", "x64", "Clang", "Debug", "wsl"]},
{"name": "x64-release-clang", "inherits": ["Base", "Ninja", "x64", "Clang", "Release", "wsl"]},
{"name": "x64-debug-gnu", "inherits": ["Base", "Ninja", "x64", "GCC", "Debug", "wsl"]},
{"name": "x64-release-gnu", "inherits": ["Base", "Ninja", "x64", "GCC", "Release", "wsl"]}
@ce

@m_div{m-note m-info}
	@m_div{m-text m-big}Note 1@m_enddiv
	`Clang-cl` refers to the clang toolchain provided by [Visual Studio 2022](https://learn.microsoft.com/en-us/cpp/build/clang-support-msbuild?view=msvc-170)
@m_enddiv

@m_div{m-note m-info}
	@m_div{m-text m-big}Note 2@m_enddiv
	Each configuration name has to be different from each other, hence why we have `x64-release-gnu` and `x64-release-gcc`.
@m_enddiv

Thanks to the structure of the file, you can easily add other configurations, by inheritings relevant configurations.

@cb{.json}
{"name": "x84-reldebwithinfo-msvc", "inherits": ["Base", "AnOtherGenerator", "x84", "MSVC", "RelDebWithInfo"]},
@ce

@m_div{m-note m-warning}
  @m_div{m-text m-big}Warning@m_enddiv
  Some configurations may not work if some binaries and libraries are not in your `PATH`. 
  For example, by default with Visual Studio 2022, all windows specific configurations works but `GCC`.
  Vice-versa, only `GCC` works in CLion but not the others (unless you tweak your path).
@m_enddiv

If you need to specify some cache variables for CMake, you can add them to the `base` configuration :

@cb{json}
    {
      "name": "Base",
      "hidden": true,
      "displayName": "Default config",
      "description": "Default build",
      "binaryDir": "${sourceDir}/out/build/${presetName}",
      "installDir": "${sourceDir}/out/install/${presetName}",
      "cacheVariables": 
	  {
		// HERE !
		"CPM_SOURCE_CACHE": "path/to/cache"
	  }
    },
@ce

@m_div{m-note m-info}
	`CPM_SOURCE_CACHE` tells **[CPM](https://github.com/cpm-cmake/)** where downloaded libraries should be stored.
	We recommend to set CPM_SOURCE_CACHE on your path, rather than with cache variables. It is too specific for each user.
	By default, they will be downloaded in the cmake output binary directory.
@m_enddiv


### Dependencies

Dependencies are downloaded with **[CPM](https://github.com/cpm-cmake/)**.
This step can be skipped by setting `MY_LIB_SKIP_DEPENDENCIES` to `ON`. By default, it is `OFF` if it is the main
project, `ON` otherwise.

Each dependencies version can be override by setting `CPM_MY_DEP_VERSION` to a git tag, e.g `master`, `v3.12`, `1.0`, etc.

To reduce boilerplates, `cpm/tools.cmake` provide several functions and macros :

* `macro(ADD_VERSION)` is a macro to set an option specifying a third_library version :

@cmake
ADD_VERSION(NAME fmt VERSION "10.0.0")
@ce

* `macro(DOWNLOAD_LIBRARY)` is a macro wrapping `CPMAddPackage` to use version provided by the corresponding option :

@cmake
DOWNLOAD_LIBRARY(
  NAME fmt
  TARGETS fmt fmt-header-only
  GITHUB_REPOSITORY fmtlib/fmt
  OPTIONS
    "FMT_INSTALL OFF"
)
@ce

It can mostly be used the same as `CPMAddPackage`. 
By default, it will also try to suppress warnings of targets specified by `TARGETS` or `NAME` if no `TARGETS` are provided.
It can by skipped by specifying `NO_SILENCE_WARNINGS`.

@m_div{m-note m-danger}
	@m_div{m-text m-big}Not working@m_enddiv
	Sadly, suppressing warnings like this doesn't work for now ! 
	See this [article](https://www.foonathan.net/2018/10/cmake-warnings/.)
@m_enddiv


### CMake Verbosity

CMake output is very verbose, with headers, spaces, indentation, etc. 
When building as a main project, I like to be able to quickly recognize each step.
But, when using it as a library, it shouldn't populate user's cmake output. Only relevant informations should 
be displayed.

Currently, if I import a library built with this repository in an other project using the same repository,
here is how the output looks like :

@cmake
1> [CMake] --   Finding fmt
1> [CMake] --     (fmt) Version: 10.0.0
1> [CMake] --     (fmt) Build type: Debug
1> [CMake] --     (fmt) Performing Test HAS_NULLPTR_WARNING
1> [CMake] --     (fmt) Performing Test HAS_NULLPTR_WARNING - Success
1> [CMake] --     (fmt) CPM: Adding package fmt@10.0.0 (10.0.0 at C:/dev/deps/fmt/c77b38c6a3f42c882bb968b232e2ea7085d475fd)
1> [CMake] --     (fmt) Trying to suppress build warnings for target : fmt.
1> [CMake] --     (fmt) Trying to suppress build warnings for target : fmt-header-only.
1> [CMake] --   Finding fmt - found.
1> [CMake] --                       
1> [CMake] --   Finding slog
1> [CMake] --     (slog) 
1> [CMake] --     (slog) -----------------------------------------------
1> [CMake] --     (slog) Configuring target : slog
1> [CMake] --     (slog) -----------------------------------------------
1> [CMake] --     (slog) 
1> [CMake] --     (slog) Configuring target : slog - done.
1> [CMake] --     (slog) 
1> [CMake] --     (slog) -----------------------------------------------
1> [CMake] --     (slog) Finished configuration
1> [CMake] --     (slog) -----------------------------------------------
1> [CMake] --     (slog) 
1> [CMake] --     (slog) CPM: Adding package slog@ (master at C:/dev/deps/slog/d17e3f679fd2e2f98e80ab8788d2de4764a16dbf)
1> [CMake] --   Finished configuration - found.
@ce

As you can see there is some clutter, but not much. The reason is `SLOG_SKIP_DEPENDENCIES` is `ON` by default
when not configured as the main project.

An other solution would be to set `FETCH_CONTENT_QUIET ON`.

Anyways, in the future, I would like to adapt the output so it's nicer when importing the library.


### Additional targets

Tests, docs and benchmarks adds additional targets. It was choosen to not propose option to build them, as they will
be built only if this is the main project.

Executables location are specified by variable `${PROJECT_EXE_DIR}` in the main `CMakeLists.txt`. 
By default, it is set to : `${PROJECT_SOURCE_DIR}/bin`.
Note that it is not prefixed by `MY_LIB`. As of now, it is only set when the library is built as the main project.
So I thought it would be nice to follow cmake convention like `${PROJECT_SOURCE_DIR}`.


### Documentation

Two targets are provided :

* `generate_docs` uses **[m.css](https://mcss.mosra.cz/)** from **[Magnum Engine](https://magnum.graphics/)** to build the documentation.
* `open_docs` is a convenience target to open docs without the hassle of finding it.

The following tools are needed :
* Doxygen, 
* jinja2 
* Pygments 

### Instructions

On MacOs :

@cb{sh}
brew install doxygen
pip3 install jinja2 Pygments
@ce

On windows using chocolatey (need elevated privileges) :

@cb{sh}
choco install doxygen.install
choco install python
pip3 install jinja2 Pygments
@ce

@m_div{m-note m-warning}
	@m_div{m-text m-big}Warning@m_enddiv
	Make sure to Doxygen is in your path !
@m_enddiv


### Benchmarks

The library used for benchmarking is [Google benchmark](https://github.com/google/benchmark).

If you want to pass more options to tune the benchmarking, see 
[Google benchmark usage guide](https://github.com/google/benchmark/blob/main/docs/user_guide.md).

Alternitavely, you can use `bin\benchmarks\run_benchmarks.py` python script, to run benchmarks with a predefined set of options.


@cb{sh}
py run_benchmarks.py Benchmarks.exe -n SomeName
@ce

This line will generate a `.json` file with 'SomeName' in its name. It will also repeat benchmarks 10 times and compute the mean, median, variance, etc.

To compare two benchmarks, you can use the following command :

@cb{sh}
py tools/compare.py benchmarks <baseline> <comparison>
@ce

Replace `<baseline>` and `<comparison>` with `.json` files obtained when running your benchmarks.




@section Guide

In this section, we will see some useful commands provided by [Doxygen](https://www.doxygen.nl/) and [MCSS](https://mcss.mosra.cz/).
Note, that Doxygen allows us to mix doxygen commands in markdown. So instead of using `.dox` extensions, we use `.md`. Make
sure to check both references for more details :

@m_div{m-button m-primary} 
	<a href="https://www.doxygen.nl/manual/commands.html">
	@m_div{m-text m-big}Doxygen 
	@m_enddiv 
	@m_div{m-small} 
		references
	@m_enddiv 
	</a> 
@m_enddiv
@m_div{m-button m-primary} 
	<a href="https://mcss.mosra.cz/css/components/">
	@m_div{m-text m-big}M.CSS
	@m_enddiv 
	@m_div{m-small} 
		references
	@m_enddiv 
	</a> 
@m_enddiv


@subsection References

This (sub)-section was obtained with :

@cb{.md}
@section reference References
^         ^         ^
command   name      title
@ce


### Section

this section was obtained with :

@cb{.md}
### Section
@ce


### Code blocks

By default with doxygen, use `@code{} ... @endcode` to write code blocks.

Some aliases are provided `@cb{} ... @ce`, `@cpp ... @ce` and `@cmake ... @ce`: 


### Images

Images are added with command `image` ([see doxygen ref](https://www.doxygen.nl/manual/commands.html#cmdimage)).

@image html images/cute_smiling_robot_head.png "Robot" width=5cm

`@image html images/cute_smiling_robot_head.png "Robot" width=10cm`

@m_div{m-note m-warning}
	@m_div{m-text m-big}Path@m_enddiv
	Make sure images are stored correctly. As I had a lot of trouble with it, I decided to copy 
	images to the html folder generated before building the docs. A cmake function `add_assets` is provided
	(see `docs/CMakeLists.txt`).
@m_enddiv


### Note

@m_div{m-note m-default}
	@m_div{m-text m-big}Default@m_enddiv
	This is a default note 
@m_enddiv

```
@m_div{m-note m-default}
	@m_div{m-text m-big}Default@m_enddiv
	This is a default note 
@m_enddiv
```

@m_div{m-note m-primary}
	@m_div{m-text m-big}Primary@m_enddiv
	This is a primary note
@m_enddiv

```
@m_div{m-note m-primary}
	@m_div{m-text m-big}Primary@m_enddiv
	This is a primary note
@m_enddiv
```

@m_div{m-note m-success}
	@m_div{m-text m-big}Success@m_enddiv
	This is a success note
@m_enddiv

```
@m_div{m-note m-success}
	@m_div{m-text m-big}Success@m_enddiv
	This is a success note
@m_enddiv
```

@m_div{m-note m-warning}
	@m_div{m-text m-big}WARNING@m_enddiv
	This is a warning note
@m_enddiv

```
@m_div{m-note m-warning}
	@m_div{m-text m-big}WARNING@m_enddiv
	This is a warning note
@m_enddiv
```

@m_div{m-note m-danger}
	@m_div{m-text m-big}Danger@m_enddiv
	This is a danger note
@m_enddiv

```
@m_div{m-note m-danger}
	@m_div{m-text m-big}Danger@m_enddiv
	This is a danger note
@m_enddiv
```

@m_div{m-note m-info}
	@m_div{m-text m-big}Info@m_enddiv
	This is an info note
@m_enddiv

```
@m_div{m-note m-info}
	@m_div{m-text m-big}Info@m_enddiv
	This is an info note
@m_enddiv
```

@m_div{m-note m-dim}
	@m_div{m-text m-big}Dim@m_enddiv
	This is a dim note
@m_enddiv

```
@m_div{m-note m-dim}
	@m_div{m-text m-big}Dim@m_enddiv
	This is a dim note
@m_enddiv
```

@m_div{m-note m-frame}
	@m_div{m-text m-big}Frame@m_enddiv
	This is a fram note
@m_enddiv

```
@m_div{m-note m-frame}
	@m_div{m-text m-big}Frame@m_enddiv
	This is a frame note
@m_enddiv
```


### Block

@m_div{m-block m-default}
	@m_div{m-text m-big}Default@m_enddiv
	This is a default block 
@m_enddiv

```
@m_div{m-block m-default}
	@m_div{m-text m-big}Default@m_enddiv
	This is a default block 
@m_enddiv
```

@m_div{m-block m-primary}
	@m_div{m-text m-big}Primary@m_enddiv
	This is a primary block
@m_enddiv

```
@m_div{m-block m-primary}
	@m_div{m-text m-big}Primary@m_enddiv
	This is a primary block
@m_enddiv
```

@m_div{m-block m-success}
	@m_div{m-text m-big}Success@m_enddiv
	This is a success block
@m_enddiv

```
@m_div{m-block m-success}
	@m_div{m-text m-big}Success@m_enddiv
	This is a success note
@m_enddiv
```

@m_div{m-block m-warning}
	@m_div{m-text m-big}WARNING@m_enddiv
	This is a warning block
@m_enddiv

```
@m_div{m-block m-warning}
	@m_div{m-text m-big}WARNING@m_enddiv
	This is a warning block
@m_enddiv
```

@m_div{m-block m-danger}
	@m_div{m-text m-big}Danger@m_enddiv
	This is a danger block
@m_enddiv

```
@m_div{m-block m-danger}
	@m_div{m-text m-big}Danger@m_enddiv
	This is a danger block
@m_enddiv
```

@m_div{m-block m-info}
	@m_div{m-text m-big}Info@m_enddiv
	This is an info block
@m_enddiv

```
@m_div{m-block m-info}
	@m_div{m-text m-big}Info@m_enddiv
	This is an info block
@m_enddiv
```

@m_div{m-block m-dim}
	@m_div{m-text m-big}Dim@m_enddiv
	This is a dim block
@m_enddiv

```
@m_div{m-block m-dim}
	@m_div{m-text m-big}Dim@m_enddiv
	This is a dim block
@m_enddiv
```

@m_div{m-block m-frame}
	@m_div{m-text m-big}Frame@m_enddiv
	This is a fram block
@m_enddiv

```
@m_div{m-block m-frame}
	@m_div{m-text m-big}Frame@m_enddiv
	This is a frame block
@m_enddiv
```

### Text 

@m_div{m-text m-big}Big@m_enddiv

```
@m_div{m-text m-big}Big@m_enddiv
```

@m_div{m-text m-small}Small@m_enddiv

```
@m_div{m-text m-small}Small@m_enddiv
```

@m_div{m-text m-tiny}Tiny@m_enddiv

```
@m_div{m-text m-tiny}Tiny@m_enddiv
```


A green formula:

Use the @m_class{m-label m-warning} **Shift** key.

This text contains a @m_span{m-text m-success} green @m_endspan word.