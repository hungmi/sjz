$(document).on("click", "tr.doc-row td.clickable", function() {
  window.open($(this).parents("tr.doc-row").data("url"), "_blank")
})