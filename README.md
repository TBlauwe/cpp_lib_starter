# Cpp library starter project

Usual template I use for my libraries and as a learning process.


## Getting started

Clone the repo :

```
git clone https://github.com/TBlauwe/cpp_lib_starter.git
```

Each target will automatically install dependencies via [CPM](https://github.com/cpm-cmake/).
However, some dependencies needs to be downloaded manually (for some targets).

Executables location are specified by variable `PROJECT_EXE_DIR` in the main `CMakeLists.txt`. 
By default, it is set to : `${PROJECT_SOURCE_DIR}/bin`.

* Replace `MY_PROJECT` in `CMakeLists.txt`
* Replace `my_project` in `CMakeLists.txt`, all sources files and folders (in `include/`)
* Set `CPM_SOURCE_CACHE` to an adequate location.


## Documentation

Two targets are provided :

* BuildDocs
* OpenDocs

`OpenDocs` is a convenience target to open docs without the hassle of finding it.
`BuildDocs` uses **[m.css](https://mcss.mosra.cz/)** from **[Magnum Engine](https://magnum.graphics/)** to build the documentation.
It requires the following tools :
* Doxygen, 
* jinja2 
* Pygments 

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
