$(document).on('turbolinks:load', function(){
    var unread_count = $('#unread_count').val();
    if (unread_count > 0) {
        $('.glyphicon-bell').css({'color': '#ff5050'});
    }
});
