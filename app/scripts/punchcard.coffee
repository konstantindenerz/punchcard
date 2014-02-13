scope = window
scope.lab = if scope.lab then scope.lab else {}
scope.lab.reports = if scope.lab.reports then scope.lab.reports else {} 

scope.lab.reports.PunchCard = class
	###
		The given converter should be used to convert the domain specific data to a common structure.
	###
	constructor: (@dataConverter)->
	@formats: 
		hoursAndDays:
			columns: 24
			rows: 7
			size: 30
		days:
			columns: 1
			rows: 7
			size: 20

	currentFormat: this.formats.hoursAndDays

	###

	### 
	use: (rawData)-> 
		data = @dataConverter.convert rawData, this.currentFormat
		render.call this, data

	render = (data)-> 


