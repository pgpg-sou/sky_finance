# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
    #$.validate();

    initAF = () -> 
        widget = new AddressFinder.Widget(
            document.getElementById('postal_address'),
            'GJ8U3Y7FWET4PB6NCXMH',
            'NZ'
        );
        widget.on('result:select', (fullAddress, metaData) ->
            selected = new AddressFinder.NZSelectedAddress(fullAddress, metaData)
        ) 
    initAF_2 = () -> 
        widget = new AddressFinder.Widget(
            document.getElementById('previous_address'),
            'GJ8U3Y7FWET4PB6NCXMH',
            'NZ'
        );
        widget.on('result:select', (fullAddress, metaData) ->
            selected = new AddressFinder.NZSelectedAddress(fullAddress, metaData)
        )
    initAF_3 = () -> 
        widget = new AddressFinder.Widget(
            document.getElementById('current_company_address'),
            'GJ8U3Y7FWET4PB6NCXMH',
            'NZ'
        );
        widget.on('result:select', (fullAddress, metaData) ->
            selected = new AddressFinder.NZSelectedAddress(fullAddress, metaData)
        )
    initAF_4 = () -> 
        widget = new AddressFinder.Widget(
            document.getElementById('previous_company_address'),
            'GJ8U3Y7FWET4PB6NCXMH',
            'NZ'
        );
        widget.on('result:select', (fullAddress, metaData) ->
            selected = new AddressFinder.NZSelectedAddress(fullAddress, metaData)
        )
     initAF_5 = () -> 
        widget = new AddressFinder.Widget(
            document.getElementById('nearest_address'),
            'GJ8U3Y7FWET4PB6NCXMH',
            'NZ'
        );
        widget.on('result:select', (fullAddress, metaData) ->
            selected = new AddressFinder.NZSelectedAddress(fullAddress, metaData)
        )

    $.getScript('https://api.addressfinder.io/assets/v3/widget.js', initAF);
    $.getScript('https://api.addressfinder.io/assets/v3/widget.js', initAF_2);
    $.getScript('https://api.addressfinder.io/assets/v3/widget.js', initAF_3);
    $.getScript('https://api.addressfinder.io/assets/v3/widget.js', initAF_4);
    $.getScript('https://api.addressfinder.io/assets/v3/widget.js', initAF_5);



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
    width = $('#current_company').width() 
    $('#ui-id-1').css({'cssText': 'width: ' + width + ' !important;'})

    $(document).on('keyup', '#current_company', (e) ->
        arg = new Object
        arg["name"] = $(this).val()
        $.ajax({
            type:   "POST",
            url:    "/business/search",
            data: arg,
            }).done((data) -> 
                business_list = []
                $.each(data, (index, d) ->
                    json = {"id" : d["id"], "name": d["name"], "value": d["name"], "phone": d["phone"], "address": d["address"]}
                    business_list.push(json)
                )
                $('#current_company').autocomplete({
                    minLength: 0,
                    source: business_list,
                    select:  (e, ui) ->
                        $('#current_phone_number').val(ui["item"]["phone"]).addClass("valid")
                        $('#current_company_address').val(ui["item"]["address"]).addClass("valid")
                    ,
                    open:  ->
                        $("ul.ui-menu").width( $(this).innerWidth() );

                }).focus( -> 
                )

                return
            )
    );
    width = $('#previous_company').width() 
    $('#ui-id-1').css({'cssText': 'width: ' + width + ' !important;'})

    $(document).on('keyup', '#previous_company', (e) ->
        arg = new Object
        arg["name"] = $(this).val()
        $.ajax({
            type:   "POST",
            url:    "/business/search",
            data: arg,
            }).done((data) -> 
                business_list = []
                $.each(data, (index, d) ->
                    json = {"id" : d["id"], "name": d["name"], "value": d["name"], "phone": d["phone"], "address": d["address"]}
                    business_list.push(json)
                )
                $('#previous_company').autocomplete({
                    minLength: 0,
                    source: business_list,
                    select:  (e, ui) ->
                        $('#previous_company_address').val(ui["item"]["address"]).addClass("valid")
                    ,
                    open:  ->
                        $("ul.ui-menu").width( $(this).innerWidth() );

                }).focus( -> 
                )

                return
            )
    );


    $(document).on('keyup', '#company_name', (e) ->
        arg = new Object
        arg["name"] = $(this).val()
        $.ajax({
            type:   "POST",
            url:    "/business/search",
            data: arg,
            }).done((data) -> 
                business_list = []
                $.each(data, (index, d) ->
                    json = {"id" : d["id"], "name": d["name"], "value": d["name"], "phone": d["phone"], "address": d["address"], "website": d["website"], "category": d["category"], "sub_category_1": d["sub_category_1"], "e-mail": d["email"]}
                    business_list.push(json)
                )
                $('#company_name').autocomplete({
                    minLength: 0,
                    source: business_list,
                    select:  (e, ui) ->
                        $('#company_address').val(ui["item"]["address"]).addClass("valid")
                        $('#company_tel').val(ui["item"]["phone"]).addClass("valid")
                        $('#company_email').val(ui["item"]["email"]).addClass("valid")
                        $('#company_website').val(ui["item"]["website"]).addClass("valid")
                        $('#business_main_category').val(ui["item"]["category"]).addClass("valid")
                        $('#business_sub_category').val(ui["item"]["sub_category_1"]).addClass("valid")
                    ,
                    open:  ->
                        $("ul.ui-menu").width( $(this).innerWidth() );

                }).focus( -> 
                )

                return
            )
    );





 


    ##############################################################################
    ###  SELECT FORM RADIO BOX SETTING 
    ##############################################################################
    initialize_radio_box = (selector) ->
        selector.each ->
            $(this).find('label').removeClass("error-check")
            $(this).find('label').removeClass("checked")
            $(this).find('label').addClass("unselected")
            $(this).find('input[name=title]').removeAttr('checked')

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
    
    $('li.radio.material_status').click ->
        update_radio_box($('li.radio.material_status'), this)
    
    $('li.radio.material_status').click ->
        update_radio_box($('li.radio.material_status'), this)
    
    $('li.radio.tenancy_status').click ->
        update_radio_box($('li.radio.tenancy_status'), this)
    
    $('li.radio.employmentStatusfullTime').click ->
        update_radio_box($('li.radio.employmentStatusfullTime'), this)

    $('li.radio.employment_previous_address').click ->
        update_radio_box($('li.radio.employment_previous_address'), this)

    $('li.radio.how_long_work').click ->
        update_radio_box($('li.radio.how_long_work'), this)
    
    $('li.radio.how_long_work_previous').click ->
        update_radio_box($('li.radio.how_long_work_previous'), this)

    $('li.radio.credit_rating').click ->
        update_radio_box($('li.radio.credit_rating'), this)

    $('li.radio.relation_ship').click ->
        update_radio_box($('li.radio.relation_ship'), this)

    ##############################################################################
    ###  END   
    ##############################################################################


 
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



    $('ul#recommend_tag_list li').click ->
        $('ul#recommend_tag_list li').each ->
            $(this).removeClass('active')
        $(this).addClass('active')


    $('ul#title_tag_list li').click ->
        $('ul#title_tag_list li').each ->
            $(this).removeClass('active')
        $(this).addClass('active')


    $('ul#material_status li').click ->
        $('ul#material_status li').each ->
            $(this).removeClass('active')
        $(this).addClass('active')


    $('ul#title li').click ->
        $('ul#title li').each ->
            $(this).removeClass('active')
        $(this).addClass('active')


    $('ul#gender li').click ->
        $('ul#gender li').each ->
            $(this).removeClass('active')
        $(this).addClass('active')

    $('ul#residential_status li').click ->
        $('ul#gender li').each ->
            $(this).removeClass('active')
        $(this).addClass('active')

    Dropzone.autoDiscover = false
    $("div.dropzone").dropzone({ 
        url: "/home/upload_file",
        maxFiles: 2,
        success: (file, data) ->
          console.log data 
          console.log data["driver_licence"]
          driver_licence = $.parseJSON(data["driver_licence"])
          words = data["words"]
          
          $('input#first_name').val(driver_licence["first_name"]).addClass("valid")
          $('input#sur_name').val(driver_licence["last_name"]).addClass("valid")
          $('input#date_of_birth').val(driver_licence["birth_date"]).addClass("valid")
           
          $('input#driver_licence').val(driver_licence["driver_licence_no"]).addClass("valid")
          $('input#driver_licence_version').val(driver_licence["card_version_no"]).addClass("valid")
          $('input#drivers_licence_expire_date').val(driver_licence["expire_date"]).addClass("valid")

          #console.log words.join(",")
          $.each(words, (index, word) ->
              #$('ul#tag_list').append("<li><a class='btn btn-primary btn-rounded'>" + word + "</a></li>")
          )

    })
    $("div.visa_dropzone").dropzone({ 
        url: "/home/upload_file_visa",
        maxFiles: 2,
        success: (file, data) ->
          console.log data 
          console.log data["driver_licence"]
          driver_licence = $.parseJSON(data["driver_licence"])
          words = data["words"]
          
          $('input#first_name').val(driver_licence["first_name"]).addClass("valid")
          $('input#sur_name').val(driver_licence["last_name"]).addClass("valid")
          $('input#date_of_birth').val(driver_licence["birth_date"]).addClass("valid")
           
          $('input#driver_licence').val(driver_licence["driver_licence_no"]).addClass("valid")
          $('input#driver_licence_version').val(driver_licence["card_version_no"]).addClass("valid")
          $('input#drivers_licence_expire_date').val(driver_licence["expire_date"]).addClass("valid")

          #console.log words.join(",")
          $.each(words, (index, word) ->
              #$('ul#tag_list').append("<li><a class='btn btn-primary btn-rounded'>" + word + "</a></li>")
          )

    })

    #Dropzone.options.myDropZoneForm = {
    #    url: 'url/here',
    #    autoProcessQueue: false,
    #    uploadMultiple: true,
    #    parallelUploads: 100,       
    #    addRemoveLinks: true,
    #    uploadMultiple: true,
    #    acceptedFiles: 'image/*, audio/*, video/*',
    #    maxFiles: 10,
    #    init:  () ->
    #        vthisDropzone = this;
    #
    #        this.on('addedfile', (file) ->
    #            console.log "added file"
    #            #totalFiles += 1;
    #            #totalFilesFormatted = totalFiles.toFixed(2);
    #            #$('#showTotalFileCount').html(totalFilesFormatted);
    #        );
    #        #this.on('removedfile', function(file){
    #        #    totalFiles -= 1;
    #        #    totalFilesFormatted = totalFiles.toFixed(2);
    #        #    $('#showTotalFileCount').html(totalFilesFormatted);
    #        #});
    #        #this.on('maxfilesreached', function(file){
    #        #    alert('maxFiles reached');
    #        #});
    #        #this.on('maxfilesexceeded', function(file){
    #        #    alert('files dropped exceeded maxFiles');
    #        #});
    #        #this.on("sendingmultiple", function(){
    #        #    // event when files are being sent
    #        #});
    #        #this.on("successmultiple", function(files, response) {
    #        #    // event when files are successfully uploaded
    #        #    // you can return a response string and process it here through 'response'
    #        #});
    #        #this.on("errormultiple", function(files, response) {
    #        #});
    #}



