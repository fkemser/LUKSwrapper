<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
<!-- [![LinkedIn][linkedin-shield]][linkedin-url] -->



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <!-- <a href="https://github.com/fkemser/SHtemplate">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a> -->

<h3 align="center">SHtemplate</h3>

  <p align="center">
    A template repository for POSIX-/Bourne-Shell(sh) projects.
    <br />
    <a href="https://github.com/fkemser/SHtemplate"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/fkemser/SHtemplate">View Demo</a>
    ·
    <a href="https://github.com/fkemser/SHtemplate/issues">Report Bug</a>
    ·
    <a href="https://github.com/fkemser/SHtemplate/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#testing-environment">Testing Environment</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li>
          <a href="#prerequisites">Prerequisites</a>
          <ul>
            <li><a href="#debian">Debian</a></li>
          </ul>
        </li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#customization">Customization</a></li>
      </ul>
    </li>
    <li>
      <a href="#template-structure">Template Structure</a>
      <ul>
        <li><a href="#overview">Overview</a></li>
        <li><a href="#etcruncfgsh">/etc/run.cfg.sh</a></li>
        <li><a href="#lib">/lib/...</a></li>
        <li><a href="#srcinitsh">/src/init.sh</a></li>
        <li><a href="#srclangaboutlangsh-repository-about-file">/src/lang/about.lang.sh</a></li>
      </ul>
    </li>
    <li><a href="#srclangrunlangsh-repository-string-constants-files">/src/lang/run.<...>.lang.sh (Repository String Constants Files)</a></li>
    <li>
      <a href="#srcrunsh-repository-run-file">/src/run.sh (Repository Run File)</a>
      <ul>
        <li><a href="#modes">Modes</a></li>
        <li><a href="#actions">Actions</a></li>
        <li><a href="#constants">Constants</a></li>
        <li><a href="#variables">Variables</a></li>
        <li>
          <a href="#functions">Functions</a>
          <ul>
            <li><a href="#args_check">args_check()</a></li>
            <li><a href="#args_read">args_read()</a></li>
            <li><a href="#help">help()</a></li>
            <li><a href="#help_synopsis">help_synopsis()</a></li>
            <li><a href="#init_check_pre">init_check_pre()</a></li>
            <li><a href="#init_check_post">init_check_post()</a></li>
            <li><a href="#init_first">init_first()</a></li>
            <li><a href="#init_lang">init_lang()</a></li>
            <li><a href="#init_update">init_update()</a></li>
            <li><a href="#main">main()</a></li>
            <li><a href="#main_daemon">main_daemon()</a></li>
            <li><a href="#main_interactive">main_interactive()</a></li>
            <li><a href="#main_script">main_script()</a></li>
            <li><a href="#menu_main">menu_main()</a></li>
            <li><a href="#msg">msg()</a></li>
            <li><a href="#run">run()</a></li>
            <li><a href="#trap_main">trap_main()</a></li>
          </ul>
        </li>
        <li>
          <a href="#additional-sample-code">Additional Sample Code</a>
          <ul>
            <li><a href="#sample-parameters-and-constants">Sample Parameters and Constants</a></li>
            <li><a href="#sample-actions">Sample Actions</a></li>
            <li><a href="#sample-functions">Sample Functions</a></li>
            <li><a href="#daemon-mode-sample">Daemon Mode Sample</a></li>
          </ul>
        </li>
      </ul>
    </li>
    <li><a href="#adding-support-for-other-languages">Adding support for other languages</a></li>
    <li><a href="#further-code-samples">Further Code Samples</a></li>
    <li><a href="#usage-example">Usage (Example)</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This is a (mostly) **POSIX-/Bourne-Shell(sh)-compliant** repository template that provides boilerplates for

* **checking requirements**, e.g. commands, (running) services, superuser rights, etc.  

  ![Screenshot 11][screenshot11]

* **checking and parsing arguments**  

  ![Screenshot 21][screenshot21]

* generating **well-formatted help (`-h|--help`) messages**  

  ![Screenshot 31][screenshot31]

* **interactive** (`dialog`-based) menus  

  ![Screenshot 41][screenshot41]

* **multi-language support** in terminal and/or `dialog` messages where the system's current language is automatically detected  

  ![Screenshot 51][screenshot51]![Screenshot 52][screenshot52]

* defining **trap handlers**, e.g. for cleanup operations on exit  

  ![Screenshot 61][screenshot61]

* **PID based locking** ensuring that only one instance runs at a time  

  ![Screenshot 71][screenshot71]

* **daemon mode (with sample code for parallel file processing)**  

  ![Screenshot 81][screenshot81]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

[![Shell Script][Shell Script-shield]][Shell Script-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Testing Environment

The project has been developed and tested on the following system:

| Info | Description
---: | ---
OS | Debian GNU/Linux 12 (bookworm)
Kernel | 5.15.133.1-microsoft-standard-WSL2
Packages | [coreutils (9.1-1)](https://packages.debian.org/bookworm/coreutils)
|| [dash (0.5.12-2)](https://packages.debian.org/bookworm/dash)
|| [dialog (1.3-20230209-1)](https://packages.debian.org/bookworm/dialog)
|| [libc-bin (2.36-9+deb12u3)](https://packages.debian.org/bookworm/libc-bin)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started
### Prerequisites
Please make sure that the following dependencies are installed:

* a POSIX-compatible shell, e.g. [Debian Almquist Shell (dash)](http://gondor.apana.org.au/~herbert/dash/), and
* [Dialog](https://invisible-island.net/dialog/dialog.html), a tool to provide interactive dialogue boxes within terminals.

Below you can find distribution-specific installation instructions.

#### Alpine Linux
```sh
sudo apk add coreutils dialog
```

#### Debian
```sh
sudo apt install coreutils dash dialog libc-bin
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Installation
1. Clone the repo
	```sh
   git clone --recurse-submodules https://github.com/fkemser/SHtemplate.git
   ```

2. Open the repository with your favourite code editor. Search and replace the following placeholders (including `<>`) in **all** files:

  > :exclamation: The placeholders highlighted in **bold** are mandatory and must not be empty.

  | <...>                   | Description                                                                  | Example                                                            |
  |-------------------------|------------------------------------------------------------------------------|--------------------------------------------------------------------|
  | **<ABOUT_AUTHORS>**     | Author name and mail address (multiple authors separated by newline)         | John Doe (john.doe@example.com)<br>Jane Doe (jane.doe@example.com) |
  | **<ABOUT_DESCRIPTION>** | One-line description of what the project is about. Please start with a low letter and leave the terminating  '.' out. | a script based on `SHtemplate` used to ... |
  | <ABOUT_INSTITUTION>     | Institution (multiple lines allowed)                                         | Example Inc.<br>123 Main Street<br>Anytown, CA 12345<br>USA        |
  | <ABOUT_LICENSE>         | Project license (SPDX-License-Identifier) [^1]                               | GPL-3.0-or-later                                                   |
  | <ABOUT_LOGO>            | ASCII logo to display when running the script in interactive (`dialog`) mode | -                                                                  |
  | **<ABOUT_PROJECT>**     | Project/Repository title                                                     | My Project                                                         |
  | <ABOUT_VERSION>         | Release/Version number                                                       | 1.0.0                                                              |
  | **<ABOUT_YEARS>**       | Project year(s)                                                              | 2023-2024                                                          |

  [^1]: For the full SPDX license list please have a look at 'https://spdx.org/licenses/'. However, only some licenses are supported so far, see `/lib/SHtemplateLIB/lib/licenses` folder. If you are not sure which license to choose just have a look at e.g. 'https://choosealicense.com'.

3. The following folders and files are only used by this README and can be safely deleted:

	```sh
   cd ./SHtemplate
   rm -r res
   rm README.md
	```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Customization
Before you continue to [customize the template](#template-structure) it is recommended to **ask yourself the following questions**:

- What are the main goals of my script?
- How shall this script be run? As a (normal) script, interactively, (indefinitely) as a daemon, or mixedly?
- Which parameters do I need, which arguments are allowed?
- Which commands/packages have to be installed before?
- Are there any other requirements?
- Should there be any special handling on exit and/or interrupt, e.g. cleanup procedures?

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- TEMPLATE STRUCTURE -->
## Template Structure

<!-- Overview -->
### Overview
The template is separated into **multiple files** where each file does a different job.

| /     | /                                             | / | Description                                                         |
|-------|-----------------------------------------------|---|---------------------------------------------------------------------|
| etc   |                                               | |                                                                       |
|       | [`run.cfg.sh`](#etcruncfgsh)                  | | Configuration File (`/src/run.sh`)                                    |
|       | [`<...>.cfg.sh`](#etcruncfgsh)                | | Further Configuration Files                                           |
| lib   |                                               | |                                                                       |
|       | [SHlib][SHlib-url]                            | | Shell Library (submodule)                                             |
|       | [SHtemplateLIB][SHtemplateLIB-url]            | | SHtemplate Library (submodule)                                        |
|       | [`...`](#lib)                                 | | Further libraries / library subdirectories                            |
| src   |                                               | |                                                                       |
|       | lang                                          | |                                                                       |
|       |                                               | [`about.lang.sh`](#srclangaboutlangsh-repository-about-file) | Repository About File                                                                                                                              |
|       |                                               | [`run.0.lang.sh`](#srclangrunlangsh-repository-string-constants-files)  | Language-Independent String Constants File (`/src/run.sh`)                                                                                                                              |
|       |                                               | [`run.<ll>.lang.sh`](#srclangrunlangsh-repository-string-constants-files)  | Language-Specific String Constants Files (`/src/run.sh`)                                                                                                                              |
|       |                                               | [`<...>.lang.sh`](#further-string-constants-files-srclanglangsh) | Further String Constants Files                                                                                                                             |
|       | [`init.sh`](#srcinitsh)                       | | Repository Initialisation Script                                      |
|       | **[`run.sh`](#srcrunsh-repository-run-file)** | | **Repository Run File**                                               |
| test  | [`...`](#test)                                | | Test folder, only used for [Daemon Mode Sample](#daemon-mode-sample)  |

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- /etc/run.cfg.sh -->
### `/etc/run.cfg.sh`
Use this file to introduce **constants and variables that the user can set before(!) running** `run.sh`. To better structure your code you can define multiple configuration files. To do so, please make sure that all files

* have the file extension `.cfg.sh` and
* are stored within `/etc/`.

<p align="right">(<a href="#overview">back to overview</a>)</p>


<!-- /lib/... -->
### `/lib/...`
This is the place to **add further shell libraries**. By default [SHlib (`/lib/SHlib`)][SHlib-url] and [SHtemplateLIB (`/lib/SHtemplateLIB`)][SHtemplateLIB-url] are already included.

> :exclamation: Please do not delete `/lib/SHlib` and `/lib/SHtemplateLIB` as the template relies on them.

**To add your own library** files please make sure that they

* have the file extension `.lib.sh` and
* are stored within one of the following paths:

  ```
  /lib/<filename>.lib.sh
  /lib/<subdir>/<filename>.lib.sh
  /lib/<subdir>/lib/<filename>.lib.sh
  ```

**In case you would like to add an existing repository** just change into the template's root directory and **add it as a submodule**, e.g.

  ```sh
  cd <rootdir>
  git submodule add https://github.com/fkemser/SHlib lib/SHlib
  ```

<p align="right">(<a href="#overview">back to overview</a>)</p>


<!-- /src/init.sh -->
### `/src/init.sh`
This file is loaded by [`/src/run.sh`](#srcrunsh-repository-run-file) to initialize the repository, e.g. by setting file/folder structure, loading libraries, etc. Use this file to **publish additional file/folder paths (constants) within your repository.**

<p align="right">(<a href="#overview">back to overview</a>)</p>



<!-- /src/lang/about.lang.sh -->
## `/src/lang/about.lang.sh` (Repository About File)
Edit this file to set **general information about your repository, e.g. author, institution, license, etc.**

<p align="right">(<a href="#overview">back to overview</a>)</p>

<!-- /src/lang/run.<...>.lang.sh -->
## `/src/lang/run.<...>.lang.sh` (Repository String Constants Files)
Use these files to store **string constants for help messages, command outputs, interactive menus, etc.** Afterwards you can reference them in [`/src/run.sh`](#srcrunsh-repository-run-file) by using their constant identifiers.
  
For better code readability and maintenance the **constants are distributed over multiple files**: `run.0.lang.sh` for **language-independent** constants and
 `run.<ll>.lang.sh` for **language-specific** constants where `<ll>` in the filename is the language's [ISO 639-1][iso639-1-url] ID in lowercase letters, e.g. `run.en.lang.sh` contains all English strings, `run.de.lang.sh` the German strings, etc.

> :warning: Regarding the constant identifiers: Please follow the **naming convention below**, otherwise certain features, e.g. the semi-automatic creation of the script's help, will not work correctly.

### Used in interactive (`dialog`) menus
For more information please run `dialog --help` or `man dialog`.

| Constant                            | Example (identifier)                   | Description | Parameter (`dialog`) |
|-------------------------------------|----------------------------------------|-------------|----------------------|
| L\_`<S>`\_`<LL>`\_DLG\_ITM\_`<REF>` | L\_RUN\_EN\_DLG\_ITM\_ARG\_ITEM\_ITEM1 | List item   | (item1)...           |
| L\_`<S>`\_`<LL>`\_DLG\_TTL\_`<REF>` | L\_RUN\_EN\_DLG\_TTL\_ARG\_ITEM        | Title       | [--title (title)]    |
| L\_`<S>`\_`<LL>`\_DLG\_TXT\_`<REF>` | L\_RUN\_EN\_DLG\_TXT\_ARG\_ITEM        | Text        | (text)               |

### Used in `help()`, parameter section (`SYNOPSIS`)
| Constant                            | Example (identifier)           | Example (value)                                       | Description           |
|-------------------------------------|--------------------------------|-------------------------------------------------------|-----------------------|
| L\_`<S>`\_`<LL>`\_HLP\_DES\_`<REF>` | L\_RUN\_EN\_HLP\_DES\_ARG\_INT | Help (arg_int)                                        | Parameter description |
| L\_`<S>`\_HLP\_PAR\_`<REF>`         | L\_RUN\_HLP\_PAR\_ARG\_INT     | -i\|--int (int)                                       | Parameter cmd switch  |
| L\_`<S>`\_`<LL>`\_HLP\_REF\_`<REF>` | L\_RUN\_EN\_HLP\_REF\_ARG\_INT | Use '-i\|--int (int)' to specify \<arg_int\>'s value. | Reference description |

### Used in `help()`, other sections
| Constant                                        | Description           | Example (identifier)                  | Example (value)         |
|-------------------------------------------------|-----------------------|---------------------------------------|-------------------------|
| L\_`<S>`\_`<LL>`\_HLP\_TTL\_EXAMPLES\_`<I>`     | Example (Title)       | L\_RUN\_EN\_HLP\_TTL\_EXAMPLES\_1     | Show Help               |
| L\_`<S>`\_`<LL>`\_HLP\_TXT\_EXAMPLES\_`<I>`     | Example (Text)        | L\_RUN\_EN\_HLP\_TXT\_EXAMPLES\_1     | ./run.sh --help         |
| L\_`<S>`\_`<LL>`\_HLP\_TXT\_NOTES\_`<I>`        | Note (Text)           | L\_RUN\_EN\_HLP\_TXT\_NOTES\_1        | This is the first note. |
| L\_`<S>`\_HLP\_TXT\_REFERENCES\_`<I>`           | Reference             | L\_RUN\_HLP\_TXT\_REFERENCES\_1       | https://www.example.com |
| L\_`<S>`\_`<LL>`\_HLP\_TTL\_REQUIREMENTS\_`<I>` | Requirements (Title)  | L\_RUN\_EN\_HLP\_TTL\_REQUIREMENTS\_1 | General                 |
| L\_`<S>`\_`<LL>`\_HLP\_TXT\_REQUIREMENTS\_`<I>` | Requirements (Text)   | L\_RUN\_EN\_HLP\_TXT\_REQUIREMENTS\_1 | To run this ...         |
| L\_`<S>`\_`<LL>`\_HLP\_TTL\_TLDR\_`<I>`         | TL;DR (Title)         | L\_RUN\_EN\_HLP\_TTL\_TLDR\_1         | Requirements            |
| L\_`<S>`\_`<LL>`\_HLP\_TXT\_TLDR\_`<I>`         | TL;DR (Text)          | L\_RUN\_EN\_HLP\_TXT\_TLDR\_1         | Please install ...      |

### Used in terminal output (`stdout`/`stderr`)
| Constant                    | Description                             | Example (identifier)   | Example (value)  |
|-----------------------------|-----------------------------------------|------------------------|------------------|
| L\_`<S>`\_`<LL>`\_TXT\_`<T>` | Custom language-specific text constants | L\_RUN\_TXT\_TEXT1\_EN | Text 1 (English) |

### Placeholders
| \<...\> | Description                                                             | Example(s)                        |
|---------|-------------------------------------------------------------------------|-----------------------------------|
| `<I>`   | Index, starting from 1                                                  | 1                                 |
| `<LL>`  | Language ID ([ISO 639-1][iso639-1-url])                                 | EN                                |
| `<REF>` | Function, parameter, or parameter (list) value this constant refers to  | HELP, ARG_ACTION, ARG_ACTION_HELP |
| `<S>`   | Reverse script name without '.sh'                                       | RUN                               |
| `<T>`   | Identifier that describes what the string is about                      | ERR_NOT_FOUND                     |

### Further String Constants Files (/src/lang/*.lang.sh)
To better structure your code you can define multiple string constant files. To do so, please make sure that all files

* have the file extension `.lang.sh` and
* are stored within `/src/lang/`.

<p align="right">(<a href="#overview">back to overview</a>)</p>



<!-- /src/run.sh -->
## `/src/run.sh` (Repository Run File)
> :warning: The following sections only give a brief overview. Before running any of these functions **please have a look at the comments in the source files**.

This is the **repository's run file** so this is the **right place to add your code**. A good way to start is to **search for the `TODO:` sections within the source code**. They will guide you through the template and tell you where to add which part of your code.

The **template's design principle** is based on so called **modes** and **actions**.

### Modes
A **mode** defines **how the script is executed**. The template supports four different modes:

| Mode        | Description                         |
|-------------|-------------------------------------|
| daemon      | Indefinite (background/daemon) mode |
| interactive | Interactive mode using `dialog`     |
| script      | Classic script mode                 |
| submenu     | Like `interactive` but with the intention to run one certain submenu and then exit. Usually used by other scripts to skip the welcome dialogue and main menu. |

> :information_source: Your script does not have to support all modes.

<p align="right">(<a href="#overview">back to overview</a>)</p>

### Actions
An **action** consists of **one or multiple commands that the user can trigger** when calling the script. The template is shipped with three **essential** and six sample actions:

| Action              | Description                                 |
|---------------------|---------------------------------------------|
| **about**           | Print dialogue with information about your repository (authors, license, etc.). Only used in interactive mode. |
| **help**            | Show the script's help.                     |
| **exit**            | Exit script. Only used in interactive mode. |
| custom1 ... custom6 | [Sample actions 1 - 6](#sample-actions)     |

> :warning: You can replace or delete the sample actions but **not** the essential ones.

<p align="right">(<a href="#overview">back to overview</a>)</p>

### Constants
To provide certain features, e.g. the semi-automatic creation of `help()`, the script relies on certain constants, variables, and functions:

| Constant                            | Description                                     |
|-------------------------------------|-------------------------------------------------|
| **`ARG_ACTION_LIST_INTERACTIVE`** / **`ARG_ACTION_LIST_SCRIPT`** | Lists of allowed actions `ARG_ACTION_...` in interactive (including submenu) and script mode. Used for auto-generating help's `SYNOPSIS` section and the main menu in interactive mode. |
| `ID_LANG`                           | Current language ID (ISO 639-1), see [`init_lang()`](#init_lang).
| `INSTANCES`                         | Instance counter. Used to check if this script was called recursively.
| **`LIST_ARG`**                      | Lists of compatible parameters (script mode only). Used for auto-generating help's `SYNOPSIS` section. |
| **`LIST_ARG_CLEANUP_INTERACTIVE`**  | List of arguments that have to be cleared or reset to their default values after running [`run()`](#run) function (interactive mode only).              |
| **`PIDLOCK_ENABLED`**               | Enable PID based locking? (`true\|false`) :warning: If enabled (true) the script requires superuser privileges. :warning:                             |
| **`T_DAEMON_SLEEP`**                | Daemon mode sleep interval (in s), see [Daemon Mode Sample](#daemon-mode-sample). |

> :warning: Please edit the constants highlighted in **bold** to adapt the script's behaviour and appearance to your code.

<p align="right">(<a href="#overview">back to overview</a>)</p>

### Variables

| Variable          | Description                                                   |
|-------------------|---------------------------------------------------------------|
| `arg_action`      | Script actions, see [Actions](#actions)                       |
| `arg_logdest`     | Log destination (terminal, `syslog`, both), see [msg()](#msg) |
| `arg_mode`        | Script operation modes, see [Modes](#modes)                   |
| `trap_blocked`    | Prevent trap execution? (`true\|false`) Can be used to [temporarily disable trap handling](#temporarily-disable-trap-handling) |
| `trap_triggered`  | <trap_...()> function was called? (`true\|false`) Used to decide if trap handling has to be (manually) launched after [temporarily disabling it](#temporarily-disable-trap-handling) |

> :exclamation: Please **do not delete or change** any of the variables as the template heavily relies on them.

<p align="right">(<a href="#overview">back to overview</a>)</p>

### Functions

| Function                                | Description / Task                                              |
|-----------------------------------------|-----------------------------------------------------------------|
| [`args_check()`](#args_check)           | Check if passed arguments are valid                             |
| [`args_read()`](#args_read)             | Read/Parse arguments                                            |
| `error()`                               | See [`msg()`](#msg)                                             |
| [`help()`](#help)                       | Print help message using `less` utility                         |
| [`help_synopsis()`](#help_synopsis)     | Create help's `SYNOPSIS` section                                |
| `info()`                                | See [`msg()`](#msg)                                             |
| [`init_check_pre()`](#init_check_pre)   | Check script requirements **before** argument parsing           |
| [`init_check_post()`](#init_check_post) | Check script requirements **after** argument parsing            |
| [`init_first()`](#init_first)           | Set default log destination, (optionally) lock the script (PID file), install trap handler and run other commands that need to be executed right at the beginning.                                                   |
| [`init_lang()`](#init_lang)             | Set language-specific text constants                            |
| [`init_update()`](#init_update)         | Update global variables/constants and perform initialization commands that should be executed **after** argument parsing                                                                                            |
| [`main()`](#main)                       | Main function                                                   |
| [`main_daemon()`](#main_daemon)         | Main subfunction (daemon mode)                                  |
| [`main_interactive()`](#main_interactive) | Main subfunction (interactive / submenu mode)                 |
| [`main_script()`](#main_script)         | Main subfunction (script mode)                                  |
| [`menu_main()`](#menu_main)             | Main menu (interactive mode)                                    |
| [`msg()`](#msg)                         | Log/Print error/info/warning message and optionally exit        |
| [`run()`](#run)                         | Perform one certain action (cycle)                              |
| [`trap_main()`](#trap_main)             | Trap (cleanup and exit) function for this script                |
| `warning()`                             | See [`msg()`](#msg)                                             |

> :exclamation: All functions are essential and must not be deleted. However, you should edit them within the `TODO:` sections to adapt the script to your needs.

<p align="right">(<a href="#overview">back to overview</a>)</p>

#### `args_check()`
Use this function to **check if passed arguments are valid**. You will already find some sample checks, e.g.

* file/folder checks,
* data type checks,
* regex checks,
* value range checks

> :information_source: For more checks please have a look at the functions `lib_core_is()` and `lib_core_regex()` in [`lib/SHlib/lib/core.lib.sh`](https://github.com/fkemser/SHlib/blob/432d56b38dc795aa98d59fe185921d38cc21637c/lib/core.lib.sh)

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `args_read()`
Edit this function to **add your individual command line parameters (switches)**. Please do also not forget to

* also add them to [`/src/lang/run.0.lang.sh`](#srclangrunlangsh-repository-string-constants-files),
* write your help (`SYNOPSIS`) texts in [`/src/lang/run.<ll>.lang.sh`](#srclangrunlangsh-repository-string-constants-files),
* add them to [`help_synopsis()`](#help_synopsis), and
* add the parameters' identifiers (names) to the template's [constants](#constants) (`ARG_ACTION_LIST_INTERACTIVE`, `ARG_ACTION_LIST_SCRIPT`, `LIST_ARG`, `LIST_ARG_CLEANUP_INTERACTIVE`), if relevant.

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `help()`
This function prints the **help message** by using the `less` utility. By default the help consists of the following **sections**:

| Section     | Description                                                             |
|-------------|-------------------------------------------------------------------------|
| TL;DR       | Quick start section                                                     |
| REQUIREMENT | Software and/or hardware requirements                                   |
| SYNOPSIS    | Usage instructions (command line switches, additional arguments, etc.)  |
| EXAMPLES    | Command examples                                                        |
| NOTES       | Notes that are referenced within other help sections                    |
| REFERENCES  | References, e.g. URLs                                                   |
| ABOUT       | Repository-related information (author, institution, license, etc.)     |

> :warning: Please **do not hardcode any help texts within this function**. Instead, edit [`/src/lang/run.<...>.lang.sh`](#srclangrunlangsh-repository-string-constants-files) to define (write) your help texts and edit [`help_synopsis()`](#help_synopsis) to modify the `SYNOPSIS` section of your help.

> :information_source: For a full example just have a look at the [Usage](#usage-example) section below.

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `help_synopsis()`
This is the function that generates the `SYNOPSIS` (usage) section of the script's help (`-h|--help`).
Edit this function to **"publish" your help texts that you have previously created in [`/src/lang/run.<...>.lang.sh`](#srclangrunlangsh-repository-string-constants-files)**.

> :information_source: The introduction containing the available actions `ACTION := { ... }` and options `OPTION := { ... }` is automatically created. This can be controlled via the constants `ARG_ACTION_LIST_SCRIPT` and `LIST_ARG`, see [Constants](#constants) section above.

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `init_check_pre()`
Edit this function to **perform mandatory and/or optional requirement checks before(!) argument parsing**, e.g.

* available commands,
* running services,
* superuser rights

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `init_check_post()`
Edit this function to **perform mandatory and/or optional requirement checks after(!) argument parsing**.

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `init_first()`
As the name already states this is the first function (within [`main()`](#main)) that is executed directly after loading the initialization script [`/src/init.sh`](#srcinitsh) and running [`init_lang()`](#init_lang). It is responsible for **setting the right log destination**: In case the script is running within a terminal window, the script outputs all messages to `stdout/stderr` by default. Otherwise the script uses `syslog (logger)` for logging.

Furthermore this function installs a **trap handler** that calls [`trap_main()`](#trap_main) allowing the script to safely exit, even on interrupts.

Edit this function in case you would like to
* **modify the trap handler (signals, arguments) for [`trap_main()`](#trap_main)**,
* **add further intialisation commands**

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `init_lang()`
This function detects your system's default language and stores its [ISO 639-1][iso639-1-url] ID in `ID_LANG`. This constant is used to generate language-dependent terminal, log, and `dialog` messages.

Edit this function in case you
 * would like **to add support for other language**, or
 * have **text strings for custom terminal/log messages**.

> :warning: Before editing this function please make sure that the [template already supports your language](#adding-support-for-other-languages) and that all language-specific texts (constants) have been defined in [`/src/lang/run.<ll>.lang.sh`](#srclangrunlangsh-repository-string-constants-files).

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `init_update()`
Edit this function to **set constants/variables and run commands after(!) all arguments have been parsed and checked**.

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `main()`
This is the script's entry point so it is the **first function to be called**. In most cases there is no need to edit this function. Instead, **edit the mode-specific main functions `main_...()` right below**.

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `main_daemon()`
This the script's **entry point** for running in **daemon** mode.

> :information_source: This function is shipped with some sample code to demonstrate the daemon mode. See also [`here`](#daemon-mode-sample).

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `main_interactive()`
This the script's **entry point** for running in **interactive or submenu** mode.

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `main_script()`
This the script's **entry point** for running in **(classic) script** mode.

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `menu_main()`
This function controls the **program flow for interactive and submenu** mode. Edit this function, e.g. to **define which `dialog` menus appear for which actions**.

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `msg()`
This function is responsible for **generating terminal and `syslog` messages**. It automatically detects the log destination depending on the user's manual setting (`--log <dest>`) and the current environment (interactive terminal, cron, etc.). The functions `error()`, `info()`, and `warning()` are wrapper functions to generate error/info/warning messages. In most cases there is no need to edit this function but you can **call it (or its wrappers) from your own functions to generate terminal/syslog messages**.

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `run()`
This is the central function for **all modes but daemon mode**:
Here you define **all commands that should be executed depending on the action and other parameters that the user has previously set**, no matter if via command line arguments or interactively.

<p align="right">(<a href="#functions">back to overview</a>)</p>

#### `trap_main()`
This is the script's main trap function and is (by default) executed on exit or when the script is interrupted.
Edit this function to **define your individual trap handling routine**.

> :information_source: To define the signals on which `trap_main()` should be triggered please have a look at [`init_first()`](#init_first).

> :information_source: You can also disable trap handling temporarily, e.g. when running some code that should not be interrupted. See section [Further Code Samples](#further-code-samples).

<p align="right">(<a href="#functions">back to overview</a>)</p>


### Additional Sample Code
Besides the basic template, [`/src/run.sh`](#srcrunsh-repository-run-file) is also shipped with some sample actions, parameters, and functions. They **do not serve any specific purpose but are just for showing you the possibilities of the script**. In contrast to the [basic template](#srcrunsh-repository-run-file) you can safely delete or replace the parts described below.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

#### Sample Parameters and Constants

| Parameter / Constant  | Description                                                                               |
|-----------------------|-------------------------------------------------------------------------------------------|
| `arg_arg_or_stdin`    | Sample parameter that either takes an argument or, if not set, `stdin`'s content          |
| `arg_bool`            | Sample boolean parameter                                                                  |
| `arg_dir`             | Sample directory parameter                                                                |
| `arg_file`            | Sample file parameter                                                                     |
| `arg_int`             | Sample integer parameter with a range of allowed values                                   |
| `arg_item`            | Sample list item parameter                                                                |
| `arg_password`        | Sample password parameter                                                                 |
| `arg_str`             | Sample string parameter                                                                   |
| `EXT_TEST`            | Test file extension for sample daemon, see also [Daemon Mode Sample](#daemon-mode-sample) |

<p align="right">(<a href="#readme-top">back to top</a>)</p>

#### Sample Actions
There are six sample actions (`custom1`...`custom6`). Each action behaves differently in the sense of how (in which [mode](#srcrunsh-repository-run-file)) it can be run and which parameters it requires or accepts.

The matrix below shows **which action can be run in which mode** ...

| arg_action  | interactive | script  | submenu |
|-------------|-------------|---------|---------|
| custom1     | -           | x       | -       |
| custom2     | x           | x       | x       |
| custom3     | x           | x       | x       |
| custom4     | x           | x       | x       |
| custom5     | x           | x       | x       |
| custom6     | -           | -       | x       |

> :information_source: The `daemon` mode is not listed here as it has its own function [`func1()`](#func1), see also [Daemon Mode Sample](#daemon-mode-sample).

... where the second matrix shows **which of the actions require which parameter(s)**:

| arg_action  | arg_arg_or_stdin  | arg_bool  | arg_dir | arg_file  | arg_int | arg_item  | arg_password  | arg_str |
|-------------|-------------------|-----------|---------|-----------|---------|-----------|---------------|---------|
| custom1     | -                 | -         | -       | -         | -       | -         | -             | -       |
| custom2     | -                 | o         | -       | -         | -       | o         | -             | -       |
| custom3     | -                 | -         | x       | -         | -       | -         | -             | -       |
| custom4     | -                 | -         | -       | -         | x       | -         | -             | x       |
| custom5     | (x)               | -         | -       | (x)       | -       | -         | -             | -       |
| custom6     | -                 | -         | -       | -         | -       | -         | -             | -       |

| ... | Meaning                         |
|-----|---------------------------------|
|  -  | not relevant                    |
|  o  | optional (in script mode they can be passed via their command line switches, in interactive (and submenu) mode there is a dialog that can be skipped) |
|  x  | mandatory                       |
| (x) | mandatory but either ... or ... |

<p align="right">(<a href="#readme-top">back to top</a>)</p>

#### Sample Functions

| Function                        | Description                                                                   |
|---------------------------------|-------------------------------------------------------------------------------|
| [`func1()`](#func1)             | Sample function that can be run either in script mode or daemon mode          |
| [`menu_arg_...()`](#menu_arg_)  | `dialog` menus for setting sample parameters in interactive and submenu mode  |
| [`trap_func1()`](#trap_func1)   | Trap (cleanup and exit) function for `func1()` (daemon mode only)             |

<p align="right">(<a href="#readme-top">back to top</a>)</p>

##### `func1()`
This is **an example on how to write functions that can run in both, script mode and daemon mode**. As a sample function it does not fulfill a certain purpose. It simply processes a given file by printing its name and a message, either to the terminal (script mode) or to `syslog` (daemon mode).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

##### `menu_arg_...()`
These functions provide the interactive `dialog`-based menus for setting the sample parameters listed above, e.g. `menu_arg_bool()` is the menu for setting `arg_bool`.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

##### `trap_func1()`
This is `func1()` 's special trap function and is only used if the script is running in daemon mode. Edit this function to **define your individual trap handling routine for `func1()` when running the script in daemon mode**.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

#### Daemon Mode Sample
In daemon mode [`main_daemon()`](#main_daemon) runs [`func1()`](#func1) not only for a single file but over all files with a pre-defined extension (`EXT_TEST`) within a pre-defined folder (`arg_dir`). This is done parallely, meaning that there are running **multiple instances** of [`func1()`](#func1), one per file, running in a **subshell**.

To allow the subshells to terminate safely on signals, e.g. `SIGTERM`, [`func1()`](#func1) installs [`trap_func1()`](#trap_func1) as a trap handler within the subshell.

To let the daemon mode run indifinetly there are two loops: One within [`func1()`](#func1) (within each subshell) and a second one in [`main_daemon()`](#main_daemon) (within the calling script). The latter is just a backup: In case a subshell crashes, it gets "respawned" within a maximum period of time that can be defined via the constant `T_DAEMON_SLEEP`.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MULTI-LANGUAGE SUPPORT -->
## Adding support for other languages
To add support for other languages please follow these steps:

1. First check whether [SHtemplateLIB](https://github.com/fkemser/SHtemplateLIB#adding-support-for-other-languages), the template's own library, supports your language. If not, please follow the translation instructions there before continuing.

2. Create your project/repository-specific translation file [`/src/lang/run.<ll>.lang.sh`](#srclangrunlangsh-repository-string-constants-files) where `<ll>` in the filename is the language's [ISO 639-1][iso639-1-url] ID in lowercase letters, e.g. create `run.`**`es`**`.lang.sh` to store **`Spanish`** strings.

3. To finally enable support for the new language: Open [`/src/run.sh`](#srcrunsh-repository-run-file) and look for the `init_lang()` function. Add your language's [ISO 639-1][iso639-1-url] ID within the `TODO:` section, e.g. to add Spanish (`ES`) to the list, simply add:

```sh
case "${ID_LANG}" in
  ...
  ${LIB_C_ID_LANG_ES}) readonly ID_LANG="${LIB_C_ID_L_ES}";;
  ...
esac
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- FURTHER CODE SAMPLES -->
## Further Code Samples
There are some code snippets that did not fit into the template but yet they are worth to be mentioned.

### Run a certain command (`<cmd>`) and in case of any error do not only log a pre-defined error message (`<msg>`) but also the command's previous output (`<result>`)
```sh
exec 3>&1
  result="$(<cmd> 2>&1 1>&3; exit $?)" # TODO: Replace <cmd> by your own value.
  exitcode="$?"
exec 3>&-
if [ ${exitcode} -ne 0 ]; then
  # ...                             # TODO: Put your error handling here.
  msg="<msg>"                       # TODO: Replace <msg> by your own value.
  error "${msg}" "${result}"
fi
```

### Temporarily disable trap handling
```sh
trap_blocked="true"   # Disable trap handling
# ...
# TODO: Put commands here that should not(!) be interrupted
# ...
trap_blocked="false"  # Re-enable trap handling

# Run trap handling (manually) if trap was previously triggered
if ${trap_triggered}; then
  if ${is_subshell}; then trap_func1; else trap_main; fi
fi
```

### Check whether the script was called recursively
```sh
if eval [ \${${INSTANCES}} -gt 1 ]; then echo "Script recursively called"; fi
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- HELP (EXAMPLE) -->
## Help (Example)

```sh
================================================================================
==============================     SHtemplate     ==============================
=======================     (Press 'q' to quit ...)     ========================
================================================================================

A template repository for Bourne-Shell (sh) projects.

================================================================================
================================     TL;DR     =================================
================================================================================

_________________________________ Requirements _________________________________

To install the necessary packages on your system, simply run:

Debian
> sudo apt install dialog (...)

(...further requirements...)

The script has been developed and tested on the following system:

OS:         ... (Run 'cat /etc/*release')
Kernel:     ... (Run 'uname -r')
Packages:   Dialog (...), (...)

___________________________________ Synopsis ___________________________________

There are multiple ways to run this script. For more information please have a look at <SYNOPSIS> section below.

Interactive mode (without any args):
> ./run.sh

Classic (script) mode:
> ./run.sh [ OPTION ]... ACTION [<file>]

================================================================================
=============================     REQUIREMENTS     =============================
================================================================================

___________________________________ General ____________________________________

Required Packages:
  General: (...)
  Debian:  > sudo apt install (...)

Optional Packages:
  General: (...)
  Debian:  > sudo apt install (...)

(...)

_________________________ Interactive Mode (optional) __________________________

In case you run this script interactively (see <SYNOPSIS> below)
your terminal window must have a size of <100x30> or bigger.

Required Packages:
  General: Dialog
   Debian: > sudo apt install dialog

================================================================================
===============================     SYNOPSIS     ===============================
================================================================================

There are multiple ways to run this script:

Interactive mode (without any args):
> ./run.sh

Classic (script) mode:
> ./run.sh [ OPTION ]... ACTION [<file>]

ACTION := { -h|--help | --custom1 | --custom2 | --custom3 <dir> | --custom4 <int> <str> | --custom5 [<file>] }

OPTION := { [-b|--bool] | [-f|--file <file>] | [-i|--int <int>] | [-j|--item <item>] | [--log <dest>] | [-p|--password <pwd>] | [-s|--str <string>] }

[<file>] : File to use

--------------------------------------------------------------------------------
--------------------------------     ACTION     --------------------------------
--------------------------------------------------------------------------------

-h|--help                 Show this help message                                

-D|--daemon               Run this script in daemon (background) mode           

--submenu <menu>          Run a certain submenu interactively and exit          
                                                                                
                          <menu> = { custom2 | custom3 | custom4 | custom5 |    
                          custom6 }                                             

--custom1                 Help <ARG_ACTION_CUSTOM1>                             

--custom2                 Help <ARG_ACTION_CUSTOM2> Use '-b|--bool' to enable   
                          <arg_bool>. Use '-j|--item <item>' to specify         
                          <arg_item>'s value.                                   

--custom3 <dir>           Help <ARG_ACTION_CUSTOM3>. Regarding <dir> please     
                          have a look at '-d|--dir <dir>'.                      

--custom4 <int> <str>     Help <ARG_ACTION_CUSTOM4>. Regarding <int> and <str>  
                          please have a look at '-i|--int <int>' and '-s|--str  
                          <string>'.                                            

--custom5 [<file>]        Help <ARG_ACTION_CUSTOM5>. Either use a given <file>  
                          or <stdin>'s (pipe) content ('echo "string" |         
                          ./run.sh --custom5').                                 

--custom6                 Help <ARG_ACTION_CUSTOM6>                             

--------------------------------------------------------------------------------
--------------------------------     OPTION     --------------------------------
--------------------------------------------------------------------------------

--log <dest>            Specify where to write log message to                                   
                                                                                
                            both  :  Terminal + System log                      
                          syslog  :  System log only                            
                        terminal  :  Terminal only                              
                                                                                
                        (default: 'terminal')                                   

-b|--bool               Help <arg_bool>                                         

-d|--dir <dir>          Help <arg_dir>                                          

-f|--file <file>        Help <arg_file>                                         

-i|--int <int>          Help <arg_int>                                          
                                                                                
                        <int> = [0, 10] (default: '1')                          

-j|--item <item>        Help <arg_item>                                         
                                                                                
                        item1  :  Help <ARG_ITEM_ITEM1>                         
                        item2  :  Help <ARG_ITEM_ITEM2>                         
                                                                                
                        <item> = { item1 | item2 }                              
                                                                                
                        (default: 'item1')                                      

-p|--password <pwd>     Help <arg_password>. See also (1).                      
                                                                                
                        (default: '')                                           

-s|--str <string>       Help <arg_str>                                          
                                                                                
                        (default: 'abc123')                                     

================================================================================
===============================     EXAMPLES     ===============================
================================================================================

__________________________________ Example 1 ___________________________________

> ./run.sh --custom1

__________________________________ Example 2 ___________________________________

> ./run.sh --custom2 --item item2

================================================================================
================================     NOTES     =================================
================================================================================

_____________________________________ (1) ______________________________________

It is highly recommended to pass credentials only via environmental variables. To do so, just set this value to 'env:<VAR>' (without '' <>) where <VAR> is your environmental variable's name.

Please note that passing credentials in clear-text form can be highly insecure as any other user/process could display the command line of this application by using system utilities like 'ps'.

Example: You would like to pass the password '123456'.

  Via an environmental variable (preferred)
    > export mypwd="123456"
    > ... "env:mypwd"

  Directly, in clear-text form (NOT recommended)
    > ... "123456"

_____________________________________ (2) ______________________________________

This is the text of note 2.

================================================================================
==============================     REFERENCES     ==============================
================================================================================

[1]     https://www.example.com                                                 

[2]     https://www.example.org                                                 

================================================================================
================================     ABOUT     =================================
================================================================================

  AUTHORS
    Florian Kemser and the SHtemplate contributors

  COPYRIGHT
    This file is part of SHtemplate, a template repository for 
    POSIX-/Bourne-Shell(sh) projects.
    
    Copyright (c) 2023-2024 Florian Kemser and the SHtemplate contributors
    
    Permission is hereby granted, free of charge, to any person obtaining a 
    copy of this software and associated documentation files (the "Software"), 
    to deal in the Software without restriction, including without limitation 
    the rights to use, copy, modify, merge, publish, distribute, sublicense, 
    and/or sell copies of the Software, and to permit persons to whom the 
    Software is furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice (including the next 
    paragraph) shall be included in all copies or substantial portions of the 
    Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
    DEALINGS IN THE SOFTWARE.
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/fkemser/SHtemplate/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the **MIT License**. See [`LICENSE`][license-url] for more information.  

> :warning: The license above does not apply to the files and folders within the library `/lib` directory. Please have a look at the `LICENSE` file located in the root directory of each library to get more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Project Link: [https://github.com/fkemser/SHtemplate](https://github.com/fkemser/SHtemplate)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments
###
* [othneildrew/Best-README-Template](https://github.com/othneildrew/Best-README-Template)
* [Ileriayo/markdown-badges](https://github.com/Ileriayo/markdown-badges)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/fkemser/SHtemplate.svg?style=for-the-badge
[contributors-url]: https://github.com/fkemser/SHtemplate/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/fkemser/SHtemplate.svg?style=for-the-badge
[forks-url]: https://github.com/fkemser/SHtemplate/network/members
[stars-shield]: https://img.shields.io/github/stars/fkemser/SHtemplate.svg?style=for-the-badge
[stars-url]: https://github.com/fkemser/SHtemplate/stargazers
[issues-shield]: https://img.shields.io/github/issues/fkemser/SHtemplate.svg?style=for-the-badge
[issues-url]: https://github.com/fkemser/SHtemplate/issues
[license-shield]: https://img.shields.io/github/license/fkemser/SHtemplate.svg?style=for-the-badge
[license-url]: https://github.com/fkemser/SHtemplate/blob/main/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username

[screenshot11]: res/screenshot11.png
[screenshot21]: res/screenshot21.png
[screenshot31]: res/screenshot31.gif
[screenshot41]: res/screenshot41.gif
[screenshot51]: res/screenshot51.png
[screenshot52]: res/screenshot52.png
[screenshot61]: res/screenshot61.png
[screenshot71]: res/screenshot71.png
[screenshot81]: res/screenshot81.png

[SHlib-url]: https://github.com/fkemser/SHlib
[SHtemplateLIB-url]: https://github.com/fkemser/SHtemplateLIB

[iso639-1-url]: https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes

[LaTeX-shield]: https://img.shields.io/badge/latex-%23008080.svg?style=for-the-badge&logo=latex&logoColor=white
[LaTeX-url]: https://www.latex-project.org/
[Shell Script-shield]: https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white
[Shell Script-url]: https://pubs.opengroup.org/onlinepubs/9699919799/