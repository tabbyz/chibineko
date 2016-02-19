$(".tests.show").ready ->
  
  $(document).on "click", ".move-test-modal .clickable", ->
    $(".project-list .clickable.active").removeClass("active")
    $(this).addClass("active")

    project_id = $(this).attr("data-project-id")
    $(".selected-id-field").val(project_id)