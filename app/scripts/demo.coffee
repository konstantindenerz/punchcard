
$ () ->

	retrieveData = (useMockData)->
		userName = $('#user').val()
		repoName = $('#repo').val()

		# Create punch card chart in the given container and with a custom data converter
		punchCard = new lab.reports.PunchCard '#punchcard',new GitCommitPunchCardConverter
		# data provider that should be used to load information from GitHub
		gitRepoDataProvider = if useMockData then new GitRepoDataProvider commitMockData else new GitRepoDataProvider
		# Use this delegate to invoke the use method after ajax call
		delegate = lab.util.delegate punchCard, punchCard.use
		# Load information about commits from GitHub
		gitRepoDataProvider.retrieveCommits userName, repoName, delegate

	$retrieveData = $ '#retrieveData'
	$retrieveData.click ()-> retrieveData()
		
	$retrieveMockData = $ '#retrieveMockData'
	$retrieveMockData.click ()-> retrieveData yes

	retrieveData yes
	return
