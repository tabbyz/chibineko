$(".tests.new, .tests.edit").ready ->
# ==================================================
# Function
# ==================================================
  caseTag = (markdown) ->
    tag = ""
    array = markdown.split(/\r\n|\r|\n/)
    for line in array
      switch caseType(line)
        when "heading"
          lv = caseHeadingLevel(line)
          body = caseBody(line)
          
          if tag == ""
            tag += "<div class='testcase-group'>"
          else if lv == 1
            tag += "</div><div class='testcase-group'>" if lv == 1
          
          tag += """
            <div class="tr heading heading-level-#{lv}">
              <div class="td body">
                #{body}
              </div>
            </div>
          """
        when "testcase"
          tag += "<div class='testcase-group'>" if tag == ""
            
          body = caseBody(line)
          tag += """
            <div class="tr testcase">
              <div class="td number"></div>
              <div class="td body">
                #{body}
              </div>
            </div>
          """

    tag = "<div class='testcase-list'>" + tag + "</div></div>"
    

  caseHeadingLevel = (text) ->
    return -1 if text == ""

    text = text.trim()
    if text.substr(0, 1) == "#"
      text.match(/^#*/)[0].length
    else
      0


  caseType = (text) ->
    switch caseHeadingLevel(text)
      when -1 then "blank"
      when 0 then "testcase"
      else "heading"


  caseBody = (text) ->
    switch caseType(text)
      when "heading"
        text.match(/^(#*)(.*)/)[2]
      when "testcase"
        r = text.match(/(.*)(,\s?\[.*\])/)
        if r then r[1] else text


  preUpdatePreview = null
  updatePreview = () ->
    clearTimeout(preUpdatePreview)
    preUpdatePreview = setTimeout (-> 
      e = $("#test_markdown")
      if e.length
        if markdown = e.val()
          tag = caseTag(markdown)
          $(".test-preview-content").empty()
          $(".test-preview-content").append(tag)
          $(".test-preview-content").show()
          $(".test-cheatsheet").hide()
        else
          $(".test-preview-content").hide()
          $(".test-cheatsheet").show()
    ), 200


# ==================================================
# Event
# ==================================================
  updatePreview()

  $(document).on "keyup", "#test_markdown", ->
    updatePreview()

  # $(document).on "scroll", "#test_markdown", ->  # TODO: Doesn't work
  $("#test_markdown").scroll ->
    syncScroll($(this))

  $("#test_markdown").overlay( {
    match: /^#.*|\n#.*/g,
    css: {"background-color": "#DDD"}
  })


# TODO: To local methods
@syncScroll = (e) ->
  source = e
  target = $(".test-preview-content")
  sourceScrollMax = source.get(0).scrollHeight - source.get(0).offsetHeight
  targetScrollMax = target.get(0).scrollHeight - target.get(0).offsetHeight
  scrollRatio = source.scrollTop()/ sourceScrollMax
  target.scrollTop(targetScrollMax * scrollRatio)