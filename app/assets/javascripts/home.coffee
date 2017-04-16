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

    $('li.q').on('click', ->
        $(this).next().slideToggle(500)
        img = $(this).children('div')
        img.toggleClass('rotate')
        $(this).toggleClass('active');
    )

    $('#fase1').click ->
        name = parseInt($(this).attr("name"))
        $('li.q').each((index) ->
            if name == (index+1)
                console.log("sample")
                $(this).next().slideToggle(500)
                $(this).toggleClass('active')
        )
    $('#fase2').click ->
        name = parseInt($(this).attr("name"))
        $('li.q').each((index) ->
            if name == (index+1)
                console.log("sample")
                $(this).next().slideToggle(500)
                $(this).toggleClass('active')
        )
    $('#fase3').click ->
        name = parseInt($(this).attr("name"))
        $('li.q').each((index) ->
            if name == (index+1)
                console.log("sample")
                $(this).next().slideToggle(500)
                $(this).toggleClass('active')
        )

    $('#fase4').click ->
        name = parseInt($(this).attr("name"))
        $('li.q').each((index) ->
            if name == (index+1)
                console.log("sample")
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








