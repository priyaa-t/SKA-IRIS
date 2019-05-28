---
layout: default
---

# SKA@IRIS

<details>
  <summary markdown="span"> Creating a DIRAC UI on your local Linux machine</summary>
 
  There are three steps to making your own machine a DIRAC UI. You only ever need to do this once.
  
  The first step is to activate your grid certificate and obtain a grid key: 
  
  ```bash
  ./runMeForCertAndKey /path/to/mycert.p12
  ```

The second step is to install DIRAC:

  ```bash
  ./InstallDirac.sh
  ```

Then source the DIRAC init scripts:

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
