---
layout: default
---

# SKA@IRIS

<details>
  <summary markdown="span"> Getting an X509 grid certificate </summary>
 
  TBD
  
</details>

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
 
  There are three steps to making your own machine a DIRAC UI. You only ever need to do this once. There are three scripts that you will need: [runMeForCertAndKey](https://raw.githubusercontent.com/as595/SKA-IRIS/master/DIRACUI/runMeForCertAndKey), [InstallDirac.sh](https://raw.githubusercontent.com/as595/SKA-IRIS/master/DIRACUI/InstallDirac.sh) and [SetGridProxy](https://raw.githubusercontent.com/as595/SKA-IRIS/master/DIRACUI/SetGridProxy).
  
  * The first step is to activate your grid certificate and obtain a grid key: 
  
  ```bash
  ./runMeForCertAndKey /path/to/mycert.p12
  ```
  The script will ask you for your password **four times**. Yes, you read that correctly, *four times*. It will create a directory called <code>.globus</code> and put its outputs in there.

  * The second step is to install DIRAC and set your grid proxy, telling it you'e part of the skatelescope.eu VO:

  ```bash
  ./InstallDirac.sh
  ```

  * Finally you need to source the DIRAC init scripts:

  ```bash
  source ./dirac_ui/bashrc
  ```
  You can then copy the contents of the DIRAC UI .bashrc into the .bashrc in your home area so that it is automatically called every time you log in or open a new terminal.

  At this point you should be all set up. You can test that things work by starting the DIRAC file catalogue client:

  ```bash
  dirac-dms-filecatalog-cli
  ```
  
</details>

<details>
  <summary markdown="span"> Regenerate your 24 hour grid proxy</summary>
 
  ```bash
  ./SetGridProxy
  ```
</details>

<details>
  <summary markdown="span"> Submitting a job using DIRAC </summary>
 
  An example of a job submission file is shown in [eMERLIN-CP-jobsubmit](./submitjob.md).
  
  <details markdown="span">
    <summary markdown="span"> Submitting a job using DIRAC </summary>
 
    An example of a job submission file is shown in [eMERLIN-CP-jobsubmit](./submitjob.md).
  
  </details>

</details>

<details>
  <summary markdown="span"> Uploading data to the DIRAC file catalogue </summary>
 
</details>

<details>
  <summary markdown="span"> Downloading data from the DIRAC file catalogue </summary>
 
</details>

<details>
  <summary markdown="span"> Tracking the status of your jobs </summary>
 
</details>
