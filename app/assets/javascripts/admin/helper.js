document.addEventListener("turbolinks:load", function(){
	if ($("body.admin.items").length > 0) {
		function showImage(src,target) {
		  var fr=new FileReader();
		  // when image is loaded, set the src of the image where you want to display it
		  fr.onload = function(e) {
		    target.src = this.result;
		  };
		  if (src != undefined && (src.length > 0)) {
		  	src.addEventListener("change",function() {
			    // fill fr with image data
			    fr.readAsDataURL(src.files[0]);
			  });	
		  }
		}

		var src = document.getElementById("item_image");
		var target = document.getElementById("target");
		showImage(src,target);
	}
})