
$ () ->
	userName = 'konstantindenerz'
	repoName = 'punchcard'



	punchCard = new lab.reports.PunchCard new GitCommitPunchCardConverter
	
	gitRepoDataProvider = new GitRepoDataProvider commitMockData
	delegate = lab.util.delegate punchCard, punchCard.use
	gitRepoDataProvider.retrieveCommits userName, repoName, delegate

	return
