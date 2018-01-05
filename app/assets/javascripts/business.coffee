# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
    $('#company_director_count').blur( ->
        number = parseInt($(this).val())
        
        director_number = $('#director_information').length - 1
        $('#director_form').empty()

        if director_number != number
            for i in [0...number]
                console.log i
                $('#director_information').clone().css('display', 'block').appendTo('#director_form')
    )
