$(function (){
  $('#delete_link').on('click', function(e){
   var check_item = $('input:checked','#delete_form'),
   _arr = [];
    e.preventDefault();
    check_item.each(function(item, index){
      _arr.push($(index).prop('value'));
    });
    $.ajax({
      type: "POST",
      url: "/delete",
      data: {"checkbox":_arr},
      dataType: "html",
      success: function(data) {
        $.map(_arr, function(value, index) {
          document.getElementById([value]).remove();
        });
        $('#alerts').html(data);
      },
      error: function(xhr, status, error) {
        $('#alerts').html("Some errors: " + error)
      }
    });
  })
  $('#update_link').on('click', function(e){
    e.preventDefault();
    $.ajax({
      type: "POST",
      url: "/update",
      data: {"update":true},
      dataType: "html",
      success: function(data) {
        $('#alerts').html(data);
      },
      error: function(xhr, status, error) {
        $('#alerts').html("Some errors: " + error)
      }
    });
  })
  // $('#upload_form').on('submit', function(e){
  //   e.preventDefault();
  //   $.ajax({
  //     type: "POST",
  //     url: "/upload",
  //     data: $(this).serialize(),
  //     dataType: "html",
  //     success: function(data) {
  //       $('#alerts').html(data);
  //     },
  //     error: function(xhr, status, error) {
  //       $('#alerts').html("Some errors: " + error)
  //     }
  //   });
  // })
});
