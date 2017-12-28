// SCROLL TO TOP ===============================================================================
$(function() {
	$(window).scroll(function() {
		if($(this).scrollTop() != 0) {
			$('#toTop').fadeIn();	
		} else {
			$('#toTop').fadeOut();
		}
	});
 
	$('#toTop').click(function() {
		$('body,html').animate({scrollTop:0},500);
	});	
	
});

if( window.innerWidth < 770 ) {
	$("button.forward, button.backword").click(function() {
  $("html, body").animate({ scrollTop: 115 }, "slow");
  return false;
});
}

if( window.innerWidth < 500 ) {
	$("button.forward, button.backword").click(function() {
  $("html, body").animate({ scrollTop: 245 }, "slow");
  return false;
});
}
if( window.innerWidth < 340 ) {
	$("button.forward, button.backword").click(function() {
  $("html, body").animate({ scrollTop: 280 }, "slow");
  return false;
});
}
// WIZARD  ===============================================================================
jQuery(function($) {
				//  Basic wizard with validation
				$("#survey_container").wizard({
					stepsWrapper: "#wrapped",
					submit: ".submit",
					beforeSelect: function( event, state ) {
						if (!state.isMovingForward)
  						 return true;
                        
						var inputs = $(this).wizard('state').step.find(':input');
                        var ul_tags = $(this).wizard('state').step.find('ul.select_form_tag');
                        var active_li_num = 0 
                        var is_active_ul = false 
                        $(this).wizard('state').step.find('ul.select_form_tag').each( function() {
                            var li_num = $(this).find('li').length 
                            var is_act = false 
                            $(this).find('li').each(function() {
                                if($(this).hasClass('active')) {
                                    active_li_num += 1 
                                    is_act = true 
                                }
                            })
                            if(is_act == false) {
                                $(this).find('#form_tag_error').css("display", "block")
                            } else {
                                $(this).find('#form_tag_error').css("display", "none")
                            }
                        })
                        if(ul_tags.length == active_li_num) {
                            is_active_ul = true 
                        }

						return (!inputs.length || !!inputs.valid()) && is_active_ul
					}

				}).validate({
					errorPlacement: function(error, element) { 
						if ( element.is(':radio') || element.is(':checkbox') ) {
							error.insertBefore( element.next() );

						} else { 
							error.insertAfter( element );
						}
					}
				});


				$("#survey_container").wizard({
					afterSelect: function( event, state ) {
                        var next_step_state = false 
                        // progress部分の処理
                        if(state["isMovingForward"] == false && state["stepIndex"] == 5) {
                            $('.wizard-progress .w_step').last().removeClass("complete").addClass("in-progress")
                        } else if(state["isMovingForward"] == true) {
                            $('.wizard-progress .w_step').each(function() {
                                if(next_step_state == true) {
                                    $(this).addClass("in-progress")
                                    next_step_state = false
                                } else if ($(this).hasClass("in-progress") == true) {
                                    console.log("true")
                                    $(this).removeClass("in-progress").addClass("complete")
                                    next_step_state = true
                                }
                            })
                        } else {
                            var previous_index = 0
                            $('.wizard-progress .w_step').each(function(index, element) {
                                if ($(this).hasClass("in-progress") == true) {
                                    $(this).removeClass("in-progress")
                                    previous_index = index - 1
                                }
                            })
                            $('.wizard-progress .w_step').each(function(index, element) {
                                if(index == previous_index) {
                                    $(this).removeClass("complete").addClass("in-progress")
                                }
                            })
                        }
                        $("html,body").animate({scrollTop:0},"300");



					}
				});

			});

// OHTER ===============================================================================
 $(document).ready(function(){   
    
		//Menu mobile
		$(".btn-responsive-menu").click(function() {
			$("#top-nav").slideToggle(400);
		});
		
		//Check and radio input styles
		//$('input.check_radio').iCheck({
    	//checkboxClass: 'icheckbox_square-aero',
   	    //radioClass: 'iradio_square-aero'
  		//});
		
		//Pace holder
		$('input, textarea').placeholder();
				
		//Carousel
		$("#owl-demo").owlCarousel({
 
		items : 4,
		itemsDesktop : [1199,3],
		itemsDesktopSmall : [979,3]
		 
		});
    
    });


