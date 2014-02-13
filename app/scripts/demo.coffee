$ () ->
	###commitPunchCard = new CommitPunchCard
    userName = 'konstantindenerz';
    repoName = 'punchcard';
    gitRepoDataProvider = new GitRepoDataProvider true, commitMockData
    #     var rawData = gitRepoDataProvider.getCommits(userName, repoName, delegate(commitPunchCard, commitPunchCard.use))###