#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require_tree .

jQuery ->
  # $("a[rel~=popover], .has-popover").popover()
  $("[data-toggle='tooltip']").tooltip()
  $(".dropdown-toggle").dropdown()

  $(document).on 'shown.bs.modal', (e) ->
    $('[autofocus]', e.target).focus()