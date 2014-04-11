# takes some "images", apply the height to it,
# calculate via the aspect ratio the correct width
# an create rows that match roughly the "maxWidth"
# some rows exceed the maxWidth, some fall below
createRows = (images, height, maxWidth)->
	allRows = []
	currentRow = {width:0, images:[]}
	images.forEach (image,index) ->
		oWidth = image.element.offsetWidth
		oHeight = image.element.offsetHeight
		image.resizeTo = calcImageDimensions(oWidth, oHeight, null, height)
		currentRow.width += image.resizeTo.width
		currentRow.images.push(image)

		if currentRow.width >= maxWidth || index+1 == images.length
			allRows.push(currentRow)
			currentRow = {width:0, images:[]}

	return allRows

# takes an array of "images" and a "height"
# calculating the correct width while keep
# the aspect ratio. returns an array
# with the calculated data
recalcRow = (images, height)->
	currentRow = {width:0, images:[]}
	images.forEach (image, index) ->
		oWidth = image.element.offsetWidth
		oHeight = image.element.offsetHeight
		image.resizeTo = calcImageDimensions(oWidth, oHeight, null, height)
		currentRow.width += image.resizeTo.width
		currentRow.images.push(image)
	return currentRow

# resize all images in "imageArr",
# starting with a row height of "bestHeight"
# resizing all images until all fitting
# in all rows the "maxWidth"
window.justifiedImageRows = (bestHeight, images, maxWidth)->

	if !bestHeight
		throw new Error("bestHeight is not set")

	if !images
		throw new Error("no images array are given")

	if !maxWidth
		throw new Error("maxWidth must be set")

	if !Array.isArray(images)
		throw new Error("images parameter must be an array")

	# create array we can work with
	imageArr = []
	images.forEach (image, index)-> imageArr.push({element: image})

	# create rows with all images
	rows = createRows(imageArr, bestHeight, maxWidth)

	# correct all rows till all fit the container width
	recalculatedRows = []
	rows.forEach (row, index)->
		i = 0
		# while the row overflows the current
		# container width....
		while(row.width > maxWidth)
			# ... decrease the row height until
			# the row fit the container width
			row = recalcRow(row.images, bestHeight--)

			# break the loop after max 3000 iterations
			# or the browser dies. dirty yea
			i++
			break if i > 3000

		# if the row width below the container witdh
		# then increase the height, until the row fits
		while(row.width < maxWidth && row.width < (maxWidth-2))
			row = recalcRow(row.images, bestHeight++)
			# break the loop after max 3000 iterations
			# or the browser dies. dirty yea
			i++
			break if i > 3000

		# push the corrected rows to the allRows Array
		recalculatedRows.push(row)

	# iterate over all rows and all images and resize all
	# images via css
	recalculatedRows.forEach (row, index)-> row.images.forEach (image, index2)->
		image.element.width = image.resizeTo.width

	return