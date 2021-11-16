(function($) {
  "use strict"; // Start of use strict
  // Toggle the side navigation
  $("#sidebarToggle").on('click', function(e) {
    e.preventDefault();
    $("body").toggleClass("sidebar-toggled");
    $(".sidebar").toggleClass("toggled");
  });

  // Prevent the content wrapper from scrolling when the fixed side navigation hovered over
  $('body.fixed-nav .sidebar').on('mousewheel DOMMouseScroll wheel', function(e) {
    if ($(window).width() > 768) {
      var e0 = e.originalEvent,
        delta = e0.wheelDelta || -e0.detail;
      this.scrollTop += (delta < 0 ? 1 : -1) * 30;
      e.preventDefault();
    }
  });

  // Scroll to top button appear
  $(document).on('scroll', function() {
    var scrollDistance = $(this).scrollTop();
    if (scrollDistance > 100) {
      $('.scroll-to-top').fadeIn();
    } else {
      $('.scroll-to-top').fadeOut();
    }
  });

  // Smooth scrolling using jQuery easing
  $(document).on('click', 'a.scroll-to-top', function(event) {
    var $anchor = $(this);
    $('html, body').stop().animate({
      scrollTop: ($($anchor.attr('href')).offset().top)
    }, 1000, 'easeInOutExpo');
    event.preventDefault();
  });

  $("#add-image").on('click',function() {
        // Save existing images
        var intId = $(".custom-file-input").length;


        if (intId <= 3){
          var formGroup = $("<div class=\"form-group\" id=\"field" + intId + "\">");
          var formRow = $("<div class=\"form-row\">");
          var formCol = $("<div class=\"col-md-10\">");
          var customFile = $("<div class=\"custom-file\">");
          var fInput = $("<input type=\"file\" id=\"validatedCustomFile-" + intId + "\" class=\"custom-file-input\" accept=\"image/*\">");
          var fLabel = $("<label class=\"custom-file-label\" for=\"validatedCustomFile-" + intId + "\">Choose image... </label></div></div></div>");

          customFile.append(fInput);
          customFile.append(fLabel);
          formCol.append(customFile);
          formRow.append(formCol);
          formGroup.append(formRow);
          $("#images_formset").append(formGroup);

          $(".custom-file-input").on("change", function() {
            var fileName = $(this).val().split("\\").pop();
            $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
            var inputsWithImg = $(".has-img").length
            $(this).addClass("has-img");
            $(this).attr('name', "form-" + inputsWithImg + "-image");

          });

          if (intId == 3){
            $("#add-image").prop('disabled', true);
            $("#add-image").attr('class', 'btn btn-outline-secondary');
          }
        }
        // If the uploaded images are 4 turn off the add key
        else{
          $("#add-image").prop('disabled', true);
          $("#add-image").attr('class', 'btn btn-outline-secondary');
        }
        $("#delete-image").show();

    });

    $("#delete-image").on('click',function() {          
          var intId= $(".custom-file-input").length - 1;
          var element="field"+intId;
          $('#' + element).remove();
          $("#add-image").prop('disabled', false);
          $("#add-image").attr('class', 'btn btn-outline-primary');
          // If no image is uploaded, hide the remove button
          if (!intId) {
            $("#delete-image").hide();
          }
      });

    $(".color-selection").on('change',function() {
      let color = $(this).val();
        $(this).css("background-color", color);
      });

    $("#quantities").on('change',function() {
      var sum = 0;
      $("#quantities :input").filter(".form-control").each(function() {
        sum +=  Number($(this).val());
      });
      $("#quantity").val(sum);
    });

    // Automatically fill in a product quantity field
    $("#discount_price").on('change',function() {
      let price = $("#price").val();
      let discount_price = $("#discount_price").val();
      $("#discount_rate").val((((price-discount_price)/price)*100).toFixed(1));

    });


    $(".product-process-img-input").on("change", function() {
      var fileName = $(this).val().split("\\").pop();
      $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
    });

    // Manage image delete button on product edit form
    $(".product-process-img-rmv-btn").on('click',function() {
      // Invert "Remove" - "Cancel" button class
      $(this).toggleClass('btn btn-outline-danger');
      $(this).toggleClass('btn btn-outline-secondary');
      var formId = $(this).attr('id');
      // Checkbox management (hidden)
      if ($(this).hasClass('btn btn-outline-secondary')){
        $(this).html('Cancel')
        $('#' + formId + '-DELETE').prop( "checked", true );
      }else{
        $(this).html('Remove')
        $('#' + formId + '-DELETE').prop( "checked", false );
      }

    });

    $(".clickable-row").click(function() {
        window.location = $(this).data("href");
    });


    $("#search-form").submit(function(e){
      var keyword = $("#search-input").val();
      if (keyword) {
          window.location = '/search-results/' + keyword;
      }
      e.preventDefault();
    });

    $("#search-input-btn").click(function() {
        var keyword = $("#search-input").val();
        if (keyword) {
            window.location = '/search-results/' + keyword;
        }
    });

})(jQuery); // End of use strict
