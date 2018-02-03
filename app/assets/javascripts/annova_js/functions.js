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

function undefined_str(obj) {
    if(obj != null) {
        return obj
    } else {
        return ""
    }
}
jQuery(function($) {
    //  Basic wizard with validation
    survey_container =$("#survey_container").wizard({
        stepsWrapper: "#wrapped",
        submit: ".submit",
        beforeSelect: function( event, state ) {
            if (!state.isMovingForward)
             return true;
            
            var inputs = $(this).wizard('state').step.find(':input:visible');
            var ul_tags = $(this).wizard('state').step.find('ul.select_form_tag:visible');
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
            if(state["isMovingForward"] == false && state["stepIndex"] == 6) {
                $('.wizard-progress .w_step').last().removeClass("complete").addClass("in-progress")
            } else if(state["isMovingForward"] == true) {
                $('.wizard-progress .w_step').each(function() {
                    if(next_step_state == true) {
                        $(this).addClass("in-progress")
                        next_step_state = false
                    } else if ($(this).hasClass("in-progress") == true) {
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
            if(state["stepIndex"] == 7) {
                f_d = window.post_form_data

                // Your Information
                $('p#c_title').text(undefined_str(f_d["title"]) + " " + undefined_str(f_d["first_name"]) + " " + undefined_str(f_d["middle_name"]) + " " + undefined_str(f_d["sur_name"]))
                $('p#c_gender').text(f_d["gender"])
                $('p#c_date_of_birth').text(f_d["date_of_birth"])
                $('p#c_material_status').text(f_d["material_status"])
                $('p#c_dependents').text(f_d["dependentsCount"])
                $('p#c_dependents_age').text(f_d["dependentsAge"])
                $('p#c_phone').text(f_d["home_phone"])
                $('p#c_driver').text(f_d["driver_licence_number"])
                $('p#c_driver_version').text(f_d["driver_licence_version"])
                $('p#c_driver_country').text(f_d["driver_licence_country"])
                $('p#c_driver_type').text(f_d["driver_licence"])
                $('p#c_expire').text(f_d["driver_licence_expire_date"])
                $('p#c_last_entry').text(f_d["last_entry_date"])
                $('p#c_email').text(f_d["e_mail_address"])
                $('p#c_resident_status').text(f_d["residential_status"])
                $('p#c_visa_expire').text(f_d["visa_expire_date"])
                $('p#c_nearest_name').text(undefined_str(f_d["nearest_first_name"]) + " " + undefined_str(f_d["nearest_last_name"]))
                $('p#c_nearest_address').text(f_d["nearest_address"])
                $('p#c_nearest_phone').text(f_d["nearest_phone_number"])
                $('p#c_nearest_relation').text(f_d["relation_ship"])

               
                if(f_d["joint_applicant_exist"] == "No") {
                    $('#c_joint_form').css("display", "none")
                    $('#c_there_joint').text(f_d["joint_applicant_exist"])
                } else {
                    $('#c_there_joint').text(f_d["joint_applicant_exist"])
                    $('p#c_joint_title').text(undefined_str(f_d["joint_applicant_title"]) + " " + undefined_str(f_d["joint_applicant_first_name"]) + " " + undefined_str(f_d["joint_applicant_middle_name"]) + " " + undefined_str(f_d["joint_applicant_sur_name"]))
                    $('p#c_joint_gender').text(f_d["joint_applicant_gender"])
                    $('p#c_joint_date_of_birth').text(f_d["joint_applicant_date_of_birth"])
                    $('p#c_joint_material_status').text(f_d["joint_applicant_material_status"])
                    $('p#c_joint_dependents').text(f_d["joint_applicant_dependentsCount"])
                    $('p#c_joint_dependents_age').text(f_d["joint_applicant_dependentsCount"])
                    $('p#c_joint_phone').text(f_d["joint_applicant_home_phone"])
                    $('p#c_joint_driver').text(f_d["joint_applicant_driver_licence_number"])
                    $('p#c_joint_driver_version').text(f_d["joint_applicant_driver_licence_version"])
                    $('p#c_joint_driver_country').text(f_d["joint_applicant_driver_licence_country"])
                    $('p#c_joint_driver_type').text(f_d["joint_applicant_driver_licence"])
                    $('p#c_joint_expire').text(f_d["joint_applicant_visa_expire_date"])
                    $('p#c_joint_last_entry').text(f_d["joint_applicant_last_entry_date"])
                    $('p#c_joint_email').text(f_d["joint_applicant_e_mail_address"])
                    $('p#c_joint_resident_status').text(f_d["joint_applicant_residential_status"])
                    $('p#c_joint_visa_expire').text(f_d["joint_applicant_visa_expire_date"])

                }

               
               
               
                
                // Your Information
                $('p#c_tenancy').text(f_d["tenancy_status"])
                $('p#c_current_address').text(f_d["postal_address"])
                $('p#c_current_live_long').text(f_d["living_period"])
                $('p#c_previous_address').text(f_d["previous_address"])
                $('p#c_previous_live_long').text(f_d["previous_living_period"])
                $('p#c_current_company').text(f_d["current_company"])
                $('p#c_current_company_address').text(f_d["current_company_address"])
                $('p#c_employtype').text(f_d["employtype"])
                $('p#c_current_employer_phone').text(f_d["current_phone_number"])
                $('p#c_current_occupation').text(f_d["current_occupation"])
                $('p#c_how_long_work').text(f_d["how_long_work"])
                $('p#c_previous_company').text(f_d["previous_company"])
                $('p#c_previous_occupation').text(f_d["previous_occupation"])
                $('p#c_previous_employtype').text(f_d["previous_employtype"])
                $('p#c_how_long_work_previous').text(f_d["how_long_work_previous"])


                // Assets Information
                //f_d["assets_form"]
                other = ""
                if(f_d["assets_form"] != null) {
                    $.each(f_d["assets_form"], function(key, val) {
                        other += key + "   $" + val + "</br>"
                    });
                } 
                $('p#c_a_home').text("$" + undefined_str(f_d["assets_home"]))
                $('p#c_a_furnishing').text("$" + undefined_str(f_d["assets_furnishing"]))
                $('p#c_a_bank_account').text("$" + undefined_str(f_d["assets_bank_account"]))
                $('p#c_a_car').text("$" + undefined_str(f_d["assets_car"]))
                $('p#c_a_investment').text("$" + undefined_str(f_d["assets_investments"]))
                $('p#c_a_other').html(other)
                $('p#c_a_total').text(undefined_str(f_d["total_num_assets"]) + "assets  $ " + undefined_str(f_d["total_assets"]))
                $('p#c_how_much_borrow').text("$" + undefined_str(f_d["how_much_borrow"]))
                $('p#c_how_long_pay_off').text(undefined_str(f_d["how_long_pay_off"]) + " years")


                // Liability Information
                other = ""
                if(f_d["liability_form"] != null) {
                    $.each(f_d["liability_form"], function(key, val) {
                        other += key + "   $" + val + "</br>"
                    });
                }
                $('p#c_morgage').text("$" + undefined_str(f_d["liability_morgage"]))
                $('p#c_car_finance').text("$" + undefined_str(f_d["liability_car"]))
                $('p#c_credit_card').text("$" + undefined_str(f_d["liability_creditcard"]))
                $('p#c_back_account').text("$" + undefined_str(f_d["liability_bankod"]))
                $('p#c_l_other').html(other)
                $('p#c_l_total').text(undefined_str(f_d["total_liability_num"]) + " Liabilities 　 $" + undefined_str(f_d["total_liability_info"]))

                // Other Information
                other = ""
                if(f_d["income_form"] != null) {
                    $.each(f_d["income_form"], function(key, obj) {
                        $.each(obj, function(k,v) {
                            if(k == "period_") {
                                other += v + "　"
                            } else {
                                other += k + " 　$" + v + "</br>"
                            }
                        })
                    });
                }
                console.log(other)
                $('p#c_income_other').html(other)
                $('p#c_total_income').text(undefined_str(f_d["total_income_num"]) + " Incomes 　 $" + undefined_str(f_d["total_income_other"]))
                $('p#c_income_expence').text(undefined_str(f_d["expences_morgage"]) + "   $ " + undefined_str(f_d["liability_morgage"]))
                $('p#c_income_hpcredit').text(undefined_str(f_d["expences_hp_credit"]) + "   $ " + undefined_str(f_d["liability_creditcard"]))
                $('p#c_income_living').text(undefined_str(f_d["expences_living"]) + "   $ " + undefined_str(f_d["liability_bankod"]))
                $('p#c_income_insurance').text("$ " + undefined_str(f_d["liability_insurance"]))
            }
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


