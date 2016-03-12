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
      $(".progress-animation .progress-bar[data-result-text='#{text}']").css({
        width: "#{ratio}%",
        WebkitTransition: transition,
        MozTransition: transition,
        MsTransition: transition,
        OTransition: transition,
        transition: transition
      })


  updateProgressCount = () ->
    tag = """
    <table class='tableX table-condensedX progress-count-list'>
    <tbody>
    """
    total = countAll()

    for text in gon.resultLabelTexts
      count = countLabel(text)
      ratio = (count / total * 100).toFixed(1)
      color = gon.resultLabels[text]
      tag += """
      <tr>
        <td><span class='label color-#{color}'>#{text}</span></td>
        <td><strong>#{count}</strong></td>
        <td>(#{ratio}%)</td>
      </tr>
      """

    tag += """
    <tr class='count-total'>
      <td>#{I18n.t("js.tests.navbar.total")}</td>
      <td><strong>#{total}</strong></td>
      <td></td>
    </tr>
    </tbody>
    </table>
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
      url: "#{gon.test.slug}/cases/#{caseId}"
      type: 'PATCH'
      dataType: 'json'
      data: $.param({
        testcase: { result: result }
      })
      error: (jqXHR, textStatus, errorThrown) ->
        toastr.warning(I18n.t("js.tests.show.errors.conflict"), I18n.t("js.tests.show.errors.please_reload"))
        # console.log "Ajax Error: #{textStatus}"
      success: (data, textStatus, jqXHR) ->
        # console.log "Ajax Successful: #{data}"


# ==================================================
# Event
# ==================================================
  updateProgressBar()
  updateProgressCount()

  # Color picker
  $(document).on "click", ".color-picker .color-item", ->
    radio = $(this).prev()
    color = radio.val()

    popover = $(this).parents(".popover")
    triggerElement = popover.prev()
    removeColorClass(triggerElement)
    triggerElement.addClass("color-#{color}")
    triggerElement.val(color)


  # Use default label
  $(document).on "click", ".user-default-result-label", ->
    modalBody = $(this).parents(".modal-body")
    table = modalBody.find("table")
    tableFooter = modalBody.find(".table-footer")

    if $(this).is(":checked")
      table.hide()
      tableFooter.hide()
    else
      table.show()
      tableFooter.show()


  # Remove result label
  $(document).on "click", ".delete-result-label-icon", ->
    # Check item count
    tbody = $(this).parents("tbody")
    if tbody.find("tr").size() == 1
      alert(I18n.t("js.tests.edit_result_label.errors.too_short"))
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
      alert(I18n.t("js.tests.edit_result_label.errors.too_long"))
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


  $(document).on "blur", ".testcase-list .note input", ->
    $(this).parents(".best_in_place").attr("data-original-title", $(this).val())


  $(document).on "ajax:error", ".best_in_place", () ->
    toastr.warning(I18n.t("js.tests.show.errors.conflict"), I18n.t("js.tests.show.errors.please_reload"))