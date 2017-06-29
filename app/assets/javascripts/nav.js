// 讓 nav 不需點擊就可打開 dropdown-menu
$(document).on("turbolinks:load", function() {
	$("a[data-toggle='dropdown']").on("mouseover", function() {
		$(this).trigger("click")
	})	
})