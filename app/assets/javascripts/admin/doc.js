$(document).on("click", "tr.doc-row td.clickable", function() {
  window.open($(this).parents("tr.doc-row").data("url"), "_blank")
})
$(document).on("click", ".btn-share", function(e) {
	e.preventDefault()
  window.share_url = $(this).siblings(".btn-download").attr("href")
})
$(document).on("shown.bs.modal", "#docShareUrl", function () {
	$("#share_timeout").val(600)
	update_share_modal_data(600)
  $("#share_url").select()
})
$(document).on("change", "#share_timeout", function() {
	update_share_modal_data($(this).val())
})

var update_share_modal_data = function(share_timeout) {
	var share_url = window.location.origin + window.share_url.replace("download", "share") + "?share_timeout=" + share_timeout
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