# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

console.log("hello")

$(document).ready ->
    $('li.radio').click ->
        $('#title_error').css("display","none")
        $('li.radio').each ->
            $(this).find('label').removeClass("error-check")
            $(this).find('label').removeClass("checked")
            $(this).find('label').addClass("unselected")
            $(this).find('input[name=title]').removeAttr('checked')
        $(this).find('label').removeClass("error-check")
        $(this).find('label').removeClass("unselected")
        $(this).find('label').addClass("checked")
        $(this).find('input[name=title]').attr('checked', 'checked')

    $('button#send').click ->
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


