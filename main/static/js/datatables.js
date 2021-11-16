// Call the dataTables jQuery plugin
$(document).ready(function() {
  $('#salesProductTable').DataTable({
    "columnDefs": [
      { "orderable": false, "targets": 6 },
    ]
  });
});

$(document).ready(function() {
  $('#selectProductTableFive').DataTable({
    "searching": false,
    "columnDefs": [
      { "orderable": false, "targets": 5 },
      { "orderable": false, "targets": 6 }
    ]
  });
});

$(document).ready(function() {
  $('#selectProductTableSix').DataTable({
    "searching": false,
    "columnDefs": [
      { "orderable": false, "targets": 6 },
      { "orderable": false, "targets": 7 }
    ]
  });
});

$(document).ready(function() {
  $('#selectProductTableSeven').DataTable({
    "searching": false,
    "columnDefs": [
      { "orderable": false, "targets": 7 },
      { "orderable": false, "targets": 8 }
    ]
  });
});

$(document).ready(function() {
  $('#selectProductTableEight').DataTable({
    "searching": false,
    "columnDefs": [
      { "orderable": false, "targets": 8 },
      { "orderable": false, "targets": 9 }
    ]
  });
});


$(document).ready(function() {
  $('#searchResultsTable').DataTable({
    "searching": false,
    "columnDefs": [
      { "orderable": false, "targets": 4 },
    ]
  });

  $(document).ready(function() {
    $('#salesTable').DataTable({
      "columnDefs": [
        { "orderable": false, "targets": 7 },
      ]
    });
  });

  $(document).ready(function() {
    $('#weekSalesTable').DataTable({
      "searching": false,
      "paging": false,
      "columnDefs": [
        { "orderable": false, "targets": 7 },
      ]
    });
  });

  $(document).ready(function() {
    $('#OffersTable').DataTable({
      "columnDefs": [
        { "orderable": false, "targets": 6 },
      ]
    });
  });

});
