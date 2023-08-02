# Cpp Library Starter

[![Windows [Clang-cl & MSVC]](https://github.com/TBlauwe/cpp_lib_starter/actions/workflows/windows.yaml/badge.svg)](https://github.com/TBlauwe/cpp_lib_starter/actions/workflows/windows.yaml)
[![Ubuntu & MacOS [Clang & GCC]](https://github.com/TBlauwe/cpp_lib_starter/actions/workflows/ubuntu.yaml/badge.svg)](https://github.com/TBlauwe/cpp_lib_starter/actions/workflows/ubuntu.yaml)
[![Documentation build & deploy](https://github.com/TBlauwe/cpp_lib_starter/actions/workflows/documentation.yaml/badge.svg)](https://github.com/TBlauwe/cpp_lib_starter/actions/workflows/documentation.yaml)
[![Static Badge](https://img.shields.io/badge/Documentation_link-blue?logo=readthedocs&logoColor=white)](https://tblauwe.github.io/cpp_lib_starter/)


An opitionated template repository to build C++ projects.
I use it as a learning tool, but some may find some parts useful. 

The main goal is to be able to quickly incorporate a cross-platform library 
built with this template into others projects using **[CPM](https://github.com/cpm-cmake/)**.

```cmake
CPMAddPackage(
  NAME my_lib 
  GITHUB_REPOSITORY my_lib_repo/my_lib
)
target_link_libraries(some_target PUBLIC my_lib)
```


## Features

* __Dependencies__ are downloaded with **[CPM](https://github.com/cpm-cmake/)**.

* __Tests__ are built with **[Doctest](https://github.com/doctest/doctest)**. Using Github Actions,
tests are executed on :

    * Windows : msvc and clang-cl
    * Ubuntu : gcc and clang
    * MacOS : gcc and clang

* __Benchmarks__ are built with **[Google Benchmark](https://github.com/google/benchmark)**

* __Documentation__ is built with **[Doxygen](https://www.doxygen.nl/)** and **[m.css](https://mcss.mosra.cz/)** from **[Magnum Engine](https://magnum.graphics/)**.
Using Github Actions, documentation is automatically built and published to github pages. Github pages is also automatically configured. 
No need to create it manually.
> Documentation example available [here](https://tblauwe.github.io/cpp_lib_starter/)

* A great deal of care has been taken in writing clear and robust __CMake__ files. It should work on Windows, Linux, using WSL or not,
by command-line or with an IDE like Visual Studio or Clion.

* A verbose cmake output when built as the main project, but concise when imported.

* A clear, cross-platform & easily extendable __CMakePreset.json__ is also provided

* __Minimal cmake options__ used. Default values are best set (opinion) according to whether it is built 
as the main project or not. 


## Getting started

Go to the [github repository](https://github.com/TBlauwe/cpp_lib_starter) and click on `Use this template`

Once the setup is done, replace the following identifiers.

* `my_lib` : cmake target, folder name
* `MYLIB` : cmake project name and cmake variables prefix
* `my_namespace` : namespace, only in source files.
* `my_lib_source` : in `src/`
* `my_lib_header` : in `include/my_lib`

If you wish to reuse parts of the `README.md`, make sure to also replace
* `TBlauwe/cpp_lib_starter` with your github repository (so badges are linked to correct workflows).
* `https://tblauwe.github.io/cpp_lib_starter/` with your github pages link (so `Documentation link` badges
redirects to your site).

Also, in the root `CMakeLists.txt`, make sure to replace project information to your project.
They will be used for the generated documentation.

```cmake
# ----- Project information
project(MYLIB
	VERSION 0.1.0
	DESCRIPTION "Repository template for C++ projects"
	HOMEPAGE_URL "https://github.com/TBlauwe/cpp_lib_starter"
	LANGUAGES C CXX
)
```

It should be safe to do a "Replace All". Still, make sure that `#include <my_lib/my_lib_header.hpp>` 
are correctly replaced.

That should be it for building the main target, tests and benchmarks.
Documentation requires a bit more installation user-side.

You also probably don't need `docs/pages/about.md` and `docs/pages/empty.md` can replace its whole contents, just like for the
readme.


## CMake options

As stated before, you shouldn't have to change options, as they will be adapted to the situations.
Still, here is some options you may find interesting : 

* `MYLIB_SKIP_DEPENDENCIES` : Should dependencies be downloaded with **[CPM](https://github.com/cpm-cmake/)** 
and configured.
	* If built as main project, then by default it is set to `true`
	* If imported, then by default it is set to `false`
* `CPM_MY_DEPENDENCY_VERSION` : Specify a dependency version. It is not something added by **[CPM](https://github.com/cpm-cmake/)**
but by me. It adds an option for overriding the version of a dependency. The value is a git tag, e.g `master`, `v3.12`, `1.0`, etc.

Executables location are specified by variable `${PROJECT_EXE_DIR}` in the main `CMakeLists.txt`. 
By default, it is set to : `${PROJECT_SOURCE_DIR}/bin`.
Note that it is not prefixed by `MYLIB`. As of now, it is only set when the library is built as the main project.
So I thought it would be nice to follow cmake convention like `${PROJECT_SOURCE_DIR}`.


## CMake utilities

Inside `cmake/tools.cmake`, you will see several functions and macros. Most aren't noteworthy. They are mainly used 
to organise and build prettier output. They are by no means necessary. If you don't like them, feel free to skip them.

Here are three noteworthy functions/macros. 

### add_version

Macro used to set an option for a library.

Usage : 

```
add_version(NAME fmt VERSION "10.0.0")
```

It will set a cmake option `CPM_FMT_VERSION` to `10.0.0`. It will then be used by the following macro :

### download_library

Macro used to download a library using CPM. It is a wrapper of `CPMAddPackage` and used the same. The reason to add 
this wrapper is to play nicely with options/version added through `add_version` and also with cmake output.

Usage : 

```
download_library(
  NAME fmt
  TARGETS fmt fmt-header-only
  GITHUB_REPOSITORY fmtlib/fmt
  OPTIONS
    "FMT_INSTALL OFF"
)
```

As you can see, it is almost exactly the same as `CPMAddPackage`, but we didn't have to specify a version. The conjunction of these
two macros/functions may and are most likely overkill/useless. Still, I like the readability of these cmake files
and verbosity.

`TARGETS` is a multi-value arguments where you can pass targets.
By default, `download_library` will try to suppress warnings when building those targets (or the target of the same name as `NAME` if no `TARGETS` are provided).

> Sadly, suppressing warnings like this doesn't work for now (see this [article](https://www.foonathan.net/2018/10/cmake-warnings/.)).

To prevent this behaviour, you can pass the options `NO_SUPPRESS_WARNINGS`, like so :

```
download_library(
  NAME fmt
  GITHUB_REPOSITORY fmtlib/fmt
  OPTIONS
    "FMT_INSTALL OFF"
  NO_SUPPRESS_WARNINGS 
)
```

## Build


```cmake
cmake -S . -B build
cmake --build build --target <a-target>
```

No need to pass options, default should be good.
You can also use `CMakePresets.json` instead, [see below](#cmakepresets.json).

### Targets

Available targets are : 

* `my_lib` : main library
* `tests` : tests
* `benchmarks` : benchmarks
* `docs` : docs

## CMakePresets.json

For cross-platform compiling, we use `CMakePresets.json` (see [ref](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html) 
to share settings.

```cmake
cmake --preset <preset-name>
cmake --build <preset-build-directory> --target <a-target>
```

* `<preset-name>` : name of a configuration preset, [see below](#configuration-presets) for a list.
* `<preset-build-directory>` : build folder. By default and for all configuration
presets, it is set to `out/build/<preset-name>`.
* `<a-target>` : name of a target, [see above](#targets).


### Configuration presets

Here are some configurations provided:

```json
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
```

__NOTE 1__: `Clang-cl` refers to the clang toolchain provided by [Visual Studio 2022](https://learn.microsoft.com/en-us/cpp/build/clang-support-msbuild?view=msvc-170)

Thanks to the structure of the file (credits to [DirectXTK](https://github.com/microsoft/DirectXTK/blob/main/CMakePresets.json)
you can easily add other configurations, by inheritings relevant configurations.

```json
{"name": "x86-release-msvc", "inherits": ["Base", "Ninja", "x86", "MSVC", "Release"]},
```

If you need to specify some cache variables for CMake, you can add them to the `base` configuration :

```json
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
	  }
    },
```

### A warning note

Some configurations may not work if some binaries and libraries are not in your `PATH`. 
For example, by default with Visual Studio 2022, all windows specific configurations works but `GCC`.
Vice-versa, only `GCC` works in CLion but not the others (unless you tweak your path).


## Additional functionality

If you wish, they are some additional functionality that requires a bit more work from you.


### CPM Download location

By default, **[CPM](https://github.com/cpm-cmake/)** download source files in the output directory.
If you have several projects that use the same libraries, it may be favorable to download
them in one place.

**[CPM](https://github.com/cpm-cmake/)** documentation is far more comprehensive, but you can set
the cmake variable `CPM_SOURCE_CACHE` to an adequate location. 
Personally I recommend to set it in your path, rather than in your .cmake files or in your preset.


### CCache

By default and when configured as the main project, if **[CCache](https://ccache.dev/)** is installed, it will be activated.
Otherwise it will be ignored

To install **[CCache](https://ccache.dev/)** on windows, you can use chocolatey (need elevated privileges) like so :
```
choco install ccache
```


### Documentation

__Documentation__ is built with **[Doxygen](https://www.doxygen.nl/)** and **[m.css](https://mcss.mosra.cz/)** from **[Magnum Engine](https://magnum.graphics/)**
Two targets are provided :

* `docs` : utility target to build the documentation
* `open_docs` : utility target to open docs without the hassle of finding it.

> Documentation is only configured when the project is the main project !

Documentation is built through github actions and push in github pages when commiting on master.
If you wish to built it localy, the following tools are needed :
* Doxygen, 
* jinja2 
* Pygments 

#### Instructions

On Ubuntu :

```shell
sudo apt-get install doxygen
pip3 install jinja2 Pygments
```

On MacOs :

```shell
brew install doxygen
pip3 install jinja2 Pygments
```

On windows using chocolatey (need elevated privileges) :

```shell
choco install doxygen.install
choco install python
pip3 install jinja2 Pygments
```

> Make sure to add doxygen to your path !

#### Writing docs

It can be a bit of pain to write cool pages for our documentation, especially when sticking with Doxygen commands. 
I recommend to write `.md` files where you can mix markdown and doxygen commands. You can also add components added
by **[m.css](https://mcss.mosra.cz/)**. However, it is not easy to work out how to use them. So you can find [here]
a reference of some commands you can to your pages.


### Tests

The library used for testing is [Doctest](https://github.com/doctest/doctest).

One target is provided : `tests`.

> Tests are only configured when the project is the main project !


### Benchmarks

The library used for benchmarking is [Google benchmark](https://github.com/google/benchmark).

One target is provided `benchmarks`.

If you want to pass more options to tune the benchmarking, see 
[Google benchmark usage guide](https://github.com/google/benchmark/blob/main/docs/user_guide.md).

Alternitavely, you can use `bin\benchmarks\run_benchmarks.py` python script, to run benchmarks with a predefined set of options.

```
py run_benchmarks.py Benchmarks.exe -n SomeName
```

This line will generate a `.json` file with 'SomeName' in its name. It will also repeat benchmarks 10 times and compute the mean, median, variance, etc.

To compare two benchmarks, you can use the following command :

```
py tools/compare.py benchmarks <baseline> <comparison>
```

Replace `<baseline>` and `<comparison>` with `.json` files obtained when running your benchmarks.


## Credits

* **[Doctest](https://github.com/doctest/doctest)**
* **[m.css](https://mcss.mosra.cz/)** from **[Magnum Engine](https://magnum.graphics/)**
* **[Google Benchmark](https://github.com/google/benchmark)**
* **[CCache](https://ccache.dev/)**
* **[CCache.cmake](https://github.com/TheLartians/Ccache.cmake/)**
