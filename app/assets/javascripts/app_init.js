document.addEventListener("turbolinks:before-cache", function() {
  $(".qr-code canvas").remove()
})
document.addEventListener("turbolinks:load", function(){
  $(".qr-code").each(function(){
    $(this).qrcode($(this).data("qr-code-content"))
  })
  $("select.select2").removeClass("select2-hidden-accessible")
	$("span.select2-container").remove()
	$( ".select2" ).select2({
	  theme: "bootstrap",
	  language: "zh-CN"
	});
})