const { app, BrowserWindow } = require('electron')
const minimist = require('minimist')
const args = minimist(process.argv.slice(2))

process.env['ELECTRON_DISABLE_SECURITY_WARNINGS'] = true

let win

const createWindow = () => {
  win = new BrowserWindow({
    width: 1280,
    height: 768,
    title: `client${args.id || ''}`,
    webPreferences: {
      nativeWindowOpen: true,
    },
  })

  // win.webContents.toggleDevTools()

  win.loadURL('http://localhost:8080')
}

app.on('ready', createWindow)
