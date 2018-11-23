
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

        var tst = $(this).find(".day_format input");
        tst.each(function(i, item){
            // item is DOM object.
            // Can be referred to as item OR $(this) - JQUERY obj of item
            jquery_item = $(this);

            //highlightItems(item.value);    --- JS way
            highlightItems(jquery_item.val());
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



function highlightItems(item_id){
    var item_rows = $('.manage_index tr input');
    item_rows.each(function(i, input){
        jquery_input = $(this);

        var row_item_id = jquery_input.val();
        if(row_item_id == item_id){

            var row = jquery_input.closest("tr");
            row.attr('class', '');
            row.attr('style', 'background-color: yellow');
        }
    });
}
