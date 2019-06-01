import * as chokidar from 'chokidar'
import { app, BrowserWindow, Menu } from 'electron'
import * as ctx from 'electron-context-menu'
import * as path from 'path'
import { template } from './menu'

process.on('uncaughtException', err => {
  console.error(err)
})

ctx({})

let win: BrowserWindow

const setMenu = () => {
  Menu.setApplicationMenu(Menu.buildFromTemplate(template))
}

const createWindow = () => {
  win = new BrowserWindow({
    backgroundColor: '#000000',
    width: 1280,
    height: 768,
    title: `client${new Date().getTime()}`,
    webPreferences: {
      nativeWindowOpen: true,
      nodeIntegration: true,
    },
  })

  // win.webContents.toggleDevTools()

  Menu.setApplicationMenu(Menu.buildFromTemplate(template))

  win.loadURL(
    `file://${path.resolve(process.cwd(), 'build/renderer/index.html')}`
  )
}

app.on('ready', () => {
  setMenu()
  createWindow()
})

chokidar.watch(path.resolve('build/renderer/**')).on('change', () => {
  if (win) {
    win.reload()
    win.show()
  }
})
