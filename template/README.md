# {{ tmplr.repo_name }}

<div align="center">

[![Windows [Clang-cl & MSVC]](https://github.com/{{tmplr.owner_name}}/{{ tmplr.repo_name }}/actions/workflows/windows.yaml/badge.svg)](https://github.com/{{tmplr.owner_name}}/{{ tmplr.repo_name }}/actions/workflows/windows.yaml)
[![Ubuntu & MacOS [Clang & GCC]](https://github.com/{{tmplr.owner_name}}/{{ tmplr.repo_name }}/actions/workflows/ubuntu.yaml/badge.svg)](https://github.com/{{tmplr.owner_name}}/{{ tmplr.repo_name }}/actions/workflows/ubuntu.yaml)
[![Documentation build & deploy](https://github.com/{{tmplr.owner_name}}/{{ tmplr.repo_name }}/actions/workflows/documentation.yaml/badge.svg)](https://github.com/{{tmplr.owner_name}}/{{ tmplr.repo_name }}/actions/workflows/documentation.yaml)

</br>

[![Static Badge](https://img.shields.io/badge/Documentation-blue?logo=readthedocs&logoColor=white&style=for-the-badge)](https://{{tmplr.owner_name}}.github.io/{{ tmplr.repo_name }}/)

</br>

{{ tmplr.repo_desc }}

</div>


## Features


## Getting started

Using **[CPM](https://github.com/cpm-cmake/)**, add the following lines to your cmake file:

```cmake
CPMAddPackage(
  NAME {{tmplr.repo_name}}
  GITHUB_REPOSITORY {{tmplr.owner_name}}/{{ tmplr.repo_name }}
)

target_link_libraries(your_target PUBLIC {{tmplr.repo_name}})
```

<details>
<summary> CMake options </summary>

| Options | Default | Description |
| ---: | :---: | :--- |
| `{{ tmplr.repo_name | CONSTANT_CASE }}_SKIP_DEPENDENCIES` | `true` in consumer mode, `false` otherwise | Disable automatic dependencies downloading with **[CPM](https://github.com/cpm-cmake/)** |
| `CPM_MY_DEPENDENCY_VERSION` | `true` in consumer mode, `false` otherwise | Override a dependency's version. Value must be a git tag, e.g `master`, `v3.12`, `1.0` |

</details>

In your code : 

```cpp
#include <{{tmplr.repo_name}}/{{tmplr.repo_name}}.h>
```

