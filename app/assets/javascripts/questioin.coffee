


$(document).ready ->

    $('li.q').on('click', ->
        $(this).next().slideToggle(500)
        img = $(this).children('div')
        img.toggleClass('rotate')
        $(this).toggleClass('active');
    )

