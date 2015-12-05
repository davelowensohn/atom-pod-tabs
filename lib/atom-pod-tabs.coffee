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

  renameTabs: ->
    # console.log 'renameTabs!'

    # Process currently open tabs & set up observer for new ones
    # atom.workspace.observePaneItems () ->
    #   console.log 'observer firing'
    #   tabArray = document.getElementsByClassName('title')
    #   podCruft = '/lib/'
    #
    #   for aTab, index in tabArray
    #     fileName = aTab.dataset.name
    #     filePath = aTab.dataset.path
    #
    #     if (filePath.search ///#{podCruft}///) != -1
    #       splitName = filePath.split ///#{podCruft}///
    #       displayName = splitName[...].pop()
    #       aTab.textContent = displayName
    #       # console.log 'splitName: ' + splitName
    #       # console.log 'displayName: ' + displayName
    #     else
    #       aTab.textContent = 'fileName'

    # Process currently open tabs & set up observer for new ones
    atom.workspace.observeActivePaneItem () ->

      # DRY this up when I know how to execute callbacks in coffeescript
      tabArray = document.getElementsByClassName('title')
      podCruft = '/lib/'

      thisEditor = atom.workspace.getActivePaneItem()
      thisFile = thisEditor?.buffer.file
      thisFilePath = thisFile?.path

      if (thisFilePath.search ///#{podCruft}///) != -1
        document.title = thisFile + ' (component)'
        console.log 'item: ' + thisFilePath

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
          aTab.textContent = 'fileName'

    atom.workspace.onDidDestroyPaneItem () ->
      console.log 'destructor'

      tabArray = document.getElementsByClassName('title')
      podCruft = '/lib/'

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
          aTab.textContent = 'fileName'
