# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

function handleFileSelect(evt) {

//Remove currently existing thumbnails
var list_element = document.getElementById("list");
while(list_element.firstChild){
  list_element.removeChild(list_element.firstChild);
}

var files = evt.target.files; // FileList object

// Loop through the FileList and render image files as thumbnails.
for (var i = 0, f; f = files[i]; i++) {

// Only process image files.
if (!f.type.match('image.*')) {
  continue;
}

var reader = new FileReader();

// Closure to capture the file information.
reader.onload = (function(theFile) {
  return function(e) {
// Render thumbnail.
var span = document.createElement('span');
span.innerHTML = ['<img class="thumb item_pic_preview" src="', e.target.result,
  '" title="', escape(theFile.name), '"/>'].join('');
document.getElementById('list').insertBefore(span, null);
};
})(f);

// Read in the image file as a data URL.
reader.readAsDataURL(f);
}
}

document.getElementById('item_item_pictures').addEventListener('change', handleFileSelect, false);
