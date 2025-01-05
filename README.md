# Cpp Library Starter

![C++](https://img.shields.io/badge/c++-%2300599C.svg?style=for-the-badge&logo=c%2B%2B&logoColor=white) ![CMake](https://img.shields.io/badge/CMake-%23008FBA.svg?style=for-the-badge&logo=cmake&logoColor=white) [![Static Badge](https://img.shields.io/badge/See%20example%20here-blue?style=for-the-badge&logo=readthedocs&logoColor=white)](https://github.com/TBlauwe/CLS_Example/)


An opinionated template repository for C++ library using **[TCM](https://github.com/TBlauwe/tcm)**.


> [!NOTE]
>
> I'm using it as a continuous learning process. Suggestions are always welcome ! 


## Main Features

* __Quick setup__ :
  * Click `Use this template`, fill a few fields and a project/repository will be generated based on available information.
  * Thanks to **[Tmplr](https://github.com/loreanvictor/tmplr)**, there are no leftover, no replacement needed. For example, a barebone `README.md` is generated, with working links, instructions, etc.
 
* CI ready:
  * Documentation is published to GitHub pages.
  * Build is tested against several configurations.
	<details>
	<summary>CI Executions</summary>

	|Platform | Toolchains |
		| --- | --- |
	| Windows | msvc & clang-cl |
	| Ubuntu | gcc & clang |
	| MacOS | gcc & clang |
	</details>

* __Use TCM__ :
  * __[TCM](https://github.com/TBlauwe/tcm)__ is a CMake module to reduce boilerplate :
    * __Documentation__ generated with **[Doxygen](https://www.doxygen.nl/)** and **[Doxygen Awesome CSS](https://jothepro.github.io/doxygen-awesome-css/)**.
	* Setup tools like **[CPM](https://github.com/cpm-cmake/)** to manage dependencies.
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
    * __Benchmarks__ written with **[Google Benchmark](https://github.com/google/benchmark)**.

* A __Cross-platform__ and __modular__ _CMakePreset.json_  provided.


## Getting started

On the [GitHub repository](https://github.com/TBlauwe/cpp_lib_starter), click on `Use this template` and fill the fields

There are two steps left :
1. Allow deployment of GitHub Pages through GitHub actions
2. [OPTIONAL] - Clean workflow files


### Set up GitHub Pages
Go to your repository and follow these steps : 

1. Click on `Settings`
2. Click on `Pages` in the section `Code and automation`
3. In 'Build and deployment', change `Source` to `GitHub Actions`, instead of `Deploy from a branch`.

Otherwise, GitHub Pages' deployment will always failed.

<details>

<summary>Deploy GitHub Pages without commiting</summary>

If you wish to deploy the documentation now, you can trigger the workflow from GitHub by following these steps :

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

2. Delete `.github/workflows/init.yaml` (after the project is generated.)

3. Other workflows should run only when the project is generated, meaning when there is a root `CMakeLists.txt`. 
```yaml
        - name: Check file existence
          id: check_files
          uses: andstor/file-existence-action@v2
          with:
            files: 'CMakeLists.txt'
```


## Build

Use following command in the root directory :

```console
cmake -S . -B build
cmake --build build --target <a-target>
```

Targets available :

|                                  Targets | Type | Description |
|-----------------------------------------:| :---: | :--- |
|                    `<your_project_name>` | Library | Build main library |
|              `<your_project_name>_Tests` | Executable | Build executable to run tests |
|         `<your_project_name>_Benchmarks` | Executable | Build executable to run benchmarks |
|      `<your_project_name>_Documentation` | Utility | Build documentation |
| `<your_project_name>_Documentation_Open` | Utility | Open documentation in default browser |

You can also use `CMakePresets.json` instead, [see below](#cmakepresets.json)


## CMakePresets.json

```console
cmake --preset <preset-name>
cmake --build <preset-build-directory> --target <a-target>
```

* `<preset-name>` : name of a configuration preset, [see below](#configuration-presets) for a list.
* `<preset-build-directory>` : build folder. By default, it is set to `out/build/<preset-name>`.
* `<a-target>` : name of a target, [see above](#targets).

Available presets : 

|                Targets | Inherits | Note | 
|-----------------------:| :--- | :--- |
|       `x64-msvc-debug` | `Base`, `Ninja`, `x64`, `MSVC`, `Debug`| Windows specific (Visual studio)|
|     `x64-msvc-release` | `Base`, `Ninja`, `x64`, `MSVC`, `Release`| Windows specific (Visual studio) |
|   `x64-clang-cl-debug` | `Base`, `Ninja`, `x64`, `Clang-cl`, `Debug`| Windows specific (Visual studio) |
| `x64-clang-cl-release` | `Base`, `Ninja`, `x64`, `Clang-cl`, `Release`| Windows specific (Visual studio) |
|        `x64-gcc-debug` | `Base`, `Ninja`, `x64`, `GCC`, `Debug`| Windows specific (CLion) |
|      `x64-gcc-release` | `Base`, `Ninja`, `x64`, `GCC`, `Release`| Windows specific (Clion) |
|      `x64-clang-debug` | `Base`, `Ninja`, `x64`, `Clang`, `Debug`| Unix, MacOs, WSL |
|    `x64-clang-release` | `Base`, `Ninja`, `x64`, `Clang`, `Release`| Unix, MacOs, WSL|
|        `x64-gnu-debug` | `Base`, `Ninja`, `x64`, `GCC`, `Debug`, `wsl`| Unix, MacOs, WSL |
|      `x64-gnu-release` | `Base`, `Ninja`, `x64`, `GCC`, `Release`, `wsl`| Unix, MacOs, WSL|

> [!NOTE]
>
> `Clang-cl` refers to the clang toolchain provided by [Visual Studio 2022](https://learn.microsoft.com/en-us/cpp/build/clang-support-msbuild?view=msvc-170)

Thanks to the structure of the file (credits to [DirectXTK](https://github.com/microsoft/DirectXTK/blob/main/CMakePresets.json)), you can easily add other configurations, by inheriting relevant configurations.

```json
{"name": "x86-msvc-release", "inherits": ["Base", "Ninja", "x86", "MSVC", "Release"]},
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
> Vice versa, only `GCC` works in CLion but not the others (unless you tweak your path). 


## Additional functionality

If you wish, they are some additional functionality that requires a bit more work from you.


### CPM Download location

By default, **[CPM](https://github.com/cpm-cmake/)** download source files in the output directory.
If you have several projects that use the same libraries, it may be favorable to download them in one place.

**[CPM](https://github.com/cpm-cmake/)** documentation is far more comprehensive, but you can set the cmake variable `CPM_SOURCE_CACHE` to an adequate location.
Personally, I recommend to set it in your path, rather than in your .cmake files or in your preset.


### CCache

By default and when configured as the main project, if **[CCache](https://ccache.dev/)** is installed, it will be activated.
Otherwise it will be ignored.

To install **[CCache](https://ccache.dev/)** on windows, you can use chocolatey (need elevated privileges) like so :

```bash
choco install ccache
```


### Documentation

__Documentation__ is built with **[Doxygen](https://www.doxygen.nl/)** and **[Doxygen Awesome CSS](https://jothepro.github.io/doxygen-awesome-css/)**

> Documentation is only built when the project is the main project !

Documentation is built through GitHub actions and deploy it through GitHub pages when commiting on master. 
If you wish to built it locally, the following tools are needed :
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

### Tests

The library used for testing is [Catch2](https://github.com/catchorg/Catch2).

> Tests are only configured when the project is the main project !


### Benchmarks

The library used for benchmarking is [Google benchmark](https://github.com/google/benchmark).

> Benchmarks are only configured when the project is the main project !

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


## TODOs

* [x] Support shared library
* [ ] Semantic versionning from Github
* [ ] Release/publish action
* [ ] Add interactive charts for continuous benchmarking
* [ ] Add section for continuous benchmarking
* [ ] Install rules needs testing
