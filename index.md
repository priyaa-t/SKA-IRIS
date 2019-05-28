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
 
  <details>
    <summary markdown="span"> <code>eMERLIN-CP-jobsubmit</code> </summary>
  
      ```python
      #!/usr/bin/env python
      #
      # Template for submitting lots of jobs to GridPP DIRAC or LHCb DIRAC
      # Lots of inline comments. Please edit to suit your situation.
      #
      # This script uses DIRAC parametric jobs:
      #  https://github.com/DIRACGrid/DIRAC/wiki/JobManagementAdvanced

      import sys
      import time

      from DIRAC.Core.Base import Script
      Script.parseCommandLine()

      from DIRAC.Core.Security.ProxyInfo import getProxyInfo
      from DIRAC.Interfaces.API.Dirac import Dirac

      # We construct the DIRAC Job Description Language as string in jdl:
      jdl = ''

      # Something descriptive for the name! Like 'FastRawMerging'.
      jdl += 'JobName = "eMERLIN_CP_IRIS_test";\n'

      # One job will be created for each parameter in the list
      #jdl += "Parameters = 10;\n"
      #jdl += "ParameterStart=1;\n"
      #jdl += "ParameterStep=1;\n"

      # Run the job at Manchester
      jdl += 'Site = "LCG.UKI-NORTHGRID-MAN-HEP.uk";\n'       # in GridPP DIRAC
      jdl += 'OutputSE = "UKI-NORTHGRID-MAN-HEP-disk";\n'
      #jdl += 'Tags = "8Processors";\n'
      jdl += 'Tags = "nordugrid-Condor-himem";\n'
      #jdl += 'GridCE = "ce01.tier2.hep.manchester.ac.uk";\n' # IRIS
      #jdl += 'GridCE = "vm3.tier2.hep.manchester.ac.uk";\n'

      #jdl += 'Site = "LCG.Manchester.uk";\n'                 # in LHCb DIRAC
      #jdl += 'Site = "VAC.UKI-NORTHGRID-MAN-HEP.uk";\n'      # in GridPP DIRAC
      #jdl += 'Site = "VAC.Manchester.uk";\n'                 # in LHCb DIRAC

      # Run the job at SARA
      #jdl += 'Site = "LCG.SARA-MATRIX.nl";\n'                 # in SARA DIRAC
      #jdl += 'SmpGranularity = 4;\n'
      #jdl += 'CPUNumber = 4;\n'
      #jdl += 'OutputSE = "SARA-MATRIX-disk";\n'

      # Run the job at wherever
      #jdl += 'Site = "LCG.UKI-SOUTHGRID-OX-HEP.uk";\n'      # in GridPP DIRAC
      #jdl += 'OutputSE = "UKI-SOUTHGRID-OX-HEP-disk";\n'
      #jdl += 'Tags = "8Processors";\n'

      # Allows job to run on local queues (must correspond to tags in DIRAC CS!)
      # jdl += 'Tags = "manchester";\n'
      jdl += 'Platform = "EL7";\n'

      # The script you want to run.
      jdl += 'Executable = "eMERLIN_CP_IRIS_test.sh";\n'

      # tarJob.sh will be run with these command line arguments
      # %n is a counter increasing by one for each job in the list
      # %s is the parameter taken from the list given in Parameters = { ... }
      # %j is the unique DIRAC Job ID number
      # something is just a value to show you can add other things too
      jdl += 'Arguments = "%n %s %j something";\n'

      # Send the script you want to run (in this directory where you run man-job-submit
      # or give the full path to it)
      jdl += """InputSandbox = { "eMERLIN_CP_IRIS_test.sh", "runjupyter_eMERLIN_CP.sh", "inputs.txt", "LFN:/skatelescope.eu/user/r/rachael.ainsworth/notebook_test/jupyter-casa.simg", "LFN:/skatelescope.eu/user/r/rachael.ainsworth/eMERLIN_CP_IRIS_test/CASA_eMERLIN_pipeline.tar.gz",
      "LFN:/skatelescope.eu/user/r/rachael.ainsworth/eMERLIN_CP_IRIS_test/eMERLIN_CASA_Pipeline_clean.ipynb", "LFN:/skatelescope.eu/user/r/rachael.ainsworth/eMERLIN_CP_IRIS_test/3C277.1_eMERLIN.tar.gz"};\n"""

      # Tell DIRAC where to get your big input data files from
      # %s is the parameter taken from the list given in Parameters = { ... }
      #jdl += 'InputData = "LFN:/skatelescope.eu/user/r/rachael.ainsworth/notebook_test/3C277.1.MULTTB";\n'

      # Direct stdout and stderr to files
      jdl += 'StdOutput = "StdOut";\n';
      jdl += 'StdError = "StdErr";\n';

      # Small files can be put in the output sandbox
      jdl += 'OutputSandbox = {"StdOut", "StdErr"};\n'

      # Files to be saved to your grid storage area in case they are large
      # %j is the unique DIRAC Job ID number.
      # DIRAC looks for this output file in the working directory.
      jdl += 'OutputData = "LFN:/skatelescope.eu/user/r/rachael.ainsworth/eMERLIN_CP_IRIS_test/eMERLIN_CP_IRIS_test_output_%j.tar";\n'

      # Give the OutputSE too if using OutputData:
      # jdl += 'OutputSE = "UKI-NORTHGRID-MAN-HEP-disk";\n'   # storage in GridPP DIRAC
      # jdl += 'OutputSE = "CERN-USER";\n'                    # storage in LHCb DIRAC

      # Tell DIRAC how many seconds your job might run for
      jdl += 'MaxCPUTime = 1000;\n'

      # Create a unique Job Group for this set of jobs
      try:
        diracUsername = getProxyInfo()['Value']['username']
      except:
        print 'Failed to get DIRAC username. No proxy set up?'
        sys.exit(1)

      jobGroup = diracUsername + time.strftime('.%Y%m%d%H%M%S')
      jdl += 'JobGroup = "' + jobGroup + '";\n'

      print 'Will submit this DIRAC JDL:'
      print '====='
      print jdl
      print '====='
      print
      # Submit the job(s)
      print 'Attempting to submit job(s) in JobGroup ' + jobGroup
      print
      dirac = Dirac()
      result = dirac.submit(jdl)
      print
      print '====='
      print
      print 'Submission Result: ',result
      print
      print '====='
      print

      if result['OK']:
        print 'Retrieve output with  dirac-wms-job-get-output --JobGroup ' + jobGroup
      else:
        print 'There was a problem submitting your job(s) - see above!!!'
      print
      ```
      
  </details>
  
</details>
