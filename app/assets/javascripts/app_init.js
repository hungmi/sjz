document.addEventListener("turbolinks:before-cache", function() {
  $(".qr-code canvas").remove()
})
document.addEventListener("turbolinks:load", function(){
  $(".qr-code").each(function(){
    $(this).qrcode($(this).data("qr-code-content"))
  })
  $(".select2").select2({
  	theme: "bootstrap"
  })
  // svg4everybody();
})