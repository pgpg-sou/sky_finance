


$(document).ready ->
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
         console.log asset_num
         console.log asset_sum
    )
 




