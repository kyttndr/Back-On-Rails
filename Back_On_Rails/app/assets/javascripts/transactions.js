
$(document).on('turbolinks:load', function(){
    $('[data-toggle="tooltip"]').tooltip();
    $('[data-toggle="table"]').table();
});


$(document).ready(function(){

    var events_bg_color = '#E0FFFF';
    var table1_class = $('.manage_index #tr_table_1').attr("class");
    var table2_class = $('.manage_index #tr_table_2').attr("class");

    $('.has-events').hover(function(){

        $(this).css("background-color", "yellow");

        var all_items = $(this).find(".item_format");
        all_items.each(function(i, item){
            var item_id = $(this).find('#item_id');
            var start_date = $(this).find('#start_date');

            //highlightItems(data.value);    --- JS way
            highlightItems(item_id.val(), start_date.val());
        });

    }, function(){
        $(this).css("background-color", events_bg_color);
        $('.manage_index #tr_table_1').each(function(i, tr){
            $(this).attr('style', '');
            $(this).attr('class', table1_class);
        });
        $('.manage_index #tr_table_2').each(function(i, tr){
            $(this).attr('style', '');
            $(this).attr('class', table2_class);
        });
    });

});



function highlightItems(item_id, start_date){

    var item_rows = $('.manage_index tr');
    item_rows.each(function(i, row){
        jquery_row = $(this);

        var row_item_id = jquery_row.find('.item-id').val();
        var row_start_date = jquery_row.find('.start-date').val();

        //var row_item_id = jquery_input.val();
        if(row_item_id == item_id && row_start_date == start_date){

            //var row = jquery_input.closest("tr");
            jquery_row.attr('class', '');
            jquery_row.attr('style', 'background-color: yellow');
        }
    });
}
