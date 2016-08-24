var ready, set_positions;

set_positions = function(){
    // loop through and give each task a data-pos
    // attribute that holds its position in the DOM
    $('.collection-item').each(function(i){
        $(this).attr("data-pos",i+1);
    });
}

ready = function(){
    
    set_positions();
    
    $('.sortable').sortable();
    
    
     $('.sortable').sortable().bind('sortupdate', function(e, ui) {
        // array to store new order
        updated_order = []
        // set the updated positions
        set_positions();

        // populate the updated_order array with the new task positions
        $('.collection-item').each(function(i){
            updated_order.push({ id: $(this).data("id"), position: i+1 });
        });



        // send the updated order via ajax
        $.ajax({
            type: "PUT",
            url: 'projects/priority',
            data: { order: updated_order }
        });
    });
}

    

$(document).ready(ready);

