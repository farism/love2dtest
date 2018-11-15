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
    ([file]) => {
      app.ports.openLevelIn.send(fs.readFileSync(file, 'utf8'))
    }
  )
})

app.ports.saveLevelOut.subscribe(level => {
  console.log(JSON.parse(level))
})
