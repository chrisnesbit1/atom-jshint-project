JshintProjectView = require './jshint-project-view'
{CompositeDisposable} = require 'atom'

module.exports = JshintProject =
  jshintProjectView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @jshintProjectView = new JshintProjectView(state.jshintProjectViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @jshintProjectView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that runs this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'jshint-project:run': => @run()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @jshintProjectView.destroy()

  serialize: ->
    jshintProjectViewState: @jshintProjectView.serialize()

  run: ->
    console.log 'JshintProject was run!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
