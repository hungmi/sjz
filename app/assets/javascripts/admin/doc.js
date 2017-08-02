$(document).on("click", "tr.doc", function() {
  if ($(this).hasClass("selected")) {
    $(this).removeClass("selected")
    $(".btn-toggle-doc").addClass("hidden")
    $(".btn-toggle-folder").removeClass("hidden")
  } else {
    $(".docs.index table tr").removeClass("selected selected_by_param")
    var $doc = $(this)
    $doc.addClass("selected")
    // 此 url 作為基本 url 拿來替換
    window.doc_action_url = "/admin/docs/" + $doc.data("doc-id") + "/action_name?name=" + $doc.data("doc-name")

    $("#editDocBtn").attr("href", "/admin/docs/" + $doc.data("doc-id") + "/edit?folder_id=" + $doc.data("folder-id"))
    $("#destroyDocBtn").attr("href", "/admin/docs/" + $doc.data("doc-id"))
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
    
    // 為了讓每次點同一個編輯按鈕能拉到對應的 form
    $("#editFolderBtn").data("url", "/admin/folders/" + $folder.data("folder-id") + "/edit")
    $("#destroyFolderBtn").attr("href", "/admin/folders/" + $folder.data("folder-id"))

    $(".btn-toggle-doc").addClass("hidden")
    $(".btn-toggle-folder").removeClass("hidden")
  }
})
$(document).on("click", "tbody.folders tr.folder.selected", function() {
  // 點擊資料夾會打開～
  window.location.href = window.location.origin + "/admin" + "/docs?folder_id=" + $(this).data("folder-id")
})
$(document).on("click", ".docs.index tbody.docs tr.doc.selected", function() {
  // 點擊資料夾會打開～
  window.open(window.location.origin + "/admin/docs/" + $(this).data("doc-id") + "/preview")
})
$(document).on("click", ".docs.edit tbody.docs tr.doc", function() {
  // 點擊文檔會打開其編輯頁面～
  window.location.href = window.location.origin + "/admin/docs/" + $(this).data("doc-id") + "/edit?folder_id=" + $(this).data("folder-id")
})
$(document).on("click", ".search tbody.docs tr.doc.selected", function() {
  // 點擊搜尋到的文檔會打開其編輯頁面～
  window.open(window.location.origin + "/admin/docs/?folder_id=" + $(this).data("folder-id") + "&doc_id=" + $(this).data("doc-id"))
})
$(document).on("click", ".btn-download, .btn-preview", function(e) {
	e.preventDefault()
  var action_name = $(this).data("action-name")
  var action_url = window.location.origin + window.doc_action_url.replace("action_name", action_name)
  window.open(action_url)
})

// 以下為 doc share 相關
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

$(document).on("change", "#docSharePermanent input", function() {
  if (this.checked) {
    $("#share_timeout").prop("disabled", true)
    update_share_modal_data("")
    $("#share_url").val($("#share_url").val().replace("&share_timeout=", ""))
  } else {
    $("#share_timeout").prop("disabled", false)
    update_share_modal_data($("#share_timeout").val())
  }
})