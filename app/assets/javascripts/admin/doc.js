$(document).on("click", "tr.doc", function() {
  if ($(this).hasClass("selected")) {
    $(this).removeClass("selected")
    $(".btn-toggle-doc").addClass("hidden")
    $(".btn-toggle-folder").removeClass("hidden")
  } else {
    $(".docs.index table tr").removeClass("selected")
    var $doc = $(this)
    $doc.addClass("selected")
    // 此 url 作為基本 url 拿來替換
    window.doc_action_url = "/admin/docs/" + $doc.data("doc-id") + "/action_name?name=" + $doc.data("doc-name")
    $(".btn-toggle-doc").removeClass("hidden")
    $(".btn-toggle-folder").addClass("hidden")
  }
})
$(document).on("click", "tr.folder", function() {
  var $folder = $(this)
  if ($folder.hasClass("selected")) {
  } else {
    $(".docs.index table tr").removeClass("selected") 
    $folder.addClass("selected")
    $(".btn-toggle-doc").addClass("hidden")
    $(".btn-toggle-folder").removeClass("hidden")
  }
})
$(document).on("click", "tbody.folders tr.folder.selected", function() {
  // 點擊資料夾會打開～
  window.location.href = window.location.origin + "/admin/folders/" + $(this).data("folder-id") + "/docs"
})
$(document).on("click", ".btn-download, .btn-preview", function(e) {
	e.preventDefault()
  var action_name = $(this).data("action-name")
  var action_url = window.location.origin + window.doc_action_url.replace("action_name", action_name)
  window.open(action_url)
})
$(document).on("click", ".btn-share", function(e) {
  e.preventDefault()
  $("#share_timeout").val(600)
  update_share_modal_data(600)
  $("#share_url").select()
})
$(document).on("change", "#share_timeout", function() {
	update_share_modal_data($(this).val())
})

var update_share_modal_data = function(share_timeout) {
	var share_url = window.location.origin + window.doc_action_url.replace("action_name", "share") + "&share_timeout=" + share_timeout
  $("#share_url").val(share_url)
  var qr = new QRious({
    element: document.getElementById('qr'),
    value: share_url,
    size: 200
  });
  var canvas = $('#qr');
  // console.log(canvas);
  var img = $(canvas)[0].toDataURL("image/png");
  $("#qr-img").attr("src", img);
}