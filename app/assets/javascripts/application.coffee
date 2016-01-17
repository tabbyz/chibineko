#= require jquery
#= require jquery_ujs
#= require jquery.cookie
#= require jstz
#= require browser_timezone_rails/set_time_zone
#= require bootstrap-sprockets
#= require best_in_place
#= require Sortable.min
#= require ladda/spin.min
#= require ladda/ladda.min
#= require ladda/ladda.jquery.min
#= require jquery.readyselector
#= require_tree .

$(document).ready ->
  $("[data-toggle='popover']").popover({ container: 'body' })
  $("[data-toggle='tooltip']").tooltip({ container: 'body' })
  $(".dropdown-toggle").dropdown()
  $(".best_in_place").best_in_place()
  $(".carousel").carousel()

  $(document).on 'shown.bs.modal', (e) ->
    $('[autofocus]', e.target).focus()

  $(document).on "click", '.collapse-btn', (e) ->
    if $(this).hasClass("collapsed")
      $(this).text("expand")
    else
      $(this).text("close")