![C++](https://img.shields.io/badge/c++%2020%20Library-%2300599C.svg?style=for-the-badge&logo=cplusplus&logoColor=white)
![CMake](https://img.shields.io/badge/CMake-%232B2F33.svg?style=for-the-badge&logo=cmake)
[![Version](https://img.shields.io/github/v/release/{{tmplr.owner_name}}/{{tmplr.repo_name}}?include_prereleases&style=for-the-badge)](https://github.com/{{tmplr.owner_name}}/{{tmplr.repo_name}}/releases)
[![MIT](https://img.shields.io/badge/license-TBD-blue.svg?style=for-the-badge)](https://github.com/{{tmplr.owner_name}}/{{tmplr.repo_name}}/blob/master/LICENSE)
[![Documentation link](https://img.shields.io/badge/Docs-blue?logo=readthedocs&logoColor=white&style=for-the-badge)](https://{{tmplr.owner_name}}.github.io/{{tmplr.repo_name}}/)
[![Examples](https://img.shields.io/badge/Examples-darkviolet?&style=for-the-badge)](https://{{tmplr.owner_name}}.github.io/{{tmplr.repo_name}}/examples.html)

![Windows GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/{{tmplr.owner_name}}/{{tmplr.repo_name}}/windows.yaml?style=flat-square&logo=windows10&label=Windows%20(Clang-cl%2C%20MSVC))
![Ubuntu GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/{{tmplr.owner_name}}/{{tmplr.repo_name}}/ubuntu.yaml?style=flat-square&logo=ubuntu&logoColor=white&label=Ubuntu%20(Clang%2C%20GCC))
![MacOS GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/{{tmplr.owner_name}}/{{tmplr.repo_name}}/ubuntu.yaml?style=flat-square&logo=apple&logoColor=white&label=MacOS%20(Clang%2C%20GCC))


{{ tmplr.repo_desc }}


## Features

* 

## Getting started

### Installation

Using **[CPM](https://github.com/cpm-cmake/)**, add the following lines to your cmake file:

```cmake
CPMAddPackage(
  NAME {{tmplr.repo_name}}
  GITHUB_REPOSITORY {{tmplr.owner_name}}/{{ tmplr.repo_name }}
)

target_link_libraries(your_target PUBLIC {{tmplr.repo_name}})
```

### Minimal example

<!--BEGIN_INCLUDE="examples/getting_started.cpp"-->
```cpp
#include <{{tmplr.repo_name}}/core.h>
```
<!--END_INCLUDE-->

