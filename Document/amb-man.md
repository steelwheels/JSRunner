

# Name
*jsh* - JavaScript Shell

This document describes how to use the `jsh` application.
The syntax of this script is described in [jsh programming language](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-lang.md).
See [samples](https://github.com/steelwheels/JSTools/blob/master/Document/samples/sample.md) for some sample scripts.

# Synopsis
````
jsh [options] script0.js script1.js ... scriptN.js [-- argument0 ... argumentM]
jsh [options] package.jspkg [-- argument0 ... argumentM]
jsh [options]
````
* options:  command line options for `jsh` command
* script:   JavaScript files to be executed
* package:  JavaScript package to be executed. For more details, see [JavaScrip package](https://github.com/steelwheels/JSTools/blob/master/Document/jspkg.md).
* argument: Arguments to be passed as a parameter of the `main` function.

# Description
The *jsh* is command line application to execute JavaScript program.

The following options are available:

|Short  |Long       |argument |Description            |
|:---   |:---       |:---      |:---                   |
|-h     |--help     |-         |Print help message     |
|       |--version  |-         |Print version information |
|       |--no-strict |-        |Do not use `strict` mode (If you don't give this option, the mode is set before compiling any scripts.)|
|       |--use-main |-         |Call main function in the script after evaluating scripts. |
|-i     |--interactive |-      | Set interactive mode. The user can input statements step by step. The interactive mode will be activated after reading all scripts.|
|-c     |--compile  |-         |Dump the source scripts instead of executing it. If the script is written in [JSH](https://github.com/steelwheels/JSTools/blob/master/Document/jsh-lang.md), it is converted into JavaScript and dumped. When you use this compile option, at least one JavaScript file must be given.|
|       |--log      |string     |Define debug log level. The default level is *normal*. Select 1 item from following levels: "normal", "flow", "detail" |
|       |--         |-          |The arguments follows this will be passed as arguments for JavaScript code. |

By using `--` option, you can pass arguments to be referenced by the JavaScript code.
If you don't give any script file names, the `jsh` boots with interactive mode.

# Main function
When the `--use-main` option is given, the function named *main* is called (if it exists).
````
main(arguments: Array<String>) -> Int32
````
The `arguments` are defined by the command line arguments after `--` option.

# Interactive mode
The last symbol of the prompt string presents the *input mode*.
It defines the kind of default script at the command line.

|Symbol |Mode named             |Acceptable script      |
|:---   |:---                   |:---                   |
|`>`    |Shell script mode      |Shell script           |
|`%`    |JavaScript mode        |JavaScript             |

For example, the prompt `jsh>` presents shell script mode, `jsh%` is JavaScript mode. You can use `>` or `%` prefix to select mode manually.
````
jsh% > echo "Hello"
jsh> % let a = 10 ;
````
You can switch the mode. When you press `>` and enter key, the mode is switched into shell script mode. The `%` is used for JavaScript mode.

# Built-in shell commands
|command                |Description                            |
|:--                    |:--                                    |
|[cd](https://github.com/steelwheels/JSTools/tree/master/Document/builtins/cd-man.md)            |Change current directory               |
|[fonts](https://github.com/steelwheels/JSTools/tree/master/Document/builtins/fonts-man.md)      |Print list of fonts                    |
|[getenv](https://github.com/steelwheels/JSTools/tree/master/Document/builtins/getenv-man.md)    |Print the value of environment variable by it's name |
|[history](https://github.com/steelwheels/JSTools/tree/master/Document/builtins/history-man.md)  |Print the commands that already executed.      |
|[run](https://github.com/steelwheels/JSTools/tree/master/Document/builtins/run-man.md)          |Execute script                         |
|[setenv](https://github.com/steelwheels/JSTools/tree/master/Document/builtins/setenv-man.md)    |Set environment value by it's name and value |
|[install](https://github.com/steelwheels/JSTools/tree/master/Document/builtins/install-man.md)    |Install built-in resource files |


# File System
See the source reference
[File System Basics](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html) published by Apple.

## Kind of directories
* [Home Directory](#User): The directory prepared for each user's
* [Application Directory](#Application):  The directory used as an application resource.

## Home Directory
There are following directories under the home directory. In usually this directory is put on `~/Library/Containers/<Application>/Data`.
* `Documents/Script`: The directory to put sample scripts
* `Library`: The files provided by the application. The user can not touch here.
* `tmp`: Temporary directory

## Application Directory
The application resource is put in application or framework directory:
`~/Library/Frameworks/<Framework>.framework/Resource`.

## Reference
* [JSTools](https://github.com/steelwheels/JSTools/blob/master/README.md): Command line JavaScript shell.
* [JSTerminal](https://github.com/steelwheels/JSTerminal/blob/master/README.md): Terminal application to execute JavaScript shell.
* [Steel Wheels Project](https://steelwheels.github.io): Project web site


# Related document
* [README.md](https://github.com/steelwheels/JSRunner/blob/master/README.md): Top level document of this application.
* [Environment variables](https://github.com/steelwheels/JSTools/blob/master/Document/env-var.md): Pre-defined environment variables
* [Steel Wheels Project](http://steelwheels.github.io): Web site of developer.
