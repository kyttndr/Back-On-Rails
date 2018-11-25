
$(document).on('turbolinks:load', function(){
    //INITIALIZE TOOLTIP AND BOOTSTRAP SIMPLE TABLE
    $('[data-toggle="tooltip"]').tooltip();
    //$('[data-toggle="table"]').table();
});

$(document).on('ready turbolinks:load', function(){

    // IMPLEMENTING CALENDAR/TABLE HIGHLIGHTING
    var events_bg_color = $('.current-month.has-events').css('background-color');
    var day_bg_color = $('.current-month.day').not('.current-month.has-events').css('background-color');
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


    // HOVER OVER MANAGE TABLE ROWS (except pending tables)
    $('.tr_table_1, .tr_table_2').not('.pending_requests').hover(function(){
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


    // HOVER OVER PENDING TRANSACTIONS TABLE
    $('.tr_table_1.pending_requests').hover(function(){
        $(this).attr('class', '');
        $(this).attr('style', 'background-color: yellow');

        var item_id = $(this).find('.row_item_id').val();
        var transaction_start_date = $(this).find('.row_transaction_start_date').val();
        var transaction_end_date = $(this).find('.row_transaction_end_date').val();

        highlightPendingCalendar(item_id, transaction_start_date, transaction_end_date);
    }, function(){
        $(this).attr('class', table1_class);
        $(this).attr('style', '');

        $('.current-month.day').not('.current-month.has-events').each(function(){
            $(this).css("background-color", day_bg_color);
        });
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

function highlightPendingCalendar(item_id, transaction_start_date, transaction_end_date){

    // HIGHLIGHT VALID LEND DATES AS GREEN
    $('.current-month.day').not('.current-month.has-events').each(function(){
        var current_date = $(this).find('.calendar_date').val();
        var parsed_current_date = Date.parse(current_date);
        var parsed_start_date = Date.parse(transaction_start_date);
        var parsed_end_date = Date.parse(transaction_end_date);

        if(parsed_current_date >= parsed_start_date && parsed_current_date <= parsed_end_date){
            $(this).attr('style', 'background-color: lightgreen');
        }
    });

    // HIGHLIGHT INVALID LEND DATES AS RED
    $('.current-month.has-events').each(function(){
        var current_date = $(this).find('.calendar_date').val();
        var calendar_transaction_id = $(this).find('.transaction_id').val();

        var parsed_current_date = Date.parse(current_date);
        var parsed_start_date = Date.parse(transaction_start_date);
        var parsed_end_date = Date.parse(transaction_end_date);

        if(parsed_current_date >= parsed_start_date && parsed_current_date <= parsed_end_date){
            var flag = 0;
            $(this).find('.item_id').each(function(){

                var _item_id = $(this).val();
                if(item_id==_item_id){
                    $(this).closest('.day').attr('style', 'background-color: red');
                    flag = 1;
                }
            });
            if(flag = 0){
                $(this).attr('style', 'background-color: lightgreen');
            }
        }
    });

}
