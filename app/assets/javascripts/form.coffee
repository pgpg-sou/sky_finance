
$(document).ready ->
    post_form_data = new Object 

    $('button.forward').click( ->
        $(".step.wizard-step.current li#application input").each( ->
            if $(this).parent().parent().hasClass("custom_form")
            else 
                post_form_data[$(this).attr('id')] = $(this).val()
        )
        $(".step.wizard-step.current li#application ul").each( ->
            if $(this).find("li.active").hasClass('other')
                post_form_data[$(this).attr('id')] = $(this).find("li.active").find("input").val()
            else 
                post_form_data[$(this).attr('id')] = $(this).find("li.active").attr("value")

        )
        $(".step.wizard-step.current .custome_form").each( ->
            console.log $(this)

        )

        console.log post_form_data
    )
