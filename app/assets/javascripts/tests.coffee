# ==================================================
# Event
# ==================================================
$(".tests.show").ready ->
  # alert(gon.test.slug)
  # alert(gon.results["未実行"])

  $(document).on "click", ".result-btn", ->
    label = nextResultLabel($(this).text().trim())
    btn = $(this)
    setResult(btn, label)
    postResult(btn.data("case-id"), label)

  $(document).on "click", ".result-item", ->
    groupEle = $(this).closest(".result-btn-group")[0]
    btn = $(groupEle).children(".result-btn")
    label = $(this).text().trim()
    setResult(btn, label)
    postResult(btn.data("case-id"), label)


  setResult = (btn, label) ->
    dropdownBtn = btn.next()

    btn.removeClass (idx, css) ->
      return (css.match(/\bcolor-\S+/g) || []).join(' ')
    dropdownBtn.removeClass (idx, css) ->
      return (css.match(/\bcolor-\S+/g) || []).join(' ')

    btn.addClass("color-#{gon.results[label]}")
    dropdownBtn.addClass("color-#{gon.results[label]}")

    btn.text(label)


  nextResultLabel = (currentLabel) ->
    idx = $.inArray(currentLabel, gon.resultLabels)
    if idx == gon.resultLabels.length - 1
      gon.resultLabels[0]
    else
      gon.resultLabels[idx + 1]


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