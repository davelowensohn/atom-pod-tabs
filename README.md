# Atom Pod Tabs

### Better tabs for working with Ember.js pods

I just started a new Ember.js project using the pod directory structure, and found it much harder to navigate around Atom when all the various components share filenames (multiple instances of `controller.js`, `route.js`, `template.hbs` instead of `component1.js`, `component1.hbs`, `component2.js`, `component2.hbs`, etc). Tabs are harder to jump between, it's harder to know where you are or what you're working on at a glance. You can opt to display the entire project path, but this only creates a new problem, as the part of the path you care about is almost always pushed out of the tab by something like `/User/yourname/github/app/components/...`

I asked around for protips to make it less painful and was told this is just how it is. But I'm a creature of habit & figure I can't be the only one who feels this way. For developers who spend more time interacting with their project files through editor tabs than filesystem folders, this incurs a nontrivial usability penalty and demands some kind of fix.

Since routable components are the way of the future and this was really messing up my flow, I decided to write a plugin that conditionally adds terminal component directory names to Atom tabs and window titles. This is my first Atom package & very much a work in progress, but assuming your app follows the standard `/app/components/my-component/controller.js` (etc.) naming conventions, this will make it a whole lot easier to see what files you have open at a glance.

### TODOS
* TODO: Assign class .podtastic to ul.tab-bar to indicate toggle state (classList.add not working)
* TODO: DRY up redundant old/new tab code with callback
* TODO: Figure out how to turn the thing off
* TODO: Add keyboard shortcut for fast cycling between files in pod directory (CMD-CTRL-UP)
* TODO: Write tests
