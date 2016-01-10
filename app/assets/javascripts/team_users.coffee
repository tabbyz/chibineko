$(".projects, .teams, .tests").ready ->
# ==================================================
# Function
# ==================================================
  preSearchUser = null
  searchUser = (team, email) ->
    clearTimeout(preSearchUser)
    preSearchUser = setTimeout (-> 
      ajaxSearchUser(team, email)
    ), 500


  ajaxSearchUser = (team, email) ->
    btn = $(".ladda-button").ladda()
    label = btn.find(".ladda-label")
    
    $.ajax
      url: "/#{team}/team_users/ajax_search_user"
      type: 'GET'
      dataType: 'json'
      data: $.param({
        email: email
      })
      beforeSend: (jqXHR, settings) ->
        label.text("Search user...")
        btn.ladda("start")
      error: (jqXHR, textStatus, errorThrown) ->
        console.log "AJAX Error: #{textStatus}"
        btn.ladda("stop")
        label.text("Unknown error")
        btn.prop("disabled", true)
      success: (data, textStatus, jqXHR) ->
        if data
          label.text("Add user to team")
          btn.ladda("stop")
          btn.prop("disabled", false)
        else
          label.text("User not found")
          btn.ladda("stop")
          btn.prop("disabled", true)


# ==================================================
# Event
# ==================================================
  $(document).on "keyup", "#new_team_user #email", ->
    email = $(this).val()
    team = $("#team_name").val()
    searchUser(team, email)