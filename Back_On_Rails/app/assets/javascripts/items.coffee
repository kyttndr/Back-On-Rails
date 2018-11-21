handleFileSelect = (evt) ->
#Remove currently existing thumbnails
  list_element = document.getElementById('list')
  while list_element.firstChild
    list_element.removeChild list_element.firstChild
  files = evt.target.files
  # FileList object
  # Loop through the FileList and render image files as thumbnails.
  i = 0
  f = undefined
  while f = files[i]
# Only process image files.
    if !f.type.match('image.*')
      i++
      continue
    reader = new FileReader
    # Closure to capture the file information.
    reader.onload = ((theFile) ->
      (e) ->
# Render thumbnail.
        span = document.createElement('span')
        span.innerHTML = [
          '<img class="thumb item_pic_preview" src="'
          e.target.result
          '" title="'
          escape(theFile.name)
          '"/>'
        ].join('')
        document.getElementById('list').insertBefore span, null
        return
    )(f)
    # Read in the image file as a data URL.
    reader.readAsDataURL f
    i++
  return

document.getElementById('item_item_pictures').addEventListener 'change', handleFileSelect, false
