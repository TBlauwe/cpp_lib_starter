# Cpp library starter project

Opitionated adn simple template I use for my libraries and as a learning process.

## Features
* Tests build with **[Doctest](https://github.com/doctest/doctest)**
* Benchmarks build with **[Google Benchmark](https://github.com/google/benchmark)**
* Docs build with Doxygen and **[m.css](https://mcss.mosra.cz/)** from **[Magnum Engine](https://magnum.graphics/)**
* Dependencies downloaded with **[CPM](https://github.com/cpm-cmake/)**.


## Getting started

Download the source code and replace the following identifiers :

* `my_lib` : cmake target, folder name
* `MY_LIB` : cmake project name and cmake variables prefix
* `ml` : namespace, only in source files.

Set `CPM_SOURCE_CACHE` to an adequate location. It is a **[CPM](https://github.com/cpm-cmake/)** options 
that tells it where to download libraries.

Executables location are specified by variable `PROJECT_EXE_DIR` in the main `CMakeLists.txt`. 
By default, it is set to : `${PROJECT_SOURCE_DIR}/bin`.
Note that it is not prefixed by `MY_LIB`. As of now, it is only set when the library is built as the main project.
So I thought it would be nice to follow cmake convention like `PROJECT_SOURCE_DIR`.

## Dependencies

Dependencies are downloaded with **[CPM](https://github.com/cpm-cmake/)**.
This step can be skipped by setting `MY_LIB_SKIP_DEPENDENCIES` to `ON`. By default, it is `OFF` if it is the main
project, `ON` otherwise.

Each dependencies version can be override by setting `CPM_MY_DEP_VERSION` to a git tag, e.g `master`, `v3.12`, `1.0`, etc.

To reduce boilerplates, `cpm/tools.cmake` provide several functions and macros :

* `macro(ADD_VERSION)` is a macro to set an option specifying a third_library version :
```
ADD_VERSION(NAME fmt VERSION "10.0.0")
````

* `macro(DOWNLOAD_LIBRARY)` is a macro wrapping `CPMAddPackage` to use version provided by the corresponding option :
```
DOWNLOAD_LIBRARY(
  NAME fmt
  TARGETS fmt fmt-header-only
  GITHUB_REPOSITORY fmtlib/fmt
  OPTIONS
    "FMT_INSTALL OFF"
)
````

It can mostly be used the same as `CPMAddPackage`. 
By default, it will also try to suppress warnings of targets specified by `TARGETS` or `NAME` if no `TARGETS` are provided.
It can by skipped by specifying `NO_SILENCE_WARNINGS`.

> Sadly, it doesn't work for now ! Trying to work around https://www.foonathan.net/2018/10/cmake-warnings/.

## Verbosity
The cmake output is very verbose. I like to be able to read easily my output. It is displayed according to my taste
But, it will most likely annoy others that just want the relevant information, especially when used as a third-library.
It is less relevant when build as the main project.

For now, I don't provide an option for a less verbose output and I guess `QUIET` can be used when using `FetchContent'.


## Additional targets

Tests, docs and benchmarks adds additional targets. It was choosen to not propose option to build them, as they will
be built only if this is the main project.

## Documentation

Two targets are provided :

* `BuildDocs` uses **[m.css](https://mcss.mosra.cz/)** from **[Magnum Engine](https://magnum.graphics/)** to build the documentation.
* `OpenDocs` is a convenience target to open docs without the hassle of finding it.

The following tools are needed :
* Doxygen, 
* jinja2 
* Pygments 

### Instructions

On MacOs :
```
brew install doxygen
pip3 install jinja2 Pygments
```

On windows using chocolatey (need elevated privileges) :
```
choco install doxygen.install
choco install python
pip3 install jinja2 Pygments
```

> Make sure to add doxygen to your path !

## Tests

The library used for testing is [Doctest](https://github.com/doctest/doctest).


## Benchmarks

The library used for benchmarking is [Google benchmark](https://github.com/google/benchmark).

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
