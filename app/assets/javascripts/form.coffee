
$(document).ready ->
    window.post_form_data = new Object 

    $('button.forward').click( ->
        $(".step.wizard-step.current li#application input").each( ->
            if $(this).parent().parent().hasClass("custom_form")
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
        console.log window.post_form_data
        $.ajax({
            type:   "POST",
            url:    "/home/application_saver",
            data: window.post_form_data,
            success: (data) -> 

            ,
            error: (error) -> 

            }).done((data) -> 
            )
    )


