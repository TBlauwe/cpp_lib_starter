# Cpp Library Starter

![C++20](https://img.shields.io/badge/c++20-%2300599C.svg?style=for-the-badge&logo=c%2B%2B&logoColor=white) ![CMake](https://img.shields.io/badge/CMake-%23008FBA.svg?style=for-the-badge&logo=cmake&logoColor=white) [![Static Badge](https://img.shields.io/badge/See%20example%20here-blue?style=for-the-badge&logo=readthedocs&logoColor=white)](https://github.com/TBlauwe/CLS_Example/)

<div align="center">

An opinionated template repository for C++20 static library, with an emphasis on quick setup to share library with other projects using **[CPM](https://github.com/cpm-cmake/)**.

</div>


> [!NOTE]
>
> I'm using it as a continuous learning process. Suggestions are always welcome ! 


## Features

* __Quick setup__ : Click `Use this template`, fill a few fields and a project/repository will be generated based on available information.
	* Thanks to **[Tmplr](https://github.com/loreanvictor/tmplr)**, there are no leftover, no replacement needed. For example, a barebone `README.md` is generated, with working links, instructions, etc.


* __Documentation__ generated with **[Doxygen](https://www.doxygen.nl/)** and **[Doxygen Awesome CSS](https://jothepro.github.io/doxygen-awesome-css/)**.

	* __Github Pages__ is automatically setup _(just need to allow deployement from github actions)_
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



* __Tests__ written with **[Catch2](https://github.com/catchorg/Catch2)** and executed during CI. 
    <details>
	<summary>CI Executions</summary>

	|Platform | Toolchains |
	| --- | --- |
	| Windows | msvc & clang-cl |
	| Ubuntu | gcc & clang |
	| MacOS | gcc & clang |

	</details>


* __Benchmarks__ written with **[Google Benchmark](https://github.com/google/benchmark)**.

*  __(WIP) Continuous benchmarks__ done through a two-step process .
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

* _EXPERIMENTAL_. Automatically includes example files in your readme with cmake.


## Getting started

On the [github repository](https://github.com/TBlauwe/cpp_lib_starter), click on `Use this template` and fill the fields

There are two steps left :
1. Allow deployement of Github Pages through github actions
2. [OPTIONAL] - Clean workflow files

### Github Pages
Go to your repository on github and follow these steps : 

1. Click on `Settings`
2. Click on `Pages` in the section `Code and automation`
3. In 'Build and deployement', change `Source` to `GitHub Actions`, instead of `Deploy from a branch`.

Otherwise, GitHub Pages's deployement will always failed.

<details>

<summary>Deploy Github Pages without commiting</summary>

If you wish to deploy the documentation now, you can trigger the workflow from github by following these steps :

1. Click on `Actions`
2. In the left pane, Click on `Documentation build & deploy`
3. To the right, click on `Run workflow`

</details>


### [OPTIONAL] - Clean workflow files

> [!NOTE]
>
> I need to improve the template so this is not necessary. It is a workaround so that the user do not need to create a personal account token.
> They are maybe another way but I haven't found it. Any help is appreciated !

Modifications of workflows file needs additional permissions. Without them, we can't add them during generation. 
But, it seems to require additional steps from the user.
To circumvent that, all workflows files are initially present. 
But we add to alter them slightly, so they can run only when relevant :

1. All workflows should not run in the template repository
```yaml
    if: github.repository != 'TBlauwe/cpp_lib_starter'
```

2. Workflow `init.yaml` should run only once, when there is a `.tmplr.yml`. 
```yaml
        - name: Check file existence
          id: check_files
          uses: andstor/file-existence-action@v2
          with:
            files: '.tmplr.yml'`
```

2. Other workflows should run only when the project is generated, meaning when there is a root `CMakeLists.txt`. 
```yaml
        - name: Check file existence
          id: check_files
          uses: andstor/file-existence-action@v2
          with:
            files: 'CMakeLists.txt'
```

After the generation, you can remove `init.yaml`, as it is not needed anymore, idem for the checks in other workflows. 


<summary>CMake Utilities</summary>

## Build

Use following command in the root directory :

```console
cmake -S . -B build
cmake --build build --target <a-target>
```

Targets available :

| Targets | Type | Description |
| ---: | :---: | :--- |
| `<your_project_name>` | Library | Build main library |
| `tests` | Executable | Build executable to run tests |
| `benchmarks` | Executable | Build executable to run benchmarks |
| `continuous_benchmarking` | Utility | Execute a python script to run benchmarks for continuous benchmarking |
| `docs` | Utility | Build documentation |
| `open_docs` | Utility | Open documentation in default browser |
| `update_code_blocks` | Utility | Update code blocks by replacing its content with the relevant file. |

You can also use `CMakePresets.json` instead, [see below](#cmakepresets.json)


## CMakePresets.json

```console
cmake --preset <preset-name>
cmake --build <preset-build-directory> --target <a-target>
```

* `<preset-name>` : name of a configuration preset, [see below](#configuration-presets) for a list.
* `<preset-build-directory>` : build folder. By default and for all configuration
presets, it is set to `out/build/<preset-name>`.
* `<a-target>` : name of a target, [see above](#targets).

Available presets : 

| Targets | Inherits | Note | 
| ---: | :--- | :--- |
| `x64-debug-msvc`| `Base`, `Ninja`, `x64`, `MSVC`, `Debug`| Windows specific (Visual studio)|
| `x64-release-msvc`| `Base`, `Ninja`, `x64`, `MSVC`, `Release`| Windows specific (Visual studio) |
| `x64-debug-clang-cl`| `Base`, `Ninja`, `x64`, `Clang-cl`, `Debug`| Windows specific (Visual studio) |
| `x64-release-clang-cl`| `Base`, `Ninja`, `x64`, `Clang-cl`, `Release`| Windows specific (Visual studio) |
| `x64-debug-gcc`| `Base`, `Ninja`, `x64`, `GCC`, `Debug`| Windows specific (CLion) |
| `x64-release-gcc`| `Base`, `Ninja`, `x64`, `GCC`, `Release`| Windows specific (Clion) |
| `x64-debug-clang`| `Base`, `Ninja`, `x64`, `Clang`, `Debug`| Unix, MacOs, WSL |
| `x64-release-clang`| `Base`, `Ninja`, `x64`, `Clang`, `Release`| Unix, MacOs, WSL|
| `x64-debug-gnu`| `Base`, `Ninja`, `x64`, `GCC`, `Debug`, `wsl`| Unix, MacOs, WSL |
| `x64-release-gnu`| `Base`, `Ninja`, `x64`, `GCC`, `Release`, `wsl`| Unix, MacOs, WSL|

> [!NOTE]
>
> `Clang-cl` refers to the clang toolchain provided by [Visual Studio 2022](https://learn.microsoft.com/en-us/cpp/build/clang-support-msbuild?view=msvc-170)

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

> [!WARNING]
>
> Some configurations may not work if some binaries and libraries are not in your `PATH`. 
> For example, by default with Visual Studio 2022, all windows specific configurations works but `GCC`.
> Vice-versa, only `GCC` works in CLion but not the others (unless you tweak your path). 


## Additional functionality

If you wish, they are some additional functionality that requires a bit more work from you.


### CPM Download location

By default, **[CPM](https://github.com/cpm-cmake/)** download source files in the output directory.
If you have several projects that use the same libraries, it may be favorable to download them in one place.

**[CPM](https://github.com/cpm-cmake/)** documentation is far more comprehensive, but you can set the cmake variable `CPM_SOURCE_CACHE` to an adequate location. Personally, I recommend to set it in your path, rather than in your .cmake files or in your preset.


### CCache

By default and when configured as the main project, if **[CCache](https://ccache.dev/)** is installed, it will be activated.
Otherwise it will be ignored.

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

> [!WARNING]
>
> Make sure doxygen is in your path !

#### Writing docs

To help you write docs, [this page](https://tblauwe.github.io/cpp_lib_starter/pages/reference.html) is a reference of some commands.


#### Include cpp files inside a markdown file.

Let's start by a use case : You want your main readme.md to include a cpp file to showcase how to get started.
Doxygen won't be able to help us here (unless I'm missing something).

So a simple cmake function defined in `cmake/include_code_block.cmake` will allow you to include any file in a markdown file, without using a template.
Suppose we have a markdown file, called `README.md`, that contains this : 
```html
<!--BEGIN_INCLUDE="examples/00_GettingStarted/main.cpp"-->
'''cpp
#include <{{tmplr.repo_name}}/{{tmplr.repo_name}}.h>
'''
<!--END_INCLUDE-->
```

By running `include_code_block("README.md")`, the content between the two balises will be replaced by the content of the file specified, `examples/00_GettingStarted/main.cpp` in this case.

Now a problem I faced is when to call this function. Ideally only when necessary, but it turned out there are several cases where it needs to be updated, but we don't want to do it at every cmake invocation.
I choose to define a custom target called `update_code_blocks` that you can manually run, or that is automatically run when building docs.


### Tests

The library used for testing is [Catch2](https://github.com/catchorg/Catch2).

One target is provided : `tests`.

> Tests are only configured when the project is the main project !


### Benchmarks

The library used for benchmarking is [Google benchmark](https://github.com/google/benchmark).

One target is provided `benchmarks`.

If you want to pass more options to tune the benchmarking, see [Google benchmark usage guide](https://github.com/google/benchmark/blob/main/docs/user_guide.md).


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
* **[Catch2](https://github.com/catchorg/Catch2)**

_Documentation_:
* **[Doxygen](https://www.doxygen.nl/index.html)**
* **[Doxygen Awesome CSS](https://jothepro.github.io/doxygen-awesome-css/)**

_Utility_:
* **[Tmplr](https://github.com/loreanvictor/tmplr)**


## Ressources used

These are the main ressources I used to organize CMake files:

* ["Modern CMake" by CliUtils](https://cliutils.gitlab.io/modern-cmake/)
* ["Deep CMake For Library Authors" by Craig Scott](https://crascit.com/2019/10/16/cppcon-2019-deep-cmake-for-library-authors/)
* ["cmake-init" by FriendlyAnon](https://github.com/friendlyanon/cmake-init)


## TODOs

* [x] - Support shared library
* [ ] - Semantic versionning from Github
* [ ] - Release/publish action
* [ ] - Add interactive charts for continuous benchmarking
* [ ] - Add section for continuous benchmarking
* [ ] - Install rules needs testing
* [ ] - Simplify download_library / remove use_version / Rename to add mark_include_system
