import 'normalize.css'
import 'reset-css'
import { remote, shell } from 'electron'
import fs from 'fs'

import { Elm } from './app/App.elm'

const flags = {
  foo: 'bar',
}

const app = Elm.App.init({
  node: document.getElementById('app'),
  flags,
})

app.ports.openFileOut.subscribe(() => {
  remote.dialog.showOpenDialog(
    null,
    {
      defaultPath: process.cwd(),
    },
    ([file]) => {
      app.ports.openFileIn.send(fs.readFileSync(file, 'utf8'))
    }
  )
})
