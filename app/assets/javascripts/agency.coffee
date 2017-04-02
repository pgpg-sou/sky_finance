
$(document).ready ->
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

        $('li.radio').each ->
            has = false
            if $(this).hasClass("checked")
                has = true

            if has == false
                $('#title_error').css("display","block")
                $('li.radio').each ->
                    $(this).find('label').removeClass("unselected")
                    $(this).find('label').addClass("error-check")


    
    $('.input-mask').inputmask({
          mask: '99/99/9999'
    })
    $('.input-mask-phone').inputmask({
        mask: '(999) 999-9999'
    })
