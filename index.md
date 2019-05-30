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
 
 <hr>
 
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
  <hr>
  
</details>

<details>
  <summary markdown="span"> Regenerate your 24 hour grid proxy</summary>
 
  ```bash
  ./SetGridProxy
  ```
</details>

<details>
  <summary markdown="span"> Submitting a job using DIRAC </summary>
 
  <hr>
  
  Jobs are submitted to DIRAC using a string command in the DIRAC *job description language* (jdl). Typically this is wrapped in a script that makes it easier to visualise all the elements of the string. An example of a full job submission script is shown in [eMERLIN-CP-jobsubmit](./submitjob.md).
  
  <h3 id="header">Tags</h3>

  If you want to submit a high memory (1.5TB) job to one of the IRIS fat nodes, your JDL should specify:
  
  ```python
  jdl += 'Tags = "nordugrid-Condor-himem";\n'
  ```
  
  If you want to submit a standard 8-core job to IRIS, your JDL should specify:
  
  ```python
  jdl += 'Tags = "8Processors";\n'
  ```
  
  <hr>
  
</details>

<details>
  <summary markdown="span"> Uploading data to the DIRAC file catalogue </summary>
  
  <hr>
  
  From your DIRAC UI you can add a dataset to the DIRAC file catalogue using the <code>dirac-dms-add-file</code> command. This example uploads the local file <code>myfile.txt</code> to the file catalogue on the Manchester HEP storage, where it is renamed <code>newfile.txt</code> and placed in the user directory in an individual user's folder. User folders have the format <code>firstname.lastname</code>.
  
  ```bash
  dirac-dms-add-file /skatelescope.eu/users/m/my.name/newfile.txt /path/to/myfile.txt UKI-NORTHGRID-MAN-HEP-disk
  ```
 <hr>
 
</details>

<details>
  <summary markdown="span"> Downloading data from the DIRAC file catalogue </summary>
 
</details>

<details>
  <summary markdown="span"> Tracking the status of your jobs </summary>
 
</details>
