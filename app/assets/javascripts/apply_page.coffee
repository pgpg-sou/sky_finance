


$(document).ready ->

    $('input').blur( ->
        if $(this).val() != ""
            $(this).addClass("valid")
    )


    $('li.q').each((index) ->
        if index == 0
            $(this).next().slideToggle(500)
            $(this).toggleClass('active')
    )

    $('#add_outgoing_area').click ->
        $('#outgoing_form').append('<div class="col-md-8 col-xs-12 col-md-offset-4">' +
                                        '<input id="other_name" class="col-md-5 apply" placeholder="asset name"/>' +
                                        '<input id="other_liability" class="col-md-5 apply" placeholder="$"/>' +
                                   '</div>')


    $('#add_income_area').click ->
        $('#income_form').append('<div class="col-md-8 col-xs-12 col-md-offset-4">' +
                                        '<input class="col-md-5 apply" placeholder="asset name"/>' +
                                        '<input class="col-md-5 apply" placeholder="$"/>' +
                                   '</div>')

    $('#add_morgage_area').click ->
        $('#morgages_other').append('<div class="col-md-8 col-xs-12 col-md-offset-3 no-padding ">' +
                                        '<input class="col-md-5 apply" placeholder="asset name"/>' +
                                        '<input class="col-md-5 apply" placeholder="$"/>' +
                                   '</div>')


    $('#dependentsCount').blur( ->
        console.log "test"
        num = parseInt($(this).val()) - 1

        if num > 0
            $('#depend_age_form').empty()
            for i in [1..num]
                $('#depend_age_form').append('<input id="dependentsAge" class="col-md-12 col-xs-12 apply required">')

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



