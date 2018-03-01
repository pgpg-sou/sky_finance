
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
                        window.post_form_data["token"] = "Ri1ntE8SykkPk8Sgbc1q0a4buVzrWzGywEK0z14zp2t4zkxb4dw27DLBrGWJ3J7a"
                        $.ajax({
                            type:   "POST",
                            url:    "http://application.beefinance.co.nz/connect-craft/connect.php",
                            data: window.post_form_data,
                            success: (data) -> 
                            ,
                            error: (error) -> 
                            })
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


