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
[![GNU GPL v3.0 License][license-shield]][license-url]
<!-- [![LinkedIn][linkedin-shield]][linkedin-url] -->



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <!-- <a href="https://github.com/fkemser/LUKSwrapper">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a> -->

<h3 align="center">LUKSwrapper</h3>

  <p align="center">
    A collection of shell scripts to setup and manage LUKS2-encrypted drives, either interactively or via command line.
    <br />
    <a href="https://github.com/fkemser/LUKSwrapper"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/fkemser/LUKSwrapper">View Demo</a>
    ·
    <a href="https://github.com/fkemser/LUKSwrapper/issues">Report Bug</a>
    ·
    <a href="https://github.com/fkemser/LUKSwrapper/issues">Request Feature</a>
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
        <li><a href="#os-settings">OS Settings</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage-srclukssh">Usage (/src/luks.sh)</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

![Screenshot 1][screenshot1]

This project provides a `dialog`-based interface to

- setup dm-crypt/LUKS2 encryption on hard drives and flash drives,
- mount and unmount LUKS2 devices,
- add and remove LUKS2 key slots (passphrases, FIDO2 devices, PKCS11 token, TPM2 chips),
- backup and restore LUKS2 header,
- clone flash drives.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

[![Shell Script][Shell Script-shield]][Shell Script-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Testing Environment

The project has been developed and tested on the following system:

| Info | Description
---: | ---
OS | Debian GNU/Linux 12 (bookworm)
Kernel | 6.1.0-17-amd64
Packages | [coreutils (9.1-1)](https://packages.debian.org/bookworm/coreutils)
|| [cryptsetup (2:2.6.1-4~deb12u1)](https://packages.debian.org/bookworm/cryptsetup)
|| [dash (0.5.12-2)](https://packages.debian.org/bookworm/dash)
|| [dialog (1.3-20230209-1)](https://packages.debian.org/bookworm/dialog)
|| [libc-bin (2.36-9+deb12u1)](https://packages.debian.org/bookworm/libc-bin)
|| [libccid (1.5.2-1)](https://packages.debian.org/bookworm/libccid)
|| [libfido2-1 (1.12.0-2+b1)](https://packages.debian.org/bookworm/libfido2-1)
|| [libtss2-esys-3.0.2-0 (3.2.1-3)](https://packages.debian.org/bookworm/libtss2-esys-3.0.2-0)
|| [libtss2-rc0 (3.2.1-3)](https://packages.debian.org/bookworm/libtss2-rc0)
|| [opensc-pkcs11 (0.23.0-0.3+deb12u1)](https://packages.debian.org/bookworm/opensc-pkcs11)
|| [pcscd (1.9.9-2)](https://packages.debian.org/bookworm/pcscd)
|| [pv (1.6.20-1)](https://packages.debian.org/bookworm/pv)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started
### Prerequisites
Please make sure that the following dependencies are installed:

* [Cryptsetup and LUKS](https://gitlab.com/cryptsetup/cryptsetup)
* [Pipe Viewer](https://www.ivarch.com/programs/pv.shtml)

Additionally, there are some use-case specific dependencies (see sections below):

* [Dialog](https://invisible-island.net/dialog/dialog.html)
* [libfido2-1](https://developers.yubico.com/libfido2/)
* [libtss2-esys-3.0.2-0](https://github.com/tpm2-software/tpm2-tss)
* [libtss2-rc0](https://github.com/tpm2-software/tpm2-tss)

### Mandatory
```
  Packages: Cryptsetup, PipeViewer
    Debian: > sudo apt install cryptsetup pv
```

### Interactive Mode (optional)
In case you run this script interactively your terminal window must have a size of <100x30> or bigger.

````
  Packages: Dialog
    Debian: > sudo apt install dialog
````

### FIDO2/PKCS#11/TMP2 Security Token/Chip (optional)
Please make sure that your OS is shipped with <systemd> version '251.3-1' or
higher. To check your current systemd version simply run
  > systemctl --version

#### FIDO2
Your token must support the "HMAC Secret Extension (hmac-secret)".  
Additionally, the following packages must be installed:  

````
  Packages: libfido2.so.1
    Debian: > sudo apt install libfido2-1
````

#### PKCS#11
Your token must be initialized and contain a valid public/private key pair.  
Additionally, the following packages must be installed:  

````
  Packages: OpenSC (PKCS#11 module), PCSClite, USB PC/SC CCID driver
    Debian: > sudo apt install opensc-pkcs11 pcscd libccid
````

See also: https://github.com/shimunn/fido2luks/tree/master#theory-of-operation

#### TPM2
````
  Packages: TPM2 Software stack library - TSS and TCTI libraries
    Debian: > sudo apt install libtss2-esys-3.0.2-0 libtss2-rc0
````

See also: https://manpages.debian.org/experimental/systemd/systemd-cryptenroll.1.en.html

Below you can find distribution-specific installation instructions.

#### Debian
```sh
sudo apt install cryptsetup pv                      # Required
sudo apt install dialog                             # Interactive Mode (optional)
sudo apt install libfido2-1                         # FIDO2 (optional)
sudo apt install opensc-pkcs11 pcscd libccid        # PKCS#11 (optional)
sudo apt install libtss2-esys-3.0.2-0 libtss2-rc0   # TPM2 (optional)
```

### Installation

1. Clone the repo
	```sh
   git clone --recurse-submodules https://github.com/fkemser/LUKSwrapper.git
   ```
2. Edit the repository configuration file. In case it is empty just keep it as it is, **do not delete it**.
	```sh
   nano ./LUKSwrapper/etc/cups.cfg.sh
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage (/src/luks.sh)

To call the script interactively, run `/src/luks.sh` (without further arguments) from your terminal. To get help, run `/src/luks.sh -h`.  

```sh
================================================================================
===============================     SYNOPSIS     ===============================
================================================================================

There are multiple ways to run this script:

Interactive mode (without any args):
> ./luks.sh

Classic (script) mode:
> ./luks.sh [ OPTION ]... ACTION [<device>]

ACTION := { -h|--help | --benchmark | --clone <src dev> <dst dev> | --close <device> | --encrypt <device> | --enroll <device> | --header-backup <device> <file> | --header-info <device> | --header-restore <file> <device> | --is-luks-device <device> | --list-token <type> | --open <device> | --remove <device> | --replace <device> | --show-drives }

OPTION := { [--auth <type>] | [-c|--cipher <cipher>] | [--fido2-device <dev>] | [--filesystem <fs>] | [--hash <algorithm>] | [-i|--iter-time <t>] | [-s|--key-size <bits>] | [--mapper <name>] | [--mount <mountpoint>] | [--no-pin] | [--pkcs11-token-uri <uri>] | [--tpm2-device <dev>] | [--tpm2-pcrs <pcrs>] }

[<device>] : Block device to use, e.g. '/dev/sda'

--------------------------------------------------------------------------------
--------------------------------     ACTION     --------------------------------
--------------------------------------------------------------------------------

-h|--help                            Show this help message                     

--submenu <menu>                     Run a certain submenu interactively and    
                                     exit                                       
                                                                                
                                     <menu> = { show-drives | benchmark |       
                                     encrypt | open | close | enroll | remove | 
                                     replace | header-backup | header-restore | 
                                     header-info | clone }                      

--benchmark                          Run a benchmark                            

--clone <src dev> <dst dev>          Clone <src dev> to <dst dev>               

--close <device>                     Close and unmount <device>                 

--encrypt <device>                   Encrypt <device>                           

--enroll <device>                    Enroll a passphrase or a security token    
                                     (FIDO2/PKCS#11/TPM2) to <device>'s LUKS    
                                     header. Use it with '--auth <type>' to set 
                                     the authentication method to use.          

--header-backup <device> <file>      Backup <device>'s LUKS header to <file> (4)

--header-info <device>               Show information about <device>'s LUKS     
                                     header                                     

--header-restore <file> <device>     Restore <device>'s LUKS header from <file> 

--is-luks-device <device>            Check whether <device> is a LUKS device.   
                                     Return value: 0 = yes, 1 = no.             

--list-token <type>                  List connected tokens of a certain type    
                                                                                
                                      fido2  :  FIDO2 Security Token            
                                     pkcs11  :  PKCS#11 Smartcards and          
                                                Security Token                  
                                       tpm2  :  Trusted Platform Module 2       
                                                (TPM2)                          

--open <device>                      Open <device> and mount it. Use it with    
                                     '--auth <type>' to set the authentication  
                                     method to use.                             

--remove <device>                    Either remove a passphrase from <device>'s 
                                     LUKS header or wipe an entire token slot   
                                     (3)                                        

--replace <device>                   Only with '--auth <fido2|pkcs11|tpm2>'.    
                                     Replace an entire token slot by all        
                                     (currently connected) security token       

--show-drives                        Show available drives                      

--------------------------------------------------------------------------------
--------------------------------     OPTION     --------------------------------
--------------------------------------------------------------------------------

____________ ACTION := { --enroll | --open | --remove | --replace } ____________

--auth <type>     Specify authentication method to use for accessing LUKS       
                  encryption key                                                
                                                                                
                  passphrase  :  Passphrase                                     
                    recovery  :  Recovery Key                                   
                                 (automatically                                 
                                 generated). Only if                            
                                 ACTION := { --enroll |                         
                                 --remove | --replace }.                        
                                 Mostly identical to                            
                                 'passphrase', but this                         
                                 option randomly                                
                                 generates a passphrase                         
                                 which can be optionally                        
                                 scanned off screen via a                       
                                 QR code.                                       
                       fido2  :  FIDO2 Security Token                           
                      pkcs11  :  PKCS#11 Smartcards and                         
                                 Security Token                                 
                        tpm2  :  Trusted Platform Module                        
                                 2 (TPM2)                                       
                                                                                
                  (default: 'passphrase')                                       

_________________ ACTION := { --enroll | --open | --replace } __________________

--fido2-device <dev>         Only with '--auth fido2'. Specify FIDO2 (hidraw)   
                             device to use, possible values are:                
                                                                                
                             auto  :  Automatically (exactly one (1)            
                                      token, no other token must be             
                                      connected)                                
                              ...  :  Manually, by specifying its               
                                      devnode name (<dev> =                     
                                      /dev/hidraw...). To list all              
                                      currently connected hidraw                
                                      devices, just run './luks.sh              
                                      --list-token fido2'.                      
                                                                                
                             (default: 'auto')                                  

--pkcs11-token-uri <uri>     Only with '--auth pkcs11'. Specify PKCS#11 URI of  
                             the token object to use, possible values are:      
                                                                                
                             auto  :  Automatically (exactly one (1)            
                                      token, no other token must be             
                                      connected)                                
                              ...  :  Manually, by specifying the               
                                      URI (<uri> = pkcs11:...). To              
                                      list all currently discovered             
                                      PKCS#11 token, just run                   
                                      './luks.sh --list-token                   
                                      pkcs11'.                                  
                                                                                
                             (default: 'auto')                                  

--tpm2-device <dev>          Only with '--auth tpm2'. Specify TPM2 security     
                             chip (device) to use, possible values are:         
                                                                                
                             auto  :  Automatically (there must be              
                                      exactly one (1) chip existing)            
                              ...  :  Manually, by specifying its               
                                      devnode name (<dev> =                     
                                      /dev/tpmrm...). To list all               
                                      currently discovered TPM2                 
                                      chips, just run './luks.sh                
                                      --list-token tpm2'.                       
                                                                                
                             (default: 'auto')                                  

______________________ ACTION := { --enroll | --replace } ______________________

--no-pin               Only with '--auth <fido2|tpm2>'. Disable any PIN request 
                       during unlock. Not recommended.                          

--tpm2-pcrs <pcrs>     Only with '--auth tpm2'. Specify one or more TPM2 PCRs   
                       (Platform Configuration Registers) to bind the requested 
                       enrollment to. <pcrs> must be a '+' separated list of    
                       PCR indexes in the range of 0...23. For more information 
                       please have a look at 'man systemd-cryptenroll', section 
                       '--tpm2-pcrs= [PCR...]'.                                 
                                                                                
                       (default: '7')                                           

_______________________ ACTION := { --encrypt | --open } _______________________

--filesystem <fs>     Filesystem to use for mounting or formatting              
                                                                                
                      (default '--encrypt <device>': ext4)                      
                      (default '--open <device>': auto)                         

--mapper <name>       Map open LUKS device to '/dev/mapper/<name>'              
                                                                                
                      (default: '<device>_crypt', e.g. 'sdz_crypt')             

_____________________________ ACTION := --encrypt ______________________________

-c|--cipher <cipher>     Specify cipher (1). Run 'cat /proc/crypto',            
                         'cryptsetup benchmark' to get a list of available      
                         ciphers.                                               
                                                                                
                         (default: 'aes-xts-plain64')                           

--hash <algorithm>       Specify the passphrase hash (1). Run 'cryptsetup       
                         benchmark' to get a list of available algorithms.      
                                                                                
                         (default: 'sha256')                                    

-i|--iter-time <t>       Specify number of milliseconds to spend with PBKDF2    
                         passphrase processing                                  
                                                                                
                         (default: '2000')                                      

-s|--key-size <bits>     Specify key size in bits (1) (2)                       
                                                                                
                         (default: '512')                                       

_______________________________ ACTION := --open _______________________________

--mount <mountpoint>     Specify mount point. Leave <mountpoint> empty ("") to  
                         prevent mounting.                                      
                                                                                
                         (default: '/mnt/mapper/(--mapper <name>)')             

================================================================================
===============================     EXAMPLES     ===============================
================================================================================

________________________________ Encrypt device ________________________________

./luks.sh --show-drives
./luks.sh --cipher aes-xts-plain64 --hash sha256 --iter-time 2000 --key-size 512 --filesystem ext4 --encrypt /dev/sdz

____________________________ Open and close device _____________________________

./luks.sh --show-drives
./luks.sh --mapper mymapper --filesystem auto --open /dev/sdz
./luks.sh --close /dev/sdz

______________________________ Enroll FIDO2 token ______________________________

./luks.sh --auth fido2 --fido2-device auto --enroll /dev/sdz
./luks.sh --auth fido2 --fido2-device auto --mapper mymapper --open /dev/sdz
./luks.sh --close /dev/sdz

__________________________ Backup and recover header ___________________________

./luks.sh --header-info /dev/sdz
./luks.sh --header-backup /dev/sdz /tmp/luks.header
./luks.sh --header-restore /tmp/luks.header /dev/sdz

================================================================================
================================     NOTES     =================================
================================================================================

_____________________________________ (1) ______________________________________

Run 'cryptsetup --help' to show the defaults.

_____________________________________ (2) ______________________________________

Important if you use a cipher with XTS operation mode:
XTS splits the supplied key in half, e.g. for AES-256 with
XTS mode you need a key size of 512 bits.

_____________________________________ (3) ______________________________________

Use '--auth <type>' to define the authentication method that
should be removed from the LUKS header. If <type> is ...

          'passphrase' : Only the passphrase entered during prompt
                         will be removed from LUKS header

      'fido2'|'pkcs11' : ALL tokens of this type
     'recovery'|'tpm2'   will be removed from LUKS header

_____________________________________ (4) ______________________________________

IT IS HIGHLY RECOMMENDED TO STORE YOUR HEADER BACKUP ON A SEPARATE EXTERNAL
FLASH DRIVE. In case you delete passphrases/tokens from your header you must
also update your header backup files. Otherwise one could restore your old
header and use deprecated passphrases/tokens.
```

                     

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/fkemser/LUKSwrapper/issues) for a full list of proposed features (and known issues).

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

Distributed under the **GNU General Public License v3.0 (or later)**. See [`LICENSE`][license-url] for more information.

> :warning: The license above does not apply to the files and folders within the library `/lib` directory. Please have a look at the `LICENSE` file located in the root directory of each library to get more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Project Link: [https://github.com/fkemser/LUKSwrapper](https://github.com/fkemser/LUKSwrapper)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments
###
* [othneildrew/Best-README-Template](https://github.com/othneildrew/Best-README-Template)
* [Ileriayo/markdown-badges](https://github.com/Ileriayo/markdown-badges)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/fkemser/LUKSwrapper.svg?style=for-the-badge
[contributors-url]: https://github.com/fkemser/LUKSwrapper/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/fkemser/LUKSwrapper.svg?style=for-the-badge
[forks-url]: https://github.com/fkemser/LUKSwrapper/network/members
[stars-shield]: https://img.shields.io/github/stars/fkemser/LUKSwrapper.svg?style=for-the-badge
[stars-url]: https://github.com/fkemser/LUKSwrapper/stargazers
[issues-shield]: https://img.shields.io/github/issues/fkemser/LUKSwrapper.svg?style=for-the-badge
[issues-url]: https://github.com/fkemser/LUKSwrapper/issues
[license-shield]: https://img.shields.io/github/license/fkemser/LUKSwrapper.svg?style=for-the-badge
[license-url]: https://github.com/fkemser/LUKSwrapper/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username

[screenshot1]: res/screenshot1.png

[LaTeX-shield]: https://img.shields.io/badge/latex-%23008080.svg?style=for-the-badge&logo=latex&logoColor=white
[LaTeX-url]: https://www.latex-project.org/
[Shell Script-shield]: https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white
[Shell Script-url]: https://pubs.opengroup.org/onlinepubs/9699919799/