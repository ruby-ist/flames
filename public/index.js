$("document").ready(function(){
	$("input.nameBox").on("focus.test",function(){
		$(this).css("outline","none");
		$(this).css("border","2px solid transparent");
		$(this).css("background","-webkit-linear-gradient(#F8F2ED,#F8F2ED) padding-box, -webkit-linear-gradient(300deg,#F87B35,#EFC942) border-box");
	});

	$("input.nameBox").focusout(function(){
		if(!$(this).val()){
			$(this).css("border","1px solid black");
		}
	});

	$("#about-btn").click(function(){
		$("body").css("overflow","hidden");
		$("#cover").css("display","block");
		$("#about").css("right","0vw")
	});

	$("#about-close-btn, #cover").click(function(){
		$("body").css("overflow","auto");
		$("#cover").css("display","none");
		$("#about").css("right","-63vw")
	})

	$("#copyrights-btn").click(function(){
		$("body").css("overflow","hidden");
		$("#cover").css("display","block");
		$("#copyrights").css("right","0vw")
	});

	$("#copyrights-close-btn, #cover").click(function(){
		$("body").css("overflow","auto");
		$("#cover").css("display","none");
		$("#copyrights").css("right","-63vw")
	});

	var arr = ["f","l","a","m","e","s"];

	arr.forEach((i) => {
		var letter = "#" + i;
		var letterPop = "#" + i + "-pop";

		$(letter).hover(function(){
			$(letterPop).css("visibility","visible");
		},function(){
			$(letterPop).css("visibility","hidden");
		});
	});
	
});

