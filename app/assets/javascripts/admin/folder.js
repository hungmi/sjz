$(document).on("ajax:success", function(e) {
  if (e.target.id == "destroyFolderBtn") {
    $("tr.folder.selected").remove()
    $(".btn-toggle-folder").addClass("hidden")
  }
})
$(document).on("ajax:error", function(e) {
  if (e.target.id == "destroyFolderBtn") {
    $("tr.folder.selected").remove()
  }
})