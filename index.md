---
layout: default
---

# SKA@IRIS

<details>
  <summary markdown="span"> Creating a DIRAC UI on Windows</summary>
 
  Ha ha ha ha ha ha ha ha ha (etc.)
  
</details>

<details>
  <summary markdown="span"> Creating a DIRAC UI on Mac OSX</summary>
 
  Once you have created a Linux virtual machine you should ssh into it and follow the steps below for creating a DIRAC UI on a Linux machine.
</details>

<details>
  <summary markdown="span"> Creating a DIRAC UI on Linux</summary>
 
  There are three steps to making your own machine a DIRAC UI. You only ever need to do this once.
  
  * The first step is to activate your grid certificate and obtain a grid key: 
  
  ```bash
  ./runMeForCertAndKey /path/to/mycert.p12
  ```
  The script will ask you for your password **four times**. Yes, you read that correctly, *four times*. It will create a directory called <code>.globus</code> and put its outputs in there.

  * The second step is to install DIRAC:

  ```bash
  ./InstallDirac.sh
  ```

  * Finally you need to source the DIRAC init scripts:

  ```bash
  source ./dirac_ui/bashrc
  ```
You can then copy the contents of the DIRAC UI .bashrc into the .bashrc in your home area so that it is automatically called every time you log in or open a new terminal.

</details>

<details>
  <summary markdown="span"> Regenerate your 24 hour grid proxy</summary>
 
  ```bash
  ./SetGridProxy
  ```
</details>

<details>
  <summary markdown="span"> Submitting a job using DIRAC </summary>
 
  
</details>
