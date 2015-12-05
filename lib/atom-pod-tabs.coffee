{CompositeDisposable} = require 'atom'

module.exports = AtomPodTabs =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-pod-tabs:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()

  toggle: ->
    console.log 'AtomPodTabs was toggled!'
    @renameTabs()

  myCallback: ->
    console.log 'Coffeescript makes me feel stupid'

  renameTabs: ->

    # Process currently open tabs & set up observer for new ones
    # atom.workspace.observePaneItems () ->
    atom.workspace.observeActivePaneItem () ->
      # @myCallback()
      # DRY this up once I know how to execute callbacks in coffeescript
      tabArray = document.getElementsByClassName('title')
      podCruft = '/app/components/'

      thisEditor = atom.workspace.getActivePaneItem()
      thisFile = thisEditor?.buffer.file
      thisFilePath = thisFile?.path

      if thisEditor

        if (thisFilePath.search ///#{podCruft}///) != -1
          thisSplitName = thisFilePath.split ///#{podCruft}///
          thisDisplayName = thisSplitName[...].pop()
          document.title = thisDisplayName

        for aTab, index in tabArray
          fileName = aTab.dataset.name
          filePath = aTab.dataset.path

          if (filePath.search ///#{podCruft}///) != -1
            splitName = filePath.split ///#{podCruft}///
            displayName = splitName[...].pop()
            aTab.textContent = displayName
            # console.log 'splitName: ' + splitName
            # console.log 'displayName: ' + displayName
          else
            aTab.textContent = fileName

    # Re-process remaining open tabs when one is closed
    # Necessary step so things don't get overwritten by atom/tabs
    atom.workspace.onDidDestroyPaneItem () ->
      # @myCallback()
      # DRY this up once I know how to execute callbacks in coffeescript
      tabArray = document.getElementsByClassName('title')
      podCruft = '/app/components/'

      thisEditor = atom.workspace.getActivePaneItem()
      thisFile = thisEditor?.buffer.file
      thisFilePath = thisFile?.path

      if thisEditor

        if (thisFilePath.search ///#{podCruft}///) != -1
          thisSplitName = thisFilePath.split ///#{podCruft}///
          thisDisplayName = thisSplitName[...].pop()
          document.title = thisDisplayName

        for aTab, index in tabArray
          fileName = aTab.dataset.name
          filePath = aTab.dataset.path

          if (filePath.search ///#{podCruft}///) != -1
            splitName = filePath.split ///#{podCruft}///
            displayName = splitName[...].pop()
            aTab.textContent = displayName
            # console.log 'x-splitName: ' + splitName
            # console.log 'x-displayName: ' + displayName
          else
            aTab.textContent = fileName
