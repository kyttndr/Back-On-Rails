
$(document).on('turbolinks:load', function(){
    $('[data-toggle="tooltip"]').tooltip();
    $('[data-toggle="table"]').table();
});

$(document).ready(function(){
    var events_bg_color = '#E0FFFF';
    var table1_class = $('.manage_index .tr_table_1').attr("class");
    var table2_class = $('.manage_index .tr_table_2').attr("class");

    // HOVER OVER CALENDAR
    $('.has-events').hover(function(){
        $(this).css("background-color", "yellow");

        var all_items = $(this).find(".item_format");
        all_items.each(function(i, item){
            var item_id = $(this).find('#item_id').val();
            var start_date = $(this).find('#start_date').val();

            //highlightItems(data.value);    --- JS way
            highlightItems(item_id, start_date);
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


    // HOVER OVER 1st MANAGE TABLE ROWS
    $('.tr_table_1, .tr_table_2').hover(function(){

        $(this).removeClass('info success danger');
        $(this).attr('style', 'background-color: yellow');

        var item_id = $(this).find('.item-id').val();
        var start_date = $(this).find('.start-date').val();

        highlightCalendar(item_id, start_date);

    }, function(){
        if($(this).attr('class')=='tr_table_1'){
            $(this).attr('class', table1_class);
        }
        if($(this).attr('class')=='tr_table_2'){
            $(this).attr('class', table2_class);
        }
        $(this).attr('style', '');

        $('.has-events').each(function(){
            $(this).css("background-color", events_bg_color);
        });
    });

});



function highlightItems(item_id, start_date){

    var item_rows = $('.manage_index tr');
    item_rows.each(function(i, row){
        jquery_row = $(this);

        var row_item_id = jquery_row.find('.item-id').val();
        var row_start_date = jquery_row.find('.start-date').val();

        if(row_item_id == item_id && row_start_date == start_date){
            jquery_row.removeClass('info success danger');
            jquery_row.attr('style', 'background-color: yellow');
        }
    });
}

function highlightCalendar(item_id, start_date){

    $('.has-events .item_format').each(function(){
        var day_item_id = $(this).find('#item_id').val();
        var day_start_date = $(this).find('#start_date').val();

        if(item_id==day_item_id && start_date==day_start_date){
            borrowing_day = $(this).closest('.has-events');
            borrowing_day.attr('style', 'background-color: yellow');
        }
    });

}
