$(document).on('turbolinks:load', function() {
  $('.form__content__top__tags__selector').select2({
    allowClear: true,
    placeholder: 'Select a least ont tag...',
    minimumResultsForSearch: 1,
    maximumSelectionLength: 4
  })
  document.getElementsByClassName("d-none")[0].addEventListener('change', previewFile)
  document.getElementById("cover-img-review").addEventListener('click', removeFile)
});

function previewFile() {
  var preview = document.querySelector('img');
  var file    = document.querySelector('input[type=file]').files[0];
  var reader  = new FileReader();

  reader.onloadend = function () {
    preview.src = reader.result;
  }

  if (file) {
    reader.readAsDataURL(file);
  } else {
    preview.src = '';
  }
}
function removeFile() {
  document.querySelector('input[type=file]').value=null;
  document.querySelector('img').src = ''
}
