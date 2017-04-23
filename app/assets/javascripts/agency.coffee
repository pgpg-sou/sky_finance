
$(document).ready ->

    select_box_value = (selector) ->
        result_text = ""
        $(selector).each ->
            if $(this).find('label').hasClass('checked')
                result_text = $(this).find('label').attr("value")
                if result_text == undefined
                    result_text = $(this).find('input').val()

                #application["title"] = $(this).find('label').attr("value")
        return result_text

    select_box_input_value = (input_id) ->
        result_text = $(input_id).val()
        if result_text == ""
            result_text = 0
        else
            result_text = parseInt(result_text)


        return result_text

    get_liabilities = (selector) ->
        argument = new Object
        $(selector).find('input').each ->
            id = $(this).attr('id')
            argument[id] = $(this).val()
        return argument
       



    $('#apply_now').click ->
        $.extend($.validator.message, {
            required: "入力必須です"
        })

        rules = {
            first_name: {required: true}
        };

        messages = {
            first_name: {
                required: "入力必須です"
            },
            middle_name: {
                required: "入力必須です"
            }
        }

        $('form').validate({
        })

        has = false
        $('li.radio').each ->
            if $(this).find('label').hasClass("checked")
                has = true

        if has == false
            $('#title_error').css("display","block")
            $('li.radio').each ->
                $(this).find('label').removeClass("unselected")
                $(this).find('label').addClass("error-check")

        arg = new Object

        ##### About you Section #####
        arg["email"] = "itosouplus@gmail.com"
        arg["title"] = $('[name=no_of_dependent_children]').val();
        arg["first_name"] = $('#first_name').val()
        arg["middle_name"] = $('#middle_name').val()
        arg["last_name"] = $('#sur_name').val()
        arg["date_of_birth"] = $('#date_of_birth').val()
        arg["ird_number"] = $('#ird_number').val()
        arg["home_phone"] = $('#home_phone').val()
        arg["mobile_phone"] = $('#mobile_phone').val()
        arg["material_status"] = $('#material_status').val()


        arg["driver_licence"] = select_box_value('li.radio.driver_licence')
        arg["residential_status"] = select_box_value('li.radio.residential_status')
     
        ##### Home Address Section #####
        arg["postal_address"] = $('#postal_address').val()
        arg["previous_address"] = $('#previous_address').val()
        arg["previous_address_name"] = $('#previous_address_phone').val()
        arg["previous_address_phone"] = $('#previous_address_phone').val()
        arg["previous_address_address"] = $('#previous_address_address').val()

        arg["how_long_have_you_lived"] = select_box_value('li.radio.how_long_lived')
        arg["how_long_lived_here"] = select_box_value('li.radio.how_long_lived_here')
    
        console.log select_box_value('li.radio.how_long_lived') 
     
        ##### Employment Section #####
        arg["occupation"] = $('#occupation').val()
        arg["employer_name"] = $('#employer_name').val()
        arg["employer_address"] = $('#employer_address').val()
        arg["employer_phone"] = $('#employer_phone').val()

        arg["how_long_employed"] = select_box_value('li.radio.how_long_employed')
        arg["previous_employer"] = $('#previous_employer').val()
        arg["how_long_employed2"] = select_box_value('li.radio.how_long_employed2')
        arg["self_employed"] = select_box_value('li.radio.self_employed')
        arg["your_account"] = $('#your_account').val()


        ##### Monthly Income & Expense
        arg["texable_income"] = select_box_input_value("#texable_income")
        arg["any_other_income"] = select_box_input_value("#any_other_income")
        arg["mortage_rent_board"] = select_box_input_value("#mortage_rent_board")
        arg["loans_and_hps"] = select_box_input_value("#loans_and_hps")
        arg["credit_card"] = select_box_input_value("#credit_card")
        arg["living"] = select_box_input_value("#living")
        arg["child_support"] = select_box_input_value("#child_support")

        arg["total_income"] = select_box_input_value("#total_income")
        arg["total_expenses"] = select_box_input_value("#total_expenses")
    
 
 
        ##### Your Assets
        arg["home"] = select_box_input_value("#home")
        arg["rental_property"] = select_box_input_value("#rental_property")
        arg["investment"] = select_box_input_value("#investment")
        arg["money_in_bank"] = select_box_input_value("#money_in_bank")
        arg["vehicle"] = select_box_input_value("#vehicle")
        arg["furniture"] = select_box_input_value("#furniture")
        arg["jewelry"] = select_box_input_value("#jewelry")
        arg["other"] = select_box_input_value("#other")

        arg["total_assets"] = select_box_input_value("#total_assets")

        ##### your liabilities Section ######
        arg["mortages"] = get_liabilities('#mortages')
    
    
     
      
        $.ajax({
             type:   "POST",
             url:    "apply_mail",
             data: arg,
             }).done((data) ->
                 alert("メール送信しました")
                 return
             )





    
    $('.input-mask').inputmask({
          mask: '99/99/9999'
    })
    $('.input-mask-phone').inputmask({
        mask: '(999) 999-9999'
    })
    $('.input-mask-texable_income').inputmask({
        mask: '$ 999,999'
    })

