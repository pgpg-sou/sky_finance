


$(document).ready ->
    $('li.q').each((index) ->
        if index == 0
            $(this).next().slideToggle(500)
            $(this).toggleClass('active')
    )




