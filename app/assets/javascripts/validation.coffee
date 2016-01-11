$(document).ready ->

  $(document).on "ajax:success", "form", (e, data, status, xhr) ->
    console.log "success"


  $(document).on "ajax:error", "form", (e, xhr, status, error) ->
    # console.log("error")
    # console.log xhr
    # console.log status
    # console.log error

    errors = $.parseJSON(xhr.responseText)
    # console.log errors
    form = $(e.currentTarget)
    name = form.find(".form-control").attr("name")
    model = name.match(/^(.*)\[.*\]$/)[1]
    
    for k, v of errors
      field = $("##{model}_#{k}")
      msg = "#{k} #{v[0]}"
      group = field.parent(".form-group")
      group.children(".error-message").text(msg)
      if !group.hasClass("has-feedback")
        group.addClass("has-error has-feedback")
        field.after("<div aria-hidden='true' class='glyphicon glyphicon-remove form-control-feedback'></div>")

  
  $(document).on "ajax:complete", "form", (e, xhr, status) ->
    # console.log("complete")