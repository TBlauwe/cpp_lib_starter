# Cpp Library Starter

[![Windows [Clang-cl & MSVC]](https://github.com/TBlauwe/cpp_lib_starter/actions/workflows/windows.yaml/badge.svg)](https://github.com/TBlauwe/cpp_lib_starter/actions/workflows/windows.yaml)
[![Ubuntu & MacOS [Clang & GCC]](https://github.com/TBlauwe/cpp_lib_starter/actions/workflows/ubuntu.yaml/badge.svg)](https://github.com/TBlauwe/cpp_lib_starter/actions/workflows/ubuntu.yaml)
[![Documentation build & deploy](https://github.com/TBlauwe/cpp_lib_starter/actions/workflows/documentation.yaml/badge.svg)](https://github.com/TBlauwe/cpp_lib_starter/actions/workflows/documentation.yaml)

<center>

[![Static Badge](https://img.shields.io/badge/Documentation-blue?logo=readthedocs&logoColor=white&style=for-the-badge)](https://tblauwe.github.io/cpp_lib_starter/)
An opinionated template repository for C++20 static library, with an emphasis on quick setup to share library with other projects using **[CPM](https://github.com/cpm-cmake/)**.

</center>

</br>


> [!NOTE]
>
> I'm using it as a continuous learning process. Suggestions are always welcome ! 


## Features

* __Quick setup__ : Click `Use this template`, fill a few fields and a project/repository will be generated based on available information.
	* Thanks to **[Tmplr](https://github.com/loreanvictor/tmplr)**, there are no leftover, no replacement needed. For example, a barebone `README.md` is generated, with working links, instructions, etc.


* __Documentation__ generated with **[Doxygen](https://www.doxygen.nl/)** and **[Doxygen Awesome CSS](https://jothepro.github.io/doxygen-awesome-css/)**.

	* __Github Pages__ is automatically setup. 
	* Documentation is built during CI and pushed to github pages

* __Dependencies__ downloaded with **[CPM](https://github.com/cpm-cmake/)**. 

    <details>
	<summary>Project generated from this template are also CPM-ready</summary>

	```cmake
	CPMAddPackage(
		NAME my_lib 
		GITHUB_REPOSITORY my_lib_repo/my_lib
	)

	target_link_libraries(some_target PUBLIC my_lib)
	```
	</details>



* __Tests__ written with **[Doctest](https://github.com/doctest/doctest)** and executed during CI. 
    <details>
	<summary>CI Executions</summary>

	|Platform | Toolchains |
	| --- | --- |
	| Windows | msvc & clang-cl |
	| Ubuntu | gcc & clang |
	| MacOS | gcc & clang |

	</details>


* __Benchmarks__ written with **[Google Benchmark](https://github.com/google/benchmark)**.

* __Continuous benchmarks__ done through a two-step process.
    <details>
	<summary>Execute and store benchmarks results.</summary>

	This step is __partially automated__. It was chosen to not automatically run them in CI to ensure consistent results over time (at least when it comes to github actions).
	
	Therefore, a cmake utility target, called "run_benchmarks" is available to automate this step.
    It will run benchmarks with some predefined settings and store the result in `benchmarks/data/...`. 
	</details>

	*  __Automated generation__ of various widgets (charts, tables) to showcase your benchmarks, using **[BenchDocs](https://github.com/TBlauwe/bench_docs)**. They are also automatically integrated in your documentation.
	

* __Robust and subjectively clear__ CMake files. 
	* They should work on Windows, Linux, using WSL or not, by command-line or with an IDE like Visual Studio or Clion.

* __Verbose when needed.__  CMake's output is only verbose when built as the main project, but concise when consumed.

* A __Cross-platform__ and __modular__ _CMakePreset.json_  provided.

* __Cross-compiler warnings__ enabled through CMake. 

* __Minimal CMake options__ used. Default values should be good enough, but options are provided just in case.


## Getting started

Go to the [github repository](https://github.com/TBlauwe/cpp_lib_starter) and click on `Use this template`

Once the setup is done, replace the following identifiers.

* `my_lib` : cmake target, folder name
* `MY_LIB` : cmake project name and cmake variables prefix
* `my_namespace` : namespace, only in source files.
* `my_lib_source` : in `src/`
* `my_lib_header` : in `include/my_lib`

If you wish to reuse parts of the `README.md`, make sure to also replace :
* `TBlauwe/cpp_lib_starter` with your github repository (so badges are linked to correct workflows).
* `https://tblauwe.github.io/cpp_lib_starter/` with your github pages link (so `Documentation link` badges redirects to your site).

Also, in the root `CMakeLists.txt`, make sure to replace project information to yours.
They will be used for the generated documentation.

```cmake
# ----- Project information
project(MY_LIB
	VERSION 0.1.0
	DESCRIPTION "Repository template for C++ projects"
	HOMEPAGE_URL "https://github.com/TBlauwe/cpp_lib_starter"
	LANGUAGES C CXX
)
```

It should be safe to do a "Replace All". Still, make sure that `#include <my_lib/my_lib_header.hpp>` are correctly replaced.

That should be it for building the main target, tests and benchmarks. Documentation requires a bit more installation user-side.

You also probably don't need `docs/pages/reference.md`. 


## CMake options

The following CMake options are available:

* `MY_LIB_SKIP_DEPENDENCIES` : Disable automatic dependencies downloading with **[CPM](https://github.com/cpm-cmake/)** 
	* By default, if consumed it is set to `true`, `false` otherwise.
* `CPM_MY_DEPENDENCY_VERSION` : Specify a dependency version. It is not something added by **[CPM](https://github.com/cpm-cmake/)** but by me. 
It adds an option for overriding the version of a dependency. The value is a git tag, e.g `master`, `v3.12`, `1.0`, etc.

Executables location are specified by variable `${PROJECT_EXE_DIR}` in the main `CMakeLists.txt`. 
By default, it is set to : `${PROJECT_SOURCE_DIR}/bin`.
Note that it is not prefixed by `MY_LIB`. As of now, it is only set when the library is built as the main project.
So I thought it would be nice to follow cmake convention like `${PROJECT_SOURCE_DIR}`.


## CMake utilities

Inside `cmake/utility.cmake`, you will find several functions and macros. Most aren't noteworthy. They are mainly used 
to organise and build prettier output. They are by no means necessary. If you don't like them, feel free to skip them.

Still, here are some noteworthy functions/macros. 

### Macro: use_version

Define an option to set the version for a library.

Usage : 

```cmake
use_version(NAME fmt VERSION "10.0.0")
```

This will add a cmake option `CPM_FMT_VERSION` set to `10.0.0`. It will then be used by the following macro :


### Macro: download_library

Download a library using CPM. It is a wrapper of `CPMAddPackage` and used the same. The reason to add 
this wrapper is to play nicely with options/version added through `use_version` and also with cmake output.

Usage : 

```cmake
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

```cmake
download_library(
  NAME fmt
  GITHUB_REPOSITORY fmtlib/fmt
  OPTIONS
    "FMT_INSTALL OFF"
  NO_SUPPRESS_WARNINGS 
)
```

## Build


```bash
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
* `run_benchmarks` : run benchmarks through a python script
* `docs` : docs

## CMakePresets.json

For cross-platform compiling, we use `CMakePresets.json` (see [ref](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html)) to share settings.

```console
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

Thanks to the structure of the file (credits to [DirectXTK](https://github.com/microsoft/DirectXTK/blob/main/CMakePresets.json)), you can easily add other configurations, by inheritings relevant configurations.

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
If you have several projects that use the same libraries, it may be favorable to download them in one place.

**[CPM](https://github.com/cpm-cmake/)** documentation is far more comprehensive, but you can set the cmake variable `CPM_SOURCE_CACHE` to an adequate location. Personally, I recommend to set it in your path, rather than in your .cmake files or in your preset.


### CCache

By default and when configured as the main project, if **[CCache](https://ccache.dev/)** is installed, it will be activated.
Otherwise it will be ignored

To install **[CCache](https://ccache.dev/)** on windows, you can use chocolatey (need elevated privileges) like so :

```bash
choco install ccache
```


### Documentation

__Documentation__ is built with **[Doxygen](https://www.doxygen.nl/)** and **[Doxygen Awesome CSS](https://jothepro.github.io/doxygen-awesome-css/)**

* `docs` : utility target to build the documentation
* `open_docs` : utility target to open docs without the hassle of finding it.

> Documentation is only built when the project is the main project !

Documentation is built through github actions and push in github pages when commiting on master. You don't need to setup your github pages, it's done automatically.
If you wish to built it localy, the following tools are needed :
* **[Doxygen](https://www.doxygen.nl/)**, 1.9.6+ recommended.


#### Instructions

On Ubuntu :

```sh
sudo apt-get install doxygen
sudo apt-get install graphviz
```

On MacOs :

```sh
brew install doxygen
brew install graphviz
```

On windows using chocolatey (need elevated privileges) :

```sh
choco install doxygen.install
choco install graphviz
```

> Make sure to add doxygen to your path !

#### Writing docs

To help you write docs, [this page](https://tblauwe.github.io/cpp_lib_starter/pages/reference.html) is a reference of some commands.


### Tests

The library used for testing is [Doctest](https://github.com/doctest/doctest).

One target is provided : `tests`.

> Tests are only configured when the project is the main project !


### Benchmarks

The library used for benchmarking is [Google benchmark](https://github.com/google/benchmark).

One target is provided `benchmarks`.

If you want to pass more options to tune the benchmarking, see 
[Google benchmark usage guide](https://github.com/google/benchmark/blob/main/docs/user_guide.md).

#### Running benchmarks

You can use provided `run_benchmarks.py` python script, to run benchmarks with a predefined set of options.

```console
py run_benchmarks.py 
```

Launch with `-h`, if you need to see available arguments.

By default, benchmarks' results will be outputted to a file with following name :

```console
@PROJECT_NAME@_@PROJECT_VERSION@_@CMAKE_BUILD_TYPE@_@CMAKE_CXX_COMPILER_ID@_%Y-%m-%d_%H-%M
```

For example :

```console
mylib_0.1.0_debug_clang_2023-08-02_20-12.json
```

You can specify the name with option `-n` or `--name` :

```console
py run_benchmarks.py -n MyName
```

The goal is to be able to store results in the long run to compare evolution of
performance.

#### Comparing benchmarks

To compare two benchmarks, you can use the following command :

```console
py benchmarks_tools/compare.py benchmarks <baseline> <comparison>
```

Replace `<baseline>` and `<comparison>` with `.json` files obtained when running your benchmarks.

To use this tools, requirement must be installed :

```console
cd benchmarks_tools
pip3 install -r requirements.txt
```



## Credits

_CMake_:
* **[cmake-init](https://github.com/friendlyanon/cmake-init)**
* **[CCache](https://ccache.dev/)**

_Benchmarks_:
* **[Google Benchmark](https://github.com/google/benchmark)**

_Tests_:
* **[Doctest](https://github.com/doctest/doctest)**

_Documentation_:
* **[Doxygen](https://www.doxygen.nl/index.html)**
* **[Doxygen Awesome CSS](https://jothepro.github.io/doxygen-awesome-css/)**
* **[Plotly](https://plotly.com/graphing-libraries/)**

_Utility_:
* **[Tmplr](https://github.com/loreanvictor/tmplr)**

## Ressources used

These are the main ressources I used to organize CMake files:

* ["Modern CMake" by CliUtils](https://cliutils.gitlab.io/modern-cmake/)
* ["Deep CMake For Library Authors" by Craig Scott](https://crascit.com/2019/10/16/cppcon-2019-deep-cmake-for-library-authors/)
* ["cmake-init" by FriendlyAnon](https://github.com/friendlyanon/cmake-init)


## TODOs

* [x] - Support shared library
* [ ] - Add interactive charts for continuous benchmarking
* [ ] - Install rules needs testing
