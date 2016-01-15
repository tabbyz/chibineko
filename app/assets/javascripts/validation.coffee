$(document).ready ->
  $(document).on "keyup", ".form-control.validation", ->
    $(this).popover("destroy")


  $(document).on "ajax:beforeSend", "form", (e, xhr, settings) ->
    console.log "ajax:beforeSend"
    $(".form-control.validation").popover("destroy")
    $(".form-group").removeClass("has-error")


  $(document).on "ajax:success", "form", (e, data, status, xhr) ->
    console.log "ajax:success"


  $(document).on "ajax:error", "form", (e, xhr, status, error) ->
    console.log("ajax:error")
    errors = $.parseJSON(xhr.responseText)
    form = $(e.currentTarget)
    name = form.find(".form-control").attr("name")
    model = name.match(/^(.*)\[.*\]$/)[1]

    for k, v of errors
      field = $("##{model}_#{k}")
      msg = "#{k} #{v[0]}"
      group = field.parent(".form-group")

      if group.find(".form-control-feedback").length == 0
        group.addClass("has-error has-feedback")
        field.popover({ content: msg, placement: "bottom", trigger: "manual" }).popover("show")
        popover = group.children(".popover")
        popover.addClass("error")
        popover.css("left", 0)

      group.find(".popover-content").text(msg)

      btn = group.nextAll(".ladda-button:first")
      btn.ladda().ladda("stop")

  
  $(document).on "ajax:complete", "form", (e, xhr, status) ->
    # console.log("complete")