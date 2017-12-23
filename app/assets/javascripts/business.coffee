# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
    $('#company_director_count').blur( ->
        number = parseInt($(this).val())
        
        director_number = $('#company_information').length 
        $('#company_information').each((index, element) ->
            console.log index 
            if index == 0
            else 
                $(this).remove()
        )

        if director_number != number
            for i in [1...number]
                console.log i
                $('#company_information').clone().appendTo('#director')
    )
