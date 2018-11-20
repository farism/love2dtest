import 'normalize.css'
import 'reset-css'
import { resolve } from 'path'
import { remote } from 'electron'
import fs from 'fs'
import dirTree from 'directory-tree'

import { Elm } from './app/App.elm'

const PATH = resolve(process.cwd(), '..')

const flags = {
  foo: 'bar',
}

const app = Elm.App.init({
  node: document.getElementById('app'),
  flags,
})

app.ports.selectProjectOut.subscribe(() =>
  remote.dialog.showOpenDialog(
    null,
    {
      defaultPath: PATH,
      properties: ['openDirectory'],
    },
    ([directory]) =>
      app.ports.selectProjectIn.send(
        JSON.stringify(
          dirTree(directory, { exclude: [/\.git/, /node_modules/] })
        )
      )
  )
)

app.ports.loadLevelOut.subscribe(file =>
  app.ports.loadLevelIn.send([file, fs.readFileSync(file, 'utf8')])
)

app.ports.saveLevelOut.subscribe(
  ([file, contents]) => console.log({ file, contents })
  // fs.writeFileSync(file, JSON.stringify(contents, null, 2))
)
