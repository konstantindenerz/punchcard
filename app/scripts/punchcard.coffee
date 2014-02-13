scope = window
scope.lab = if scope.lab then scope.lab else {}
scope.lab.reports = if scope.lab.reports then scope.lab.reports else {} 

scope.lab.reports.PunchCard = class
	
	###
		The given converter should be used to convert the domain specific data to a common structure.
	###
	constructor: (@selector, @dataConverter)->
	@formats: 
		hoursAndDays:
			columns: 24
			rows: 7
			size: 40
			rowLabels:
				0: 'Sun'
				1: 'Mon'
				2: 'Tue'
				3: 'Wed'
				4: 'Thu'
				5: 'Fri'
				6: 'Sat'
			
		days:
			columns: 1
			rows: 7
			size: 20
			rowLabels:
				0: 'Sun'
				1: 'Mon'
				2: 'Tue'
				3: 'Wed'
				4: 'Thu'
				5: 'Fri'
				6: 'Sat'

	currentFormat: this.formats.hoursAndDays

	###

	### 
	use: (rawData)-> 
		data = @dataConverter.convert rawData, this.currentFormat
		render.call this, data

	render = (data)-> 
		self = this
		maxCellValue = getMaxValueOfCells.call this, data
		maxCellValue = Math.max maxCellValue, 1 # Avoid a devision by zero
		size = this.currentFormat.size
		punchcard = d3.select(@selector);
		punchcard.selectAll('thead, tbody').remove()
		punchcard.append('thead')
			.selectAll('tr')
			.data(d3.range(0, self.currentFormat.columns + 1))
			.enter()
			.append('th')
			.text((d)-> if d is 0 then '' else d - 1)
		rows = punchcard.append('tbody')
			.selectAll('.now')
		rowsUpdate = rows.data(data)
		rows = rowsUpdate.enter()
			.append('tr')
			.attr('class', 'row')
		rows.selectAll('td')
			.data((d, i)->d.cells)
			.enter()
			.append('td')
			.append('div')
			.attr('class', 'cell-data')
			.attr 'style', (d)->
				newSize = d * size / maxCellValue
				if size > 0 then "width:#{newSize}px;height:#{newSize}px;" else 'display:none;'
			.attr('title', (d)-> d)
			.text((d)-> d)
		rows.insert('td', ':first-child')
			.text((d, i)-> self.currentFormat.rowLabels[i])
		return


	getMaxValueOfCells = (data)->
		maxValue = d3.max data, (d)->
			return d3.max d.cells
		if maxValue >= 0 then maxValue else 0