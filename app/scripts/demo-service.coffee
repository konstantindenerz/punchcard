class GitRepoDataProvider
	constructor: (@mockData) ->
	retrieveCommits: (userName, repoName, delegate)->
		if @mockData
			delegate.invoke(@mockData)
		else
			$.ajax 
				dataType: 'jsonp'
				url: "https://api.github.com/repos/#{userName}/#{repoName}/commits?per_page=100"
				complete: (response, message)->
					data = response.responseJSON?.data
					delegate.invoke data



class GitCommitPunchCardConverter

	convert: (rawData, format) ->
		data = getInitialData.call this, format
		# Fill data container with raw data
		for item in rawData
			date = new Date item.commit.author.date
			if not data[date.getDay()]
				data[date.getDay()] = {}
			if data[date.getDay()][date.getHours()]?
				data[date.getDay()][date.getHours()]++
			else
				data[date.getDay()][date.getHours()] = 1;

		# Convert data to common format
		result = []
		for rowIndex, row of data
			newRow = rowIndex: rowIndex, cells: []
			for cellIndex, cellData of row
				# newCell = cellIndex: cellIndex,	cellData: cellData
				newRow.cells.push cellData
			result.push newRow
		result

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
