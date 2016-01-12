$(".tests.show").ready ->
# ==================================================
# Function
# ==================================================
  countAll = () ->
    $(".result-btn").size()


  countLabel = (label) ->
    count = 0
    for e in $(".result-btn")
      count += 1 if $(e).text() == label
    count


  updateProgressBar = () ->
    transition = "width 0.5s ease"
    count = countAll()

    for text in gon.resultLabelTexts
      color = gon.resultLabels[text]
      ratio = countLabel(text) / count * 100
      $(".progress-animation .progress-bar[data-result-text=#{text}]").css({
        width: "#{ratio}%",
        WebkitTransition: transition,
        MozTransition: transition,
        MsTransition: transition,
        OTransition: transition,
        transition: transition
      })


  updateProgressCount = () ->
    tag = "<ul class='nav progress-count-list'>"

    for text in gon.resultLabelTexts
      count = countLabel(text)
      color = gon.resultLabels[text]
      tag += """
      <li>
        <span class='label color-#{color}'>#{text}</span>
        <span class='pull-right count-value'>#{count}</span>
      </li>
      """

    total = countAll()
    tag += """
    <li class='count-total'>
      <span>Total</span>
      <span class='pull-right count-value'>#{total}</span>
    </li>
    </ul>
    """

    $(".progress-count").attr("data-content", tag)


  removeColorClass = (element) ->
    element.removeClass (idx, css) ->
      return (css.match(/\bcolor-\S+/g) || []).join(' ')


  setResult = (btn, label) ->
    dropdownBtn = btn.next()

    removeColorClass(btn)
    removeColorClass(dropdownBtn)
    btn.addClass("color-#{gon.resultLabels[label]}")
    dropdownBtn.addClass("color-#{gon.resultLabels[label]}")

    btn.text(label)


  nextResultLabel = (currentLabel) ->
    idx = $.inArray(currentLabel, gon.resultLabelTexts)
    if idx == gon.resultLabelTexts.length - 1
      gon.resultLabelTexts[0]
    else
      gon.resultLabelTexts[idx + 1]


  prePostResult = null
  postResult = (caseId, result) ->
    clearTimeout(prePostResult)
    prePostResult = setTimeout (-> 
      ajaxPostResult(caseId, result)
    ), 300


  ajaxPostResult = (caseId, result) ->
    $.ajax
      url: "#{gon.test.slug}/#{caseId}"
      type: 'PATCH'
      dataType: 'json'
      data: $.param({
        testcase: { result: result }
      })
      beforeSend: (jqXHR, settings) ->
        # loading true
      error: (jqXHR, textStatus, errorThrown) ->
        console.log "AJAX Error: #{textStatus}"
        # toastr.error("ページをリロードしてから再度操作してください", "エラーが発生しました")
      success: (data, textStatus, jqXHR) ->
        console.log "Successful AJAX call: #{data}"
      complete: (jqXHR, textStatus) ->
        # loading false


# ==================================================
# Event
# ==================================================
  updateProgressBar()
  updateProgressCount()


  $(document).on "click", ".color-picker .color-item", ->
    radio = $(this).prev()
    color = radio.val()

    popover = $(this).parents(".popover")
    triggerElement = popover.prev()
    removeColorClass(triggerElement)
    triggerElement.addClass("color-#{color}")
    triggerElement.val(color)


  # Remove result label
  $(document).on "click", ".delete-result-label-icon", ->
    # Check item count
    tbody = $(this).parents("tbody")
    if tbody.find("tr").size() == 1
      alert("You can not remove any more.")
      return

    # Remove item
    tr = $(this).parents("tr")
    tr.remove()


  # Add result label
  $(document).on "click", ".add-result-label-icon", ->
    table = $(this).parent(".table-footer").prev("table")
    tbody = table.children("tbody")
    tr = tbody.find("tr:first").clone()

    # Check item count
    if tbody.find("tr").size() == 9
      alert("You can not add any more.")
      return

    # Reset value
    textInput = tr.find(".result-label-text > input")
    textInput.val("")
    colorInput = tr.find(".result-label-color > input")
    removeColorClass(colorInput)
    colorInput.addClass("color-white")
    
    # Add Item
    tbody.append(tr)
    $(".select-color").popover({
      html : true, 
      content: $(".popover-content-template").html()
    })


  $(document).on "click", ".result-btn", ->
    label = nextResultLabel($(this).text().trim())
    btn = $(this)
    setResult(btn, label)
    postResult(btn.data("case-id"), label)
    updateProgressBar()
    updateProgressCount()


  $(document).on "click", ".result-item", ->
    groupEle = $(this).closest(".result-btn-group")[0]
    btn = $(groupEle).children(".result-btn")
    label = $(this).text().trim()
    setResult(btn, label)
    postResult(btn.data("case-id"), label)
    updateProgressBar()
    updateProgressCount()