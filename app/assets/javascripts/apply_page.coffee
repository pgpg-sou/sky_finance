


$(document).ready ->

    $('input#e_mail_address').css("")
    get_liablity = (element) ->
        if element.val() == ""
            return 0
        else
            return parseInt(element.val())
    valid_liability_form = (element) ->
        if element.val() == ""
            return 0
        else
            return 1


############################################################################
############# 合計を出すプログラム 
############################################################################

    @update_liability_information = ()->
        total = 0
        total_num = 0
        $('#liability_information input').each( ->
            if $(this).attr('id') != "other_liability_name" && $(this).attr('id') != "total_liability" && $(this).attr('id') != "total_num_liability"
                cash = get_liablity($(this))
                if cash != 0 && cash != ""
                    total += cash
                    total_num += valid_liability_form($(this))

        )
        $('#total_liability').val(total)
        $('#total_num_liability').val(total_num)

    $('#liability_information input').blur( ->
        total = 0

        morgage = get_liablity($('#liability_morgage'))
        creditcard = get_liablity($('#liability_creditcard'))
        bankod = get_liablity($('#liability_bankod'))
        total = morgage + creditcard + bankod 
        total_num = valid_liability_form($('#liability_morgage')) + valid_liability_form($('#liability_creditcard')) + valid_liability_form($('#liability_bankod'))

        $('#liability_form input#other_liability').each(->
            total += get_liablity($(this))
            total_num += valid_liability_form($(this))
        )

        if $(this).attr('id') == "other_liability_name"
        else
            $('#total_liability').val(total)
            $('#total_num_liability').val(total_num)
    )

    @update_assets_information = ()->
        total = 0
        total_num = 0
        $('#assets_information input').each( ->
            if $(this).attr('id') != "morgage_other" && $(this).attr('id') != "total_assets_info" && $(this).attr('id') != "total_assets_num"
                cash = get_liablity($(this))
                if cash != 0 && cash != ""
                    total += cash
                    total_num += valid_liability_form($(this))

        )
        $('#total_assets_info').val(total)
        $('#total_assets_num').val(total_num)



    $('#assets_information input').blur( ->
        total = 0

        home = get_liablity($('#assets_home'))
        furnishing = get_liablity($('#assets_furnishing'))
        bank_account = get_liablity($('#assets_bank_account'))
        car = get_liablity($('#assets_car'))
        investments = get_liablity($('#assets_investments'))

        total = home + furnishing +  bank_account + car + investments
        total_num = valid_liability_form($('#assets_home')) + valid_liability_form($('#assets_furnishing')) + valid_liability_form($('#assets_bank_account')) + valid_liability_form($('#assets_car')) + valid_liability_form($('#assets_investments'))

        $('#morgages_other input#morgage').each(->
            total += get_liablity($(this))
            total_num += valid_liability_form($(this))
        )

        if $(this).attr('id') == "morgages_other"
        else
            $('#total_assets_info').val(total)
            $('#total_assets_num').val(total_num)
    )

    @update_loans_information = ()->
        total = 0
        total_num = 0
        $('#loans_information input').each( ->
            if $(this).attr('id') != "loan_company_name" && $(this).attr('id') != "total_liability" && $(this).attr('id') != "total_num"
                cash = get_liablity($(this))
                if cash != 0 && cash != ""
                    total += cash
                    total_num += valid_liability_form($(this))

        )
        $('#total_liability').val(total)
        $('#total_num').val(total_num)


    $('#loans_information input').blur( ->
        total = 0
        total_num = 0

        $('#loan_form input#loans').each(->
            total += get_liablity($(this))
            total_num += valid_liability_form($(this))
        )

        if $(this).attr('id') == "loan_company_name"
        else
            $('#total_liability').val(total)
            $('#total_num').val(total_num)

    )
    @update_income_information = ()->
        total = 0
        total_num = 0
        $('#income_information input').each( ->
            if $(this).attr('id') != "income_name" && $(this).attr('id') != "total_income_other" && $(this).attr('id') != "total_income_num"
                cash = get_liablity($(this))
                if cash != 0 && cash != ""
                    total += cash
                    total_num += valid_liability_form($(this))

        )
        $('#total_income_other').val(total)
        $('#total_income_num').val(total_num)


    $('#income_information input').blur( ->
        total = 0
        total_num = 0

        $('#income_form input#income').each( ->
            total += get_liablity($(this))
            total_num += valid_liability_form($(this))
        )

        if $(this).attr('id') == "total_income"
        else
            $('#total_income_other').val(total)
            $('#total_income_num').val(total_num)
    )

    @update_outgoing_information = ()->
        total = 0
        total_num = 0
        $('#outgoing_information input').each( ->
            if $(this).attr('id') != "other_name" && $(this).attr('id') != "total_outgoing" && $(this).attr('id') != "total_outgoing_num"
                cash = get_liablity($(this))
                if cash != 0 && cash != ""
                    total += cash
                    total_num += valid_liability_form($(this))

        )
        $('#total_outgoing').val(total)
        $('#total_outgoing_num').val(total_num)


    $('#outgoing_information input').blur( ->
        total = 0
        total_num = 0

        $('#outgoing_form input#other_liability').each(->
            total += get_liablity($(this))
            total_num += valid_liability_form($(this))
        )

        if $(this).attr('id') == "other_name"
        else
            $('#total_outgoing').val(total)
            $('#total_outgoing_num').val(total_num)

    )


############################################################################
############# ここまで
############################################################################


############################################################################
############# 枠を性が駆除するプログラム
############################################################################

    focus_func = (element) ->
        parent_block = element.parent().parent().parent().parent()
        parent_block.addClass("focus")

    blur_func = (element) ->
        parent_block = element.parent().parent().parent().parent()
        complete_block =  true
        parent_block.find('input').each( ->
            if element.val() == ""
                complete_block = false
        )
        if complete_block
            parent_block.addClass("focus")
        else
            parent_block.removeClass("focus")


    $('#liability_information input').focus( ->
        focus_func($(this))
    ).blur( ->
        blur_func($(this))
    )


    $('#income_information input').focus( ->
        parent_block = $(this).parent().parent().parent().parent()
        parent_block.addClass("focus")
    ).blur( ->
        parent_block = $(this).parent().parent().parent().parent()
        complete_block =  true
        parent_block.find('input').each( ->
            if $(this).val() == ""
                complete_block = false
        )
        if complete_block
            parent_block.addClass("focus")
        else
            parent_block.removeClass("focus")

    )



    $('#outgoing_information input').focus( ->
        parent_block = $(this).parent().parent().parent().parent()
        parent_block.addClass("focus")
    ).blur( ->
        parent_block = $(this).parent().parent().parent().parent()
        complete_block =  true
        parent_block.find('input').each( ->
            if $(this).val() == ""
                complete_block = false
        )
        if complete_block
            parent_block.addClass("focus")
        else
            parent_block.removeClass("focus")

    )




    $('#loans_information input').focus( ->
        parent_block = $(this).parent().parent().parent().parent()
        parent_block.addClass("focus")
    ).blur( ->
        parent_block = $(this).parent().parent().parent().parent()
        complete_block =  true
        parent_block.find('input').each( ->
            if $(this).val() == ""
                complete_block = false
        )
        if complete_block
            parent_block.addClass("focus")
        else
            parent_block.removeClass("focus")

    )


    $('#assets_information input').focus( ->
        parent_block = $(this).parent().parent()
        parent_block.addClass("focus")
    ).blur( ->
        parent_block = $(this).parent().parent()
        complete_block =  true
        parent_block.find('input').each( ->
            if $(this).val() == ""
                complete_block = false
        )
        if complete_block
            parent_block.addClass("focus")
        else
            parent_block.removeClass("focus")

    )





    $('input').focus( ->
        parent_block = $(this).parent().parent().parent()
        parent_block.addClass("focus")
    ).blur( ->
        parent_block = $(this).parent().parent().parent()
        complete_block =  true
        parent_block.find('input').each( ->
            if $(this).val() == ""
                complete_block = false
        )
        if complete_block
            parent_block.addClass("focus")
        else
            parent_block.removeClass("focus")

    )
############################################################################
############# ここまで
############################################################################


    $('li.q').each((index) ->
        if index == 0
            $(this).next().slideToggle(500)
            $(this).toggleClass('active')
    )

    $('#add_outgoing_area').click ->
        $('#outgoing_form').append('<div class="col-md-8 col-xs-12 col-md-offset-4">' +
                                        '<input id="other_name" class="col-md-5 apply" placeholder="asset name"/>' +
                                        '<input id="other_liability" class="col-md-5 apply" placeholder="$" onblur="update_outgoing_information()"/>' +
                                   '</div>')


    $('#add_income_area').click ->
        $('#income_form').append('<div class="col-md-8 col-xs-12 col-md-offset-4">' +
                                        '<input class="col-md-5 apply" placeholder="asset name" id="income_name"/>' +
                                        '<input class="col-md-5 apply" placeholder="$" id="income" onblur="update_income_information()"/>' +
                                   '</div>')

    $('#add_morgage_area').click ->
        $('#morgages_other').append('<div class="col-md-8 col-xs-12 col-md-offset-3 no-padding ">' +
                                        '<input class="col-md-5 apply" placeholder="asset name" id="morgage_other"/>' +
                                        '<input class="col-md-5 apply" placeholder="$" id="morgage" onblur="update_assets_information()"/>' +
                                   '</div>')

    $('#add_liability').click ->
        $('#liability_form').append('<div class="col-md-8 col-xs-12 col-md-offset-4  ">' +
                                        '<input class="col-md-5 apply" id="other_liability_name" placeholder="asset name"/>' +
                                        '<input class="col-md-5 apply" id="other_liability" placeholder="$" onblur="update_liability_information()"/>' +
                                   '</div>')

    $('#add_loan').click ->
        $('#loan_form').append('<div class="col-md-8 col-xs-12 col-md-offset-4 ">' +
                                        '<input class="col-md-5 apply" placeholder="asset name" id="loan_company_name"/>' +
                                        '<input class="col-md-5 apply" placeholder="$" id="loans" onblur="update_loans_information()"/>' +
                                   '</div>')









    $('#dependentsCount').blur( ->
        console.log "test"
        num = parseInt($(this).val()) - 1

        if num > 0
            $('#depend_age_form').empty()
            for i in [1..num]
                $('#depend_age_form').append('<input id="dependentsAge" class="col-md-12 col-xs-12 apply required" placeholder="Age ' + (i+1) + '" required>')

    )


    $('#other_name').blur( ->
         console.log "blur"
    )






    $(document).on('blur', '#other_name', ->
         console.log "blur"
         asset_num = $('input#other_liability_name').length
         asset_sum = 0
         $('input#other_liability').each( ->
             asset_sum +=  parseInt($(this).val())
         )
    )
 



    $('#identification_visa input:file').uploadThumbs({
        position : 1,
        imgbreak : false});

    $('#identification_visa input:file').on("change", () -> 
          file = this.files[0];
          if(file != null) 
              formData = new FormData();
              formData.append("file", file, file.name);

              $.ajax({
                  type:   "POST",
                  url:    "/home/upload_file_visa",
                  xhr: -> 
                      myXhr = $.ajaxSettings.xhr();
                      
                      return myXhr;
                  ,
                  async: true,
                  data: formData,
                  cache: false,
                  contentType: false,
                  processData: false,
                  timeout: 60000,
                  success: (data) -> 
                      visa_licence = $.parseJSON(data["visa_licence"])
                      words = data["words"]
                      
                      $('input#visa_expire_date').val(visa_licence["expire_date"]).addClass("valid")
                      $('input#citizen_ship').val(visa_licence["citizen_ship"]).addClass("valid")

                      if visa_licence["visa_type"] == "Student Visa"
                          initialize_radio_box($('li.radio.residential_status'))
                          $('#residential_student_label').attr("class", "checked")

                      #$.each(words, (index, word) ->
                      #    $('ul#tag_list').append("<li><a class='btn btn-primary btn-rounded'>" + word + "</a></li>")
                      #)
                  ,
                  error: (error) -> 
                    console.log "error"
                    console.log error
                  

                  }).done((data) -> 
                  )
    );





    $('#identification input:file').uploadThumbs({
        position : 1,
        imgbreak : false});

    $('#identification input:file').on("change", () -> 
          file = this.files[0];
          if(file != null) 
              formData = new FormData();
              formData.append("file", file, file.name);

              $.ajax({
                  type:   "POST",
                  url:    "/home/upload_file",
                  xhr: -> 
                      myXhr = $.ajaxSettings.xhr();
                      
                      return myXhr;
                  ,
                  async: true,
                  data: formData,
                  cache: false,
                  contentType: false,
                  processData: false,
                  timeout: 60000,
                  success: (data) -> 
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
                  ,
                  error: (error) -> 
                    console.log "error"
                    console.log error
                  

                  }).done((data) -> 
                  )
                  
    );



