import 'normalize.css'
import 'reset-css'
import { resolve } from 'path'
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

app.ports.openLevelOut.subscribe(() => {
  remote.dialog.showOpenDialog(
    null,
    {
      defaultPath: resolve(process.cwd(), '../assets/levels'),
    },
    ([name]) => {
      fs.readFile(name, 'utf8', (err, contents) => {
        app.ports.openLevelIn.send(contents)
      })
    }
  )
})

app.ports.saveLevelOut.subscribe(({ name, contents }) => {
  console.log(name, contents)
})
