
$(document).ready ->
    window.post_form_data = new Object 

    $('button.forward').click( ->
        $(".step.wizard-step.current li#application input").each( ->
            if $(this).attr("id") == "dependentsAge"
                result = ""
                $("input#dependentsAge").each( ->
                    result += $(this).val() + ","
                )
                window.post_form_data["dependentsAge"] = result.slice(0,-1)

            else if $(this).parent().parent().hasClass("custom_form")
            else 
                window.post_form_data[$(this).attr('id')] = $(this).val()

        )
        $(".step.wizard-step.current li#application ul").each( ->
            if $(this).find("li.active").hasClass('other')
                window.post_form_data[$(this).attr('id')] = $(this).find("li.active").find("input").val()
            else 
                window.post_form_data[$(this).attr('id')] = $(this).find("li.active").attr("value")
        )
        $(".step.wizard-step.current .custome_form").each( ->
            custom_data = new Object
            key = ""
            
            if $(this).attr("id") == "income_form"
                $(this).find('div#i_form').each((i, val) ->
                    k = "income_other_" + i

                    d = new Object
                    $(this).find("ul").each( ->
                        d["period_"] = $(this).find("li.active").attr("value")
                    )

                    $(this).find("input").each( (index, element) ->
                        if (index % 2) == 0
                            key = $(this).val()
                        else 
                            d[key] = $(this).val()
                            key = ""
                    )
                    custom_data[k] = d
                )

                window.post_form_data[$(this).attr("id")] = custom_data
            else 
                $(this).find("input").each( (index, element) ->
                    if (index % 2) == 0
                        key = $(this).val()
                    else 
                        custom_data[key] = $(this).val()
                        key = ""
                )
                window.post_form_data[$(this).attr("id")] = custom_data
        )

        console.log window.post_form_data
    )


    $('#application_submit').click( ->
        #post_from_data = JSON.stringify('{"first_name"=>"ito", "middle_name"=>"middle", "sur_name"=>"soichiro", "e_mail_address"=>"ito@fig-leaves.bz", "date_of_birth"=>"11/11/1111", "dependentsCount"=>"1", "dependentsAge"=>"23", "home_phone"=>"0368510921", "driver_licence_number"=>"12", "driver_licence_version"=>"21", "driver_licence_country"=>"Japan", "driver_licence_expire_date"=>"22/22/2222", "citizen_ship"=>"IN", "last_entry_date"=>"33/33/3333", "visa_expire_date"=>"33/33/3333", "nearest_first_name"=>"1fe", "nearest_last_name"=>"gi", "nearest_address"=>"875 Grove Burn Road, Grove Burn 9691", "nearest_phone_number"=>"0368510921", "title"=>"Mrs", "gender"=>"female", "material_status"=>"separated", "driver_licence"=>"Restrictad", "residential_status"=>"citizen", "relation_ship"=>"granddaughter", "joint_applicant_first_name"=>"", "joint_applicant_middle_name"=>"", "joint_applicant_sur_name"=>"", "joint_applicant_e_mail_address"=>"", "joint_applicant_date_of_birth"=>"", "joint_applicant_home_phone"=>"", "joint_applicant_driver_licence_version"=>"", "joint_applicant_driver_licence_country"=>"", "joint_applicant_drivers_licence_expire_date"=>"", "joint_applicant_citizen_ship"=>"", "joint_applicant_last_entry_date"=>"", "joint_applicant_visa_expire_date"=>"", "joint_applicant_exist"=>"No", "postal_address"=>"PO Box 2114, Taupo 3351", "undefined"=>"", "previous_address"=>"PO Box 2109, Taupo 3351", "current_company"=>"Cancer Society Of New Zealand Inc", "current_company_address"=>"1111A Oropi Road, Oropi 3173", "current_phone_number"=>"(06) 3487402", "current_occupation"=>"direct", "previous_company"=>"", "previous_occupation"=>"", "tenancy_status"=>"Living with Relative", "living_period"=>"1 year", "previous_living_period"=>"1 year", "employtype"=>"seasonal", "how_long_work"=>"1 year", "agree_conset_policy"=>"", "assets_home"=>"100", "assets_furnishing"=>"200", "assets_bank_account"=>"100", "assets_car"=>"001", "assets_investments"=>"100", "other_assets_name"=>"", "other_assets"=>"", "total_assets"=>"501", "total_num_assets"=>"5", "how_much_borrow"=>"1000", "how_long_pay_off"=>"10", "assets_form"=>[""], "liability_morgage"=>"100", "liability_car"=>"100", "liability_creditcard"=>"100", "liability_bankod"=>"100", "liability_other"=>"", "liability"=>"", "total_liability_info"=>"400", "total_liability_num"=>"4", "liability_form"=>[""], "income_name"=>"", "income"=>"", "total_income_other"=>"", "total_income_num"=>"", "expences_morgage"=>"", "expences_creditcard"=>"", "expences_bankod"=>"", "expences_insurance"=>"", "income_form"=>{"income_other_0"=>[""]}}')
        $.ajax({
            type:   "POST",
            url:    "/home/application_saver",
            data: window.post_form_data,
            success: (data) -> 
                console.log(data)
                if data["status"] == "500"
                    swal({
                      type: 'error',
                      title: 'Oops...',
                      text: 'Something went wrong!',
                    })
                else if data["status"] == "200"
                    swal(
                      'Good job!',
                      'Succeed sent your application information.',
                      'success'
                    ).then((result) ->
                        window.location = "/"
                    )
            ,
            error: (error) -> 
                swal({
                  type: 'error',
                  title: 'Oops...',
                  text: 'Something went wrong!',
                })
            })
    )


