monome-rack-metamodule
==========

Work in progress port of [monome-rack](https://github.com/dewb/monome-rack) to the [MetaModule](https://metamodule.info). This doesn't do anything useful yet.

### Prerequisites
- [Visual Studio Code](https://code.visualstudio.com/) or [Codium](https://vscodium.com/)
- VS Code extensions (recommended but not required):
   - Dev Containers
   - C/C++
   - CMake Tools

### Building in a dev container

This repo includes a [Dev Containers](https://containers.dev/) setup and VS Code tasks to build the firmware and the simulator in a Ubuntu container with all prerequistes taken care of. To use this mode, install the Dev Containers extension and run the command `Dev Containers: Reopen in Container`. 

The container cannot run and debug the graphical simulator, however.

### Building and running on the host

Building the firmware on the host requires the [`metamodule-sdk` plugin prerequisites](https://github.com/4ms/metamodule-plugin-sdk?tab=readme-ov-file#requirements) already installed in the host environment (e.g. [`metamodule-sdk`](https://github.com/4ms/metamodule) repo in parent directory, CMake, ninja, python, GCC arm-none-eabi 12.3 on the path.) 

Building and running the simulator requires the [`metamodule` simulator prerequisites](https://github.com/4ms/metamodule/blob/main/docs/Setup.md) already installed in the host environment (e.g. [`metamodule`](https://github.com/4ms/metamodule) repo in parent directory, CMake, ninja, SDL2 installed.) You will also need to add the following lines to the **top** of metamodule/simulator/ext-plugins.cmake:

```sh
list(APPEND ext_builtin_brand_paths "${CMAKE_CURRENT_LIST_DIR}/../../monome-rack-metamodule")
list(APPEND ext_builtin_brand_libname "MonomeMM")
list(APPEND ext_builtin_brand_slug "monome")
```

If you have opened the project in a dev container and want to return to host development, run the command `Dev Containers: Reopen Folder Locally`.