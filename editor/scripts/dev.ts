import { ChildProcess, spawn } from 'child_process'
import * as webpack from 'webpack'
import { mainConfig, rendererConfig } from './config'
const formatMessages = require('webpack-format-messages')

let electronProcess: ChildProcess

const startElectronProcess = () => {
  if (electronProcess) {
    electronProcess.kill('SIGINT')
  }

  electronProcess = spawn('electron', ['.'], { stdio: 'inherit' })

  electronProcess.on('close', (code, signal) => {
    if (signal === null) {
      startElectronProcess()
    }
  })
}

const formatCompilerMessages = (id: string, compiler: webpack.Compiler) => {
  compiler.hooks.invalid.tap('invalid', function() {
    console.log(`(${id}) Compiling...`)
  })

  compiler.hooks.done.tap('done', stats => {
    const messages = formatMessages(stats)

    if (!messages.errors.length && !messages.warnings.length) {
      console.log(`(${id}) Compiled successfully!`)
    }

    if (messages.errors.length) {
      console.log(`(${id}) Failed to compile.`)
      messages.errors.forEach((e: any) => console.log(e))
      return
    }

    if (messages.warnings.length) {
      console.warn(`(${id}) Compiled with warnings.`)
      messages.warnings.forEach((w: any) => console.log(w))
    }
  })
}

const mainCompiler = webpack(mainConfig)

mainCompiler.watch({}, (err: any, stats: any) => {
  startElectronProcess()
})

formatCompilerMessages('Main', mainCompiler)

const rendererCompiler = webpack(rendererConfig)

rendererCompiler.watch({}, (err: any, stats: any) => {})

formatCompilerMessages('Renderer', rendererCompiler)
