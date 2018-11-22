
$(document).on('turbolinks:load', function(){
    $('[data-toggle="tooltip"]').tooltip();
    $('[data-toggle="table"]').table();
});

/*
$(document).ready(function(){
    var error_message_html = $('.error_messages').html();
    if(error_message_html != undefined){
        //confirm(error_message_html);
        $("#myModal").modal('show');

    }

});
*/
