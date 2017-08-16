// var "newFolder" = "newFolder"
var trigger_name = ".ajax-trigger[data-target='#" + "newFolder" + "']"
$(document).on("click", trigger_name, function(){
  var $trigger = $(this)
  $.ajax({
    url: $trigger.data("url"),
    method: "get",
  }).done(function(data, status, xhr) {
    window.data = data
    window.status = status
    window.xhr = xhr
    var $modal = $("#" + "newFolder")
    $modal.find(".modal-body").html(data)
    var $form = $modal.find("form")
    // $form.append('<input type="hidden" name="model_id" id="model_id" value="' + $model.data('model-id') + '">')
  })
})
$(document).on("click", '#' + "newFolder" + ' button.submit-btn', function(){
  $('#' + "newFolder").find("form").submit()
})
$(document).on("submit", '#' + "newFolder" + ' form', function(e){
  e.preventDefault()
  var $form = $('#' + "newFolder").find("form")
  $.ajax({
    url: $form.attr("action"),
    method: $form.attr("method"),
    data: $form.serialize()
  }).done(function(data, status, xhr){
    $('#' + "newFolder").modal("hide")
    // 成功之後會觸發一個事件，例如 editOrder 的 modal 就會觸發 editOrderSuccess
    $(document).trigger("newFolder" + 'Success', data, status)
  }).fail(function(xhr, status, errors){
    window.xhr = xhr
    for (error in xhr.responseJSON) {
      $form.prepend("<div class='alert alert-danger'>" + xhr.responseJSON[error] + "</div>")
    }
    // 失敗也會觸發一個事件，例如 editOrder 的 modal 就會觸發 editOrderFail
    $(document).trigger("newFolder" + 'Fail', status, errors)
  })
})
$(document).on("newFolder" + "Success", function(xhr, data) {
  $("tbody.folders").append(data)
  $("table.hidden").removeClass("hidden")
  $("div.nothing-tip").remove()
})