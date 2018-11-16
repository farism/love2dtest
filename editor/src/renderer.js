import 'normalize.css'
import 'reset-css'
import { resolve } from 'path'
import { remote } from 'electron'
import fs from 'fs'

import { Elm } from './app/App.elm'

const PATH = resolve(process.cwd(), '../assets/levels')

const flags = {
  foo: 'bar',
}

const app = Elm.App.init({
  node: document.getElementById('app'),
  flags,
})

app.ports.loadLevelOut.subscribe(() => {
  remote.dialog.showOpenDialog(null, { defaultPath: PATH }, ([file]) => {
    const contents = fs.readFileSync(file, 'utf8')

    app.ports.loadLevelIn.send([file, contents])
  })
})

app.ports.saveLevelOut.subscribe(([file, contents]) => {
  fs.writeFileSync(file, JSON.stringify(contents, null, 2))
})
