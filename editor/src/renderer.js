import 'normalize.css'
import 'reset-css'
import '@fortawesome/fontawesome-free/css/svg-with-js.min.css'
import { resolve } from 'path'
import { remote } from 'electron'
import fs from 'fs'
import path from 'path'
import dirTree from 'directory-tree'
import chokidar from 'chokidar'

import { Elm } from './app/App.elm'

const PATH = resolve(process.cwd(), '..')
const PROJECT_PATH = localStorage.getItem('projectPath')
const EXCLUDE = /\.git|\.vs-code|elm-stuff|node_modules/

const app = Elm.App.init({
  node: document.getElementById('app'),
  flags: {},
})

let watcher = null

app.ports.selectProjectPathOut.subscribe(() =>
  remote.dialog.showOpenDialog(
    null,
    {
      defaultPath: PATH,
      properties: ['openDirectory'],
    },
    ([path]) => {
      localStorage.setItem('projectPath', path)

      sendSelectProjectPathIn(path)
      watch(path)
    }
  )
)

app.ports.loadFileOut.subscribe(file =>
  app.ports.loadFileIn.send([file, fs.readFileSync(file, 'utf8')])
)

app.ports.saveFileOut.subscribe(([file, contents]) =>
  fs.writeFileSync(file, JSON.stringify(contents, null, 2))
)

const sendSelectProjectPathIn = path => {
  const tree = dirTree(path, {
    exclude: EXCLUDE,
  })

  if (tree) {
    app.ports.selectProjectPathIn.send(JSON.stringify(tree))

    return true
  } else {
    console.error(`Invalid project path "${path}"`)
  }
}

const watch = projectPath => {
  return

  if (watcher) {
    watcher.close()
  }

  watcher = chokidar.watch(path.join(projectPath, '/**/*'), {
    ignoreInitial: true,
    ignored: EXCLUDE,
  })

  watcher.on('all', () => {
    console.log('change')
    sendSelectProjectPathIn(projectPath)
  })
}

if (PROJECT_PATH) {
  sendSelectProjectPathIn(PROJECT_PATH)
  watch(PROJECT_PATH)
}
