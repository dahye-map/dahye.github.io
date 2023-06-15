$(window).scroll(function() {
	var scroll = $(window).scrollTop();
	//console.log(scroll);
	if (scroll >= 50) {
		//console.log('a');
		$(".logo span").addClass("active");
	} else {
		//console.log('a');
		$(".logo span").removeClass("active");
	}
});