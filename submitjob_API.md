```python
	import sys
	from DIRAC.Core.Base import Script
   	Script.parseCommandLine()
   
   	from DIRAC.Core.Security.ProxyInfo import getProxyInfo
   	from DIRAC.Interfaces.API.Dirac import Dirac
   	from DIRAC.Interfaces.API.Job import Job
   	j = Job(stdout='StdOut', stderr='StdErr')
		
	njobs = sys.argv[1]
	
	lfn = 'LFN:/myLFN/'
	
	for i in range(njobs):
		dirac = Dirac()
		j.setName('My Job Number '+i)
		j.setPlatform('EL7')
		j.setTag(['8Processors']
		j.setDestination('LCG.UKI-NORTHGRID-MAN-HEP.uk')
		j.setExecutable('/bin/echo', arguments='hello world')
		# Input data
		j.setInputData(['myInputData.tar.gz', 'myInputDataText.txt'])
		j.setInputSandbox(['myscript.sh'])
		# Output data
		j.setOutputSandbox([''])
		j.setOutputData('bigOutputData.txt', outputSE='UKI-NORTHGRID-MAN-HEP-disk', outputPath='/myresults')
		try:
			diracUsername = getProxyInfo()['value']['username']
		except:
			print 'Failed to get DIRAC username. No proxy set up?'
			sys.exit(1)
		j.setJobGroup(diracUsername+'_mygroup')
		jobID = dirac.submitJob(j)
		print 'Submission Result: ', jobID
```
