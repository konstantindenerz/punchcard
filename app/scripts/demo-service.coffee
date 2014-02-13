class GitRepoDataProvider
	constructor: (@mockData) ->
	retrieveCommits: (userName, repoName, delegate)->
		if @mockData
			delegate.invoke(@mockData)
		else
			$.ajax 
				dataType: 'jsonp'
				url: "httsp://api.github.com/repos/#{userName}/#{repoName}/commits"
				complete: (response, message)->
					data = response.responseJSON?.data
					delegate.invoke data



class GitCommitPunchCardConverter

	convert: (rawData, format) ->
		data = getInitialData.call this, format
		for item in rawData
			date = new Date item.commit.author.date
			if data[date.getDay()]
				console.log(42)

	###
		Initialize data container with the default values to avoid the processing of the sparse matrices.
	###
	getInitialData = (format) -> 
		result = {}
		for rowIndex in [0...format.rows]
			result[rowIndex]={}
			for columnIndex in [0...format.columns]
				result[rowIndex][columnIndex] = 0
		result
