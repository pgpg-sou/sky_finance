# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
    $.validate();

    assemble = (selector, total) ->
        select = parseInt($(selector).val())
        total_value = parseInt($(total).val())
        $(total).val(select + total_value)

    $('#texable_income').change( ->
        texable_income = parseInt($('#texable_income').val())
        total_income = parseInt($('#total_income').val())
        $('#total_income').val(total_income + texable_income)
    )
    $('#any_other_income').change( ->
        any_other_income = parseInt($('#any_other_income').val())
        total_income = parseInt($('#total_income').val())
        $('#total_income').val(total_income + any_other_income)
    )
    $('#mortage_rent_board').change( ->
        mortage_rent_board = parseInt($('#mortage_rent_board').val())
        total_expenses = parseInt($('#total_expenses').val())
        $('#total_expenses').val(total_expenses + mortage_rent_board)
    )
    $('#loans_and_hps').change( ->
        mortage_rent_board = parseInt($('#loans_and_hps').val())
        total_expenses = parseInt($('#total_expenses').val())
        $('#total_expenses').val(total_expenses + mortage_rent_board)
    )
    $('#living').change( ->
        mortage_rent_board = parseInt($('#living').val())
        total_expenses = parseInt($('#total_expenses').val())
        $('#total_expenses').val(total_expenses + mortage_rent_board)
    )
    $('#child_support').change( ->
        mortage_rent_board = parseInt($('#child_support').val())
        total_expenses = parseInt($('#total_expenses').val())
        $('#total_expenses').val(total_expenses + mortage_rent_board)
    )
    $('#credit_card').change( ->
        mortage_rent_board = parseInt($('#credit_card').val())
        total_expenses = parseInt($('#total_expenses').val())
        $('#total_expenses').val(total_expenses + mortage_rent_board)
    )

    $('#home').change( ->
        assemble('#home', '#total_assets')
    )
    $('#investment').change( ->
        assemble('#investment', '#total_assets')
    )
    $('#money_in_bank').change( ->
        assemble('#money_in_bank', '#total_assets')
    )

    $('#rental_property').change( ->
        assemble('#rental_property', '#total_assets')
    )

    $('#vehicle').change( ->
        assemble('#vehicle', '#total_assets')
    )
    $('#furniture').change( ->
        assemble('#furniture', '#total_assets')
    )
    $('#jewelry').change( ->
        assemble('#jewelry', '#total_assets')
    )
    $('#other').change( ->
        assemble('#other', '#total_assets')
    )









    update_radio_box = (selector, _this) ->
        selector.each ->
            $(this).find('label').removeClass("error-check")
            $(this).find('label').removeClass("checked")
            $(this).find('label').addClass("unselected")
            $(this).find('input[name=title]').removeAttr('checked')
        $(_this).find('label').removeClass("error-check")
        $(_this).find('label').removeClass("unselected")
        $(_this).find('label').addClass("checked")
        $(_this).find('input[name=title]').attr('checked', 'checked')


    $('li.radio.driver_licence').click ->
        $('#title_error').css("display","none")
        update_radio_box($('li.radio.driver_licence'), this)

    $('li.radio.residential_status').click ->
        $('#title_error').css("display","none")
        update_radio_box($('li.radio.residential_status'), this)

    $('li.radio.how_long_lived').click ->
        update_radio_box($('li.radio.how_long_lived'), this)

    $('li.radio.how_long_lived_here').click ->
        update_radio_box($('li.radio.how_long_lived_here'), this)

    $('li.radio.how_long_employed').click ->
        update_radio_box($('li.radio.how_long_employed'), this)

    $('li.radio.how_long_employed2').click ->
        update_radio_box($('li.radio.how_long_employed2'), this)

    $('li.radio.self_employed').click ->
        update_radio_box($('li.radio.self_employed'), this)
    
    $('li.radio.income').click ->
        update_radio_box($('li.radio.income'), this)
 
    total_income = $('#texable_income').val() + $('#any_other_income').val()
    $('#total_income').val()


    $('#apply_send').click ->
        arg = new Object
        application = new Object
        $('.form-group').each ->
            application[$(this).find('input').attr('name')] = $(this).find('input').val()

        $('li.radio').each ->
            if $(this).find('label').hasClass('checked')
                console.log $(this).find('label').attr("value")
                console.log $(this).find('label').val()
                application["title"] = $(this).find('label').attr("value")
        arg["application"] = application

        if application["email"] == ""
            alert("メールアドレスを入力してください")
        else
            $.ajax({
                 type:   "POST",
                 url:    "apply_mail",
                 data: arg,
                 }).done((data) ->
                     alert("メール送信しました")
                     return
                 )

    select_box_value = (selector) ->
        result_text = ""
        $(selector).each ->
            if $(this).find('label').hasClass('checked')
                result_text = $(this).find('label').attr("value")
                if result_text == undefined
                    result_text = $(this).find('input').val()

                #application["title"] = $(this).find('label').attr("value")
        return result_text

    select_validate_check = (selector) ->
        if select_box_value(selector) == ""
            $(selector).each ->
                $(this).find('label').removeClass("unselected")
                $(this).find('label').addClass("error-check")

            return false
        else 
            return true

    input_validate_check = (selector) ->
        if $(selector).val() == ""
            console.log $(selector)
            $(selector).addClass("error")
            return false
        else
            return true


    validate_result = (array) ->
        test = true
        $.each(array,(index,val) ->
            if val == false
                test = false
        );
        return test


    $('#fase1').click ->
        ids = ["[name=no_of_dependent_children]", "#first_name", "#middle_name", "#sur_name", "#date_of_birth", "#ird_number", "#home_phone", "#mobile_phone", "#material_status"]
        validates = []
        name = parseInt($(this).attr("name"))

        validates.push(select_validate_check('li.radio.driver_licence'))
        validates.push(select_validate_check('li.radio.residential_status'))

        $.each(ids,(index,val) ->
            validates.push(input_validate_check(val))
        );

        if validate_result(validates) == true
            $('#about_you_error').css("display","none")
            $('li.q').each((index) ->
                if name == (index+1)
                    $(this).next().slideToggle(500)
                    $(this).toggleClass('active')
            )
        else
            $('#about_you_error').css("display","block")
            speed = 400; 
            target = $("#about_you_title");
            position = target.offset().top;
            $('body, html').animate({scrollTop:position}, speed, 'swing');



    $('#fase2').click ->
        ids = ["#postal_address", "#previous_address", "#previous_address_phone", "#previous_address_name", "#previous_address_address"]
        validates = []
        name = parseInt($(this).attr("name"))
        validates.push(select_validate_check('li.radio.how_long_lived'))
        validates.push(select_validate_check('li.radio.how_long_lived_here'))

        $.each(ids,(index,val) ->
            validates.push(input_validate_check(val))
        );


        if validate_result(validates) == true
            $('#home_address_title').css("display","none")
            $('li.q').each((index) ->
                if name == (index+1)
                    $(this).next().slideToggle(500)
                    $(this).toggleClass('active')
            )
        else
            $('#home_address_error').css("display","block")
            speed = 400; 
            target = $("#home_address_title");
            position = target.offset().top;
            $('body, html').animate({scrollTop:position}, speed, 'swing');





    $('#fase3').click ->
        name = parseInt($(this).attr("name"))
        $('li.q').each((index) ->
            if name == (index+1)
                $(this).next().slideToggle(500)
                $(this).toggleClass('active')
        )

    $('#fase4').click ->
        name = parseInt($(this).attr("name"))
        $('li.q').each((index) ->
            if name == (index+1)
                $(this).next().slideToggle(500)
                $(this).toggleClass('active')
        )
    $('#fase5').click ->
        name = parseInt($(this).attr("name"))
        $('li.q').each((index) ->
            if name == (index+1)
                $(this).next().slideToggle(500)
                $(this).toggleClass('active')
        )








