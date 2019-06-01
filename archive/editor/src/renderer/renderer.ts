import '@fortawesome/fontawesome-free/css/svg-with-js.min.css'
// import * as dirTree from 'directory-tree'
// import { remote } from 'electron'
import { Elm } from './app/App'
import './styles'

const app = Elm.App.init({
  node: document.getElementById('app'),
  flags: {},
})

// app.ports.selectProjectPathOut.subscribe(() =>
//   remote.dialog.showOpenDialog(
//     remote.getCurrentWindow(),
//     {
//       properties: ['openDirectory'],
//     },
//     paths => {
//       if (paths && paths[0]) {
//         sendSelectProjectPathIn(paths[0])
//       }
//     }
//   )
// )

// app.ports.loadFileOut.subscribe(file =>
//   app.ports.loadFileIn.send([file, fs.readFileSync(file, 'utf8')])
// )

// app.ports.saveFileOut.subscribe(([file, contents]) =>
//   fs.writeFileSync(file, JSON.stringify(contents, null, 2))
// )

// const sendSelectProjectPathIn = (path: string) => {
//   const tree = dirTree(path, {})

//   if (tree) {
//     app.ports.selectProjectPathIn.send(JSON.stringify(tree))

//     return true
//   } else {
//     console.error(`Invalid project path "${path}"`)
//   }
// }

// const watch = projectPath => {
//   if (watcher) {
//     watcher.close()
//   }

//   watcher = chokidar.watch(path.join(projectPath, '/**/*'), {
//     ignoreInitial: true,
//     ignored: EXCLUDE,
//   })

//   watcher.on('all', () => {
//     console.log('change')
//     sendSelectProjectPathIn(projectPath)
//   })
// }

// if (PROJECT_PATH) {
//   sendSelectProjectPathIn(PROJECT_PATH)
//   // watch(PROJECT_PATH)
// }
