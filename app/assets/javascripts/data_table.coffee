$(document).ready ->
  # Bootgrid settings
  $(".data-table").on("initialized.rs.jquery.bootgrid", (e) ->
    $(".table-toolbar").hide().appendTo(".actionBar")
  ).on("loaded.rs.jquery.bootgrid", (e) ->
    $(".table-toolbar").hide()
  ).on("selected.rs.jquery.bootgrid deselected.rs.jquery.bootgrid", (e, rows) ->
    count = $(".bootgrid-table tr.active").length
    if count == 0
      $(".table-toolbar").hide()
    else
      $(".table-toolbar").show()
      $(".table-toolbar .selected-count").text("#{count} #{I18n.t('js.tests.toolbar.selected')}")
  ).bootgrid
    columnSelection: false,
    rowCount: -1,
    selection: true,
    multiSelect: true,
    converters: {
      date: {
        from: (value) -> return moment(value)
        to: (value) -> return moment(value).locale(I18n.locale).format("ll")
      },
    },
    formatters: {
      title: (column, row) -> return "<a href='/t/#{row.slug.trim()}'>#{row.title}</a>"
    },
    labels: {
      loading: I18n.t("js.bootgrid.loading"),
      noResults: I18n.t("js.bootgrid.no_results"),
      search: I18n.t("js.bootgrid.search"),
    },
    templates: {
      infos: "",
      select: "<input name='select[]' type={{ctx.type}} class='select-box' value={{ctx.value}}>"
    }

  # Bulk destroy action
  $(document).on "click", ".bulk-destroy-btn", ->
    if !confirm(I18n.t("js.common.messages.delete_confirm"))
      return false

    tests = []
    for e in $(".bootgrid-table tr.active")
      tests.push $(e).data("row-id")
    
    $.ajax
      url: "/t/bulk_destroy"
      type: 'PATCH'
      dataType: 'script'
      data: $.param({
        tests: tests
      })

  # Bulk move action
  $(document).on "click", ".bulk-move-btn", ->
    project = $(this).data("project-id")
    tests = []
    for e in $(".bootgrid-table tr.active")
      tests.push $(e).data("row-id")
    
    $.ajax
      url: "/t/bulk_move"
      type: 'PATCH'
      dataType: 'script'
      data: $.param({
        tests: tests,
        project: project
      })