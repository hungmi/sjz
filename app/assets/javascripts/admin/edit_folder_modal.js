// var "editFolder" = "editFolder"
var trigger_name = ".ajax-trigger[data-target='#" + "editFolder" + "']"
$(document).on("click", trigger_name, function(){
  var $trigger = $(this)
  $.ajax({
    url: $trigger.data("url"),
    method: "get",
  }).done(function(data, status, xhr) {
    window.data = data
    window.status = status
    window.xhr = xhr
    var $modal = $("#" + "editFolder")
    $modal.find(".modal-body").html(data)
    var $form = $modal.find("form")
    // $form.append('<input type="hidden" name="model_id" id="model_id" value="' + $model.data('model-id') + '">')
  })
})
$(document).on("click", '#' + "editFolder" + ' button.submit-btn', function(){
  $('#' + "editFolder").find("form").submit()
})
$(document).on("submit", '#' + "editFolder" + ' form', function(e){
  e.preventDefault()
  var $form = $('#' + "editFolder").find("form")
  $.ajax({
    url: $form.attr("action"),
    method: $form.attr("method"),
    data: $form.serialize()
  }).done(function(data, status, xhr){
    $('#' + "editFolder").modal("hide")
    // 成功之後會觸發一個事件，例如 editOrder 的 modal 就會觸發 editOrderSuccess
    $(document).trigger("editFolder" + 'Success', data, status)
  }).fail(function(xhr, status, errors){
    window.xhr = xhr
    for (error in xhr.responseJSON) {
      $form.prepend("<div class='alert alert-danger'>" + xhr.responseJSON[error] + "</div>")
    }
    // 失敗也會觸發一個事件，例如 editOrder 的 modal 就會觸發 editOrderFail
    $(document).trigger("editFolder" + 'Fail', status, errors)
  })
})
$(document).on("editFolder" + "Success", function(xhr, data) {
  $("tr.folder.selected").replaceWith(data)
})