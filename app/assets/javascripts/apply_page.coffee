


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
        console.log "ample"

        morgage = get_liablity($('#liability_morgage'))
        car = get_liablity($('#liability_car'))
        creditcard = get_liablity($('#liability_creditcard'))
        bankod = get_liablity($('#liability_bankod'))
        total = morgage + creditcard + bankod  + car
        total_num = valid_liability_form($('#liability_morgage')) + valid_liability_form($('#liability_creditcard')) + valid_liability_form($('#liability_bankod')) + valid_liability_form($('#liability_car'))

        $('#liability_form input#liability').each(->
            cash = get_liablity($(this))
            if cash != 0 && cash != ""
                total += cash
                total_num += valid_liability_form($(this))
        )
        $('#total_liability_info').val(total)
        $('#total_liability_num').val(total_num)

    $('#liability_information input').blur( ->
        total = 0

        morgage = get_liablity($('#liability_morgage'))
        car = get_liablity($('#liability_car'))
        creditcard = get_liablity($('#liability_creditcard'))
        bankod = get_liablity($('#liability_bankod'))
        total = morgage + creditcard + bankod  + car
        total_num = valid_liability_form($('#liability_morgage')) + valid_liability_form($('#liability_creditcard')) + valid_liability_form($('#liability_bankod')) + valid_liability_form($('#liability_car'))

        $('#liability_form input#liability').each(->
            total += get_liablity($(this))
            total_num += valid_liability_form($(this))
        )

        if $(this).attr('id') == "other_liability_name"
        else
            $('#total_liability_info').val(total)
            $('#total_liability_num').val(total_num)
    )

    @update_assets_information = ()->
        total = 0
        total_num = 0

        home = get_liablity($('#assets_home'))
        furnishing = get_liablity($('#assets_furnishing'))
        bank_account = get_liablity($('#assets_bank_account'))
        car = get_liablity($('#assets_car'))
        investments = get_liablity($('#assets_investments'))

        total = home + furnishing +  bank_account + car + investments
        total_num = valid_liability_form($('#assets_home')) + valid_liability_form($('#assets_furnishing')) + valid_liability_form($('#assets_bank_account')) + valid_liability_form($('#assets_car')) + valid_liability_form($('#assets_investments'))


        $('#assets_form input#other_assets').each(->
            cash = get_liablity($(this))
            if cash != 0 && cash != ""
                total += cash
                total_num += valid_liability_form($(this))

        )
        $('#total_assets').val(total)
        $('#total_num_assets').val(total_num)



    $('#assets_information input').blur( ->
        total = 0

        home = get_liablity($('#assets_home'))
        furnishing = get_liablity($('#assets_furnishing'))
        bank_account = get_liablity($('#assets_bank_account'))
        car = get_liablity($('#assets_car'))
        investments = get_liablity($('#assets_investments'))

        total = home + furnishing +  bank_account + car + investments
        total_num = valid_liability_form($('#assets_home')) + valid_liability_form($('#assets_furnishing')) + valid_liability_form($('#assets_bank_account')) + valid_liability_form($('#assets_car')) + valid_liability_form($('#assets_investments'))

        $('#assets_form input#other_assets').each(->
            total += get_liablity($(this))
            total_num += valid_liability_form($(this))
        )

        if $(this).attr('id') == "other_assets_name"
        else
            $('#total_assets').val(total)
            $('#total_num_assets').val(total_num)
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




    $('#company_information input').focus( ->
        parent_block = $(this).parent().parent().parent()
        parent_block.addClass("focus")
    ).blur( ->
        parent_block = $(this).parent().parent().parent()
        console.log parent_block
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

    $('#company_information input').focus( ->
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
        $('#outgoing_form').append('<div class="col-md-8 col-xs-12 col-md-offset-4 no-padding">' +
                                        '<input id="other_name" class="col-md-5 col-xs-5 apply" placeholder="asset name"/>' +
                                        '<input id="other_liability" class="col-md-5 col-xs-5 apply" placeholder="$" onblur="update_outgoing_information()"/>' +
                                   '</div>')


    $('#add_income_area').click ->
        $('#income_form').append(
                                   '<div id="i_form" class="col-md-8 col-xs-12 col-md-offset-4 no-padding">' +
                                        '<div class="col-md-12">' +
                                            '<ul id="income_other_period">' +
                                                '<li class="btn btn-gray btn-rounded income_other" value="weekly">' + 
                                                    '<a id="#tag">' +
                                                        '<span class="glyphicon glyphicon-ok"></span>' +
                                                        'weekly' +
                                                    '</a>' +
                                                '</li>' +
                                                '<li class="btn btn-gray btn-rounded income_other" value="fortnightly">' + 
                                                    '<a id="#tag">' +
                                                        '<span class="glyphicon glyphicon-ok"></span>' +
                                                        'fortnightly' +
                                                    '</a>' +
                                                '</li>' +
                                                '<li class="btn btn-gray btn-rounded income_other" value="monthly">' + 
                                                    '<a id="#tag">' +
                                                        '<span class="glyphicon glyphicon-ok"></span>' +
                                                        'monthly' +
                                                    '</a>' +
                                                '</li>' +
                                            '</ul>' +
                                        '</div>' +
                                        '<input class="col-md-5 col-xs-5 apply" placeholder="asset name" id="income_name"/>' +
                                        '<input class="col-md-5 col-xs-5 apply" placeholder="$" id="income" onblur="update_income_information()"/>' +
                                   '</div>'
                                   )

    $('#add_morgage_area').click ->
        $('#morgages_other').append('<div class="col-md-8 col-xs-12 col-md-offset-3 no-padding no-padding ">' +
                                        '<input class="col-md-5 col-xs-5 apply" placeholder="asset name" id="morgage_other"/>' +
                                        '<input class="col-md-5 col-xs-5 apply" placeholder="$" id="morgage" onblur="update_assets_information()"/>' +
                                   '</div>')

    $('#add_assets').click ->
        $('#assets_form').append('<div class="col-md-8 col-xs-12 col-md-offset-4 no-padding ">' +
                                        '<input class="col-md-5 col-xs-5 apply" id="other_assets_name" placeholder="asset name"/>' +
                                        '<input class="col-md-5 col-xs-5 apply" id="other_assets" placeholder="$" onblur="update_assets_information()"/>' +
                                   '</div>')

    $('#add_loan').click ->
        $('#loan_form').append('<div class="col-md-8 col-xs-12 col-md-offset-4 no-padding">' +
                                        '<input class="col-md-5 col-xs-5 apply" placeholder="asset name" id="loan_company_name"/>' +
                                        '<input class="col-md-5 col-xs-5 apply" placeholder="$" id="loans" onblur="update_loans_information()"/>' +
                                   '</div>')


    $('#add_liability_area').click ->
        $('#liability_form').append('<div class="col-md-8 col-xs-12 col-md-offset-3 no-padding">' +
                                        '<input class="col-md-5 col-xs-5 apply" placeholder="asset name" id="liability_other"/>' +
                                        '<input class="col-md-5 col-xs-5 apply" placeholder="$" id="liability" onblur="update_liability_information()"/>' +
                                   '</div>')








    $('#dependentsCount').blur( ->
        num = parseInt($(this).val()) - 1
        if (num + 1) <= 10 && num >= 0
            $('#depend_age_form').empty()
            for i in [0...num]
                $('#depend_age_form').append('<input id="dependentsAge" class="col-md-12 col-xs-12 apply required" placeholder="Age ' + (i+2) + '" required>')

    )


    $('#other_name').blur( ->
         console.log "blur"
    )


    $('#joint_applicant_exist li').click( ->
        if $(this).text().trim().replace(/\r?\n/g,"") == "Yes"
            $(".joint").css("display", "block")
        else
            $(".joint").css("display", "none")

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




    Dropzone.autoDiscover = false
    front_dropzone = new Dropzone(
        "div.dropzone_front",
        {
            url: "/home/upload_file",
            maxFiles: 1,
            acceptedFiles: 'image/*',
            thumbnailWidth: 460,
            thumbnailHeight: 280,
            addRemoveLinks: true, 
            dictRemoveFile:'remove',
            success: (file, data) ->
              $("div.dropzone_front").addClass("active")
              driver_licence = $.parseJSON(data["driver_licence"])
              words = data["words"]
              window.post_form_data["driver_licence_front_image"] = driver_licence["file_name"]
              window.post_form_data["driver_licence_front_image_url"] = driver_licence["file_image_url"]
              
              $('input#first_name').val(driver_licence["first_name"]).addClass("valid")
              $('input#sur_name').val(driver_licence["last_name"]).addClass("valid")
              $('input#date_of_birth').val(driver_licence["birth_date"]).addClass("valid")
               
              $('input#driver_licence_number').val(driver_licence["driver_licence_no"]).addClass("valid")
              $('input#driver_licence_version').val(driver_licence["card_version_no"]).addClass("valid")
              $('input#drivers_licence_expire_date').val(driver_licence["expire_date"]).addClass("valid")
              $('input#driver_licence_country').val(driver_licence["licence_country"]).addClass("valid")
              
              if driver_licence["licence_type"] == "LEARNER"
                  $('ul#driver_licence li').each ->
                      $(this).removeClass('active')
                  $('ul#driver_licence > li:nth-child(1)').addClass('active')
              else if driver_licence["licence_type"] == "RESTRICTED"
                  $('ul#driver_licence li').each ->
                      $(this).removeClass('active')
                  $('ul#driver_licence > li:nth-child(2)').addClass('active')
              else 
                  $('ul#driver_licence li').each ->
                      $(this).removeClass('active')
                  $('ul#driver_licence > li:nth-child(4)').addClass('active')
        }
    )

    joint_front_dropzone = new Dropzone(
        "div.dropzone_front_joint",
        {
            url: "/home/upload_file",
            maxFiles: 1,
            acceptedFiles: 'image/*',
            thumbnailWidth: 460,
            thumbnailHeight: 280,
            addRemoveLinks: true, 
            dictRemoveFile:'remove',
            success: (file, data) ->
              $("div.dropzone_front_joint").addClass("active")
              driver_licence = $.parseJSON(data["driver_licence"])
              words = data["words"]
              #window.post_form_data["joint_driver_licence_front_image"] = file.dataURL
              window.post_form_data["driver_licence_joint_front_image"] = driver_licence["file_name"]
              window.post_form_data["driver_licence_joint_front_image_url"] = driver_licence["file_image_url"]
              
              $('input#joint_applicant_first_name').val(driver_licence["first_name"]).addClass("valid")
              $('input#joint_applicant_sur_name').val(driver_licence["last_name"]).addClass("valid")
              $('input#joint_applicant_date_of_birth').val(driver_licence["birth_date"]).addClass("valid")
               
              $('input#joint_applicant_driver_licence').val(driver_licence["driver_licence_no"]).addClass("valid")
              $('input#joint_applicant_driver_licence_version').val(driver_licence["card_version_no"]).addClass("valid")
              $('input#joint_applicant_drivers_licence_expire_date').val(driver_licence["expire_date"]).addClass("valid")
              $('input#joint_applicant_driver_licence_country').val(driver_licence["licence_country"]).addClass("valid")
              
              if driver_licence["licence_type"] == "LEARNER"
                  $('ul#joint_applicant_driver_licence li').each ->
                      $(this).removeClass('active')
                  $('ul#joint_applicant_driver_licence > li:nth-child(1)').addClass('active')
              else if driver_licence["licence_type"] == "RESTRICTED"
                  $('ul#joint_applicant_driver_licence li').each ->
                      $(this).removeClass('active')
                  $('ul#joint_applicant_driver_licence > li:nth-child(2)').addClass('active')
              else 
                  $('ul#joint_applicant_driver_licence li').each ->
                      $(this).removeClass('active')
                  $('ul#joint_applicant_driver_licence > li:nth-child(4)').addClass('active')
        }
    )


    back_dropzone = new Dropzone(
        "div.dropzone_back",
        { 
            url: "/home/upload_driver_licence_back",
            thumbnailWidth: 460,
            thumbnailHeight: 280,
            acceptedFiles: 'image/*',
            addRemoveLinks: true, 
            dictRemoveFile:'remove',
            maxFiles: 1,
            success: (file, data) ->
              $("div.dropzone_back").addClass("active")
              #window.post_form_data["driver_licence_back_image"] = file.dataURL
              driver_licence = $.parseJSON(data["driver_licence"])
              window.post_form_data["driver_licence_back_image"] = driver_licence["file_name"]
              window.post_form_data["driver_licence_back_image_url"] = driver_licence["file_image_url"]
              $("input#drivers_licence_expire_date").val(driver_licence["expire_date"])
        }
    ) 


    back_dropzone = new Dropzone(
        "div.dropzone_back_joint",
        { 
            url: "/home/upload_driver_licence_back",
            thumbnailWidth: 460,
            thumbnailHeight: 280,
            acceptedFiles: 'image/*',
            addRemoveLinks: true, 
            dictRemoveFile:'remove',
            maxFiles: 1,
            success: (file, data) ->
              $("div.dropzone_back_joint").addClass("active")
              #window.post_form_data["joint_driver_licence_back_image"] = file.dataURL
              driver_licence = $.parseJSON(data["driver_licence"])
              window.post_form_data["driver_licence_joint_back_image"] = driver_licence["file_name"]
              window.post_form_data["driver_licence_joint_back_image_url"] = driver_licence["file_image_url"]
              driver_licence = $.parseJSON(data["driver_licence"])
              $("input#joint_applicant_drivers_licence_expire_date").val(driver_licence["expire_date"])
        }
    ) 

    passport_dropzone = new Dropzone(
        "div.passport_dropzone",
        { 
            url: "/home/upload_passport_file",
            thumbnailWidth: 460,
            thumbnailHeight: 280,
            maxFilesize: 2,
            acceptedFiles: 'image/*',
            addRemoveLinks: true, 
            dictRemoveFile:'remove',
            maxFiles: 1,
            success: (file, data) ->
              #window.post_form_data["possport_image"] = file.dataURL
              driver_licence = $.parseJSON(data["result"])
              window.post_form_data["passport_image"] = driver_licence["file_name"]
              window.post_form_data["passport_image_url"] = driver_licence["file_image_url"]

        }
    )
    joint_passport_dropzone = new Dropzone(
        "div.joint_passport_dropzone",
        { 
            url: "/home/upload_passport_file",
            thumbnailWidth: 460,
            thumbnailHeight: 280,
            maxFilesize: 2,
            acceptedFiles: 'image/*',
            addRemoveLinks: true, 
            dictRemoveFile:'remove',
            maxFiles: 1,
            success: (file, data) ->
              #window.post_form_data["possport_image"] = file.dataURL
              driver_licence = $.parseJSON(data["result"])
              window.post_form_data["joint_passport_image"] = driver_licence["file_name"]
              window.post_form_data["joint_passport_image_url"] = driver_licence["file_image_url"]
        }
    )




    $("div.joint_visa_dropzone").dropzone({ 
        url: "/home/upload_file_visa",
        maxFiles: 2,
        thumbnailWidth: 460,
        thumbnailHeight: 280,
        acceptedFiles: 'image/*',
        addRemoveLinks: true, 
        dictRemoveFile:'remove',
        success: (file, data) ->
          $("div.joint_visa_dropzone").addClass("active")
          visa_licence = $.parseJSON(data["visa_licence"])
          words = data["words"]
          #window.post_form_data["joint_visa_image"] = file.dataURL
          window.post_form_data["driver_licence_joint_visa_image"] = data["file_name"]
          window.post_form_data["driver_licence_joint_visa_image_url"] = data["file_image_url"]
          
          $('input#joint_applicant_visa_expire_date').val(visa_licence["expire_date"]).addClass("valid")
          $('input#joint_applicant_citizen_ship').val(visa_licence["citizen_ship"]).addClass("valid")

          if visa_licence["visa_type"] == "Student Visa"
              $('ul#joint_applicant_residential_status li').each ->
                  $(this).removeClass('active')
              $('ul#joint_applicant_residential_status > li:nth-child(3)').addClass('active')
          else if visa_licence["visa_type"] == "Work Visa"
              $('ul#joint_applicant_residential_status li').each ->
                  $(this).removeClass('active')
              $('ul#joint_applicant_residential_status > li:nth-child(3)').addClass('active')


          if visa_licence["gender"] == "Female"
              $('ul#joint_applicant_gender li').each ->
                  $(this).removeClass('active')
              $('ul#joint_applicant_gender > li:nth-child(2)').addClass('active')
          else if visa_licence["gender"] == "Male"
              $('ul#joint_applicant_gender li').each ->
                  $(this).removeClass('active')
              $('ul#joint_applicant_gender > li:nth-child(1)').addClass('active')

    })




    $("div.visa_dropzone").dropzone({ 
        url: "/home/upload_file_visa",
        maxFiles: 2,
        thumbnailWidth: 460,
        thumbnailHeight: 280,
        acceptedFiles: 'image/*',
        addRemoveLinks: true, 
        dictRemoveFile:'remove',
        success: (file, data) ->
          $("div.visa_dropzone").addClass("active")
          visa_licence = $.parseJSON(data["visa_licence"])
          words = data["words"]
          #window.post_form_data["visa_image"] = file.dataURL
          window.post_form_data["driver_licence_visa_image"] = data["file_name"]
          window.post_form_data["driver_licence_visa_image_url"] = data["file_image_url"]
          
          $('input#visa_expire_date').val(visa_licence["expire_date"]).addClass("valid")
          $('input#citizen_ship').val(visa_licence["citizen_ship"]).addClass("valid")

          if visa_licence["visa_type"] == "Student Visa"
              $('ul#residential_status li').each ->
                  $(this).removeClass('active')
              $('ul#residential_status > li:nth-child(3)').addClass('active')
          else if visa_licence["visa_type"] == "Work Visa"
              $('ul#residential_status li').each ->
                  $(this).removeClass('active')
              $('ul#residential_status > li:nth-child(3)').addClass('active')


          if visa_licence["gender"] == "Female"
              $('ul#gender li').each ->
                  $(this).removeClass('active')
              $('ul#gender > li:nth-child(2)').addClass('active')
          else if visa_licence["gender"] == "Male"
              $('ul#gender li').each ->
                  $(this).removeClass('active')
              $('ul#gender > li:nth-child(1)').addClass('active')

    })




    modal_type = ""
    camera_element_id = ""
    capture_canvas_element_id = ""
    save_capture_element_id = ""


    modal_type = ""
    $('#front_capture_button').click( ->
        modal_type = "front"
        camera_element_id = "#camera-video"
        capture_canvas_element_id = "#capture-canvas"
        save_capture_element_id = "#save-capture"

        video = $("#camera-video")[0];

        navigator.getUserMedia({ "video": true }, (stream) -> 
          video.src = window.URL.createObjectURL(stream) || stream; 
          video.play(); 
        , (e)->
          console.log(e);
        ); 


    )
    $('#back_capture_button').click( ->
        modal_type = "back"
        camera_element_id = "#camera-video-back"
        capture_canvas_element_id = "#capture-canvas-back"
        save_capture_element_id = "#save-capture-back"
    

        video = $("#camera-video-back")[0];
        navigator.getUserMedia({ "video": true }, (stream) -> 
          video.src = window.URL.createObjectURL(stream) || stream; 
          video.play(); 
        , (e)->
          console.log(e);
        ); 


    )
    $('#visa_capture_button').click( ->
        modal_type = "visa"
    )

    dataURItoBlob = (dataURI) ->
        byteString;
        if (dataURI.split(',')[0].indexOf('base64') >= 0)
            byteString = atob(dataURI.split(',')[1]);
        else
            byteString = unescape(dataURI.split(',')[1]);

        mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];

        ia = new Uint8Array(byteString.length);
        for  i in [0..byteString.length]
            ia[i] = byteString.charCodeAt(i);
        

        return new Blob([ia], {type:mimeString});

    capuredFile = ""
    $('#save-capture').on('click', ()->
      captureCanvas = $(capture_canvas_element_id)[0]; 
      video = $(camera_element_id)[0];

      captureCanvas.width = video.width;
      captureCanvas.height = video.height;
      context = captureCanvas.getContext("2d");
      context.drawImage(video, 0, 0, video.width, video.height);
      dataUrl = captureCanvas.toDataURL('image/jpeg', 100);
      
      $("#tab-handle-camera").css('display': "none")
      $("#capture_confirm").css('display': "block")
      $("#options").css("display", "none")

      capuredFile = dataURItoBlob(dataUrl);
    );

    $('#save-capture-back').on('click', ()->
      captureCanvas = $(capture_canvas_element_id)[0]; 
      video = $(camera_element_id)[0];

      captureCanvas.width = video.width;
      captureCanvas.height = video.height;
      context = captureCanvas.getContext("2d");
      context.drawImage(video, 0, 0, video.width, video.height);
      dataUrl = captureCanvas.toDataURL('image/jpeg', 100);
      
      $("#tab-handle-camera-back").css('display': "none")
      $("#capture_confirm-back").css('display': "block")
      $("#options-back").css("display", "none")

      capuredFile = dataURItoBlob(dataUrl);
    );

    $('#try_again').on('click', ()->
      captureCanvas = $(capture_canvas_element_id)[0]; 
      video = $(camera_element_id)[0];

      $("#tab-handle-camera").css('display': "block")
      $("#capture_confirm").css('display': "none")
      $("#options").css("display", "block")
    );
    $('#try_again-back').on('click', ()->
      captureCanvas = $(capture_canvas_element_id)[0]; 
      video = $(camera_element_id)[0];

      $("#tab-handle-camera-back").css('display': "block")
      $("#capture_confirm-back").css('display': "none")
      $("#options-back").css("display", "block")
    );



    $('#upload_capture').on('click', ()->
      front_dropzone.addFile(capuredFile);
      front_dropzone.processQueue();

      $('#capture').modal("hide")
    );

    $('#upload_capture-back').on('click', ()->
      back_dropzone.addFile(capuredFile);
      back_dropzone.processQueue();

      $('#back_capture').modal("hide")
    );


    $('#c_edit').click( ->
        if $(this).attr("value") == "step_1"
            console.log("sample")
    )



