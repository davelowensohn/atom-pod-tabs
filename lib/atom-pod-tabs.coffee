AtomPodTabsView = require './atom-pod-tabs-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomPodTabs =
  atomPodTabsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomPodTabsView = new AtomPodTabsView(state.atomPodTabsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomPodTabsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-pod-tabs:toggle': => @toggle()

    # Process currently open tabs & set up observer for new ones
    atom.workspace.observeTextEditors () ->
      console.log('observer firing')
      # activeEditors = atom.workspace.getTextEditors()
      tabArray = document.getElementsByClassName('title')

      # podCruft = '/app/components/'
      podCruft = '/atom-pod-tabs/'

      for aTab, index in tabArray
        fileName = aTab.dataset.name
        filePath = aTab.dataset.path
        # fileName = activeEditors[index].getTitle()
        # filePath = activeEditors[index].getPath()
        splitName = filePath.split ///#{podCruft}///
        displayName = splitName[...].pop()
        aTab.textContent = displayName

      # for thisEditor in activeEditors
      #   fileName = thisEditor.getTitle()
      #   filePath = thisEditor.getPath()
      #   splitName = filePath.split ///#{podCruft}///
      #   displayName = splitName[...].pop()

        # console.log 'fileName: ' + fileName
        # console.log 'filePath: ' + filePath
        console.log 'splitName: ' + splitName
        console.log 'displayName: ' + displayName
        # console.log 'dataset.name: ' + aTab.dataset.name

        # div.title where data-name = fileName
        # innerHtml replace with displayName


  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomPodTabsView.destroy()

  serialize: ->
    atomPodTabsViewState: @atomPodTabsView.serialize()

  toggle: ->
    console.log 'AtomPodTabs was toggled!'

    # if @modalPanel.isVisible()
    #   @modalPanel.hide()
    # else
    #   @modalPanel.show()
