
$(document).on('turbolinks:load', function(){
    //INITIALIZE TOOLTIP AND BOOTSTRAP SIMPLE TABLE
    $('[data-toggle="tooltip"]').tooltip();
    //$('[data-toggle="table"]').table();
});

$(document).on('ready turbolinks:load', function(){

    // IMPLEMENTING CALENDAR/TABLE HIGHLIGHTING
    var events_bg_color = $('.current-month.has-events').css('background-color');
    var table1_class = $('.manage_index .tr_table_1').attr("class");
    var table2_class = $('.manage_index .tr_table_2').attr("class");

    // HOVER OVER CALENDAR
    $('.current-month.has-events').hover(function(){
        //events_bg_color = $(this).css('background-color');

        $(this).css("background-color", "yellow");

        $(this).find('.transaction_id').each(function(){
            var transaction_id = $(this).val();
            highlightItems(transaction_id);
        });
    }, function(){
        $(this).css("background-color", events_bg_color);
        $('.manage_index .tr_table_1').each(function(){
            $(this).attr('style', '');
            $(this).attr('class', table1_class);
        });
        $('.manage_index .tr_table_2').each(function(){
            $(this).attr('style', '');
            $(this).attr('class', table2_class);
        });
    });


    // HOVER OVER MANAGE TABLE ROWS
    $('.tr_table_1, .tr_table_2').hover(function(){
        $(this).removeClass('info success danger');
        $(this).attr('style', 'background-color: yellow');

        var transaction_id = $(this).find('.row_transaction_id').val();
        highlightCalendar(transaction_id);

    }, function(){
        if($(this).attr('class')=='tr_table_1'){
            $(this).attr('class', table1_class);
        }
        if($(this).attr('class')=='tr_table_2'){
            $(this).attr('class', table2_class);
        }
        $(this).attr('style', '');

        $('.current-month.has-events').each(function(){
            $(this).css("background-color", events_bg_color);
        });
    });

});


function highlightItems(transaction_id){
    $('.manage_index .row_transaction_id').each(function(){
        var row_transaction_id = $(this).val();

        if(row_transaction_id == transaction_id){
            var table_row = $(this).closest('tr');
            table_row.removeClass('info success danger');
            table_row.attr('style', 'background-color: yellow');
        }
    });
}

function highlightCalendar(transaction_id){
    $('.current-month.has-events .item_format').each(function(){
        var day_transaction_id = $(this).find('.transaction_id').val();

        if(day_transaction_id == transaction_id){
            var borrowing_day = $(this).closest('.has-events');
            borrowing_day.attr('style', 'background-color: yellow');
        }
    });
}
