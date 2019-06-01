/// <reference types="node" />

import { ChildProcess, spawn } from 'child_process'
import * as chokidar from 'chokidar'
import { copy, remove } from 'fs-extra'

let loveProcess: ChildProcess

const startLove = () => {
  if (loveProcess) {
    loveProcess.kill('SIGINT')
  }

  loveProcess = spawn('love', ['dist'], { stdio: 'inherit' })
}

const startTstl = () => {
  const tstlProcess = spawn('tstl', ['-w', '-p', 'tsconfig.json'], {})

  tstlProcess.stdout.on('data', data => {
    console.log(String(data))

    if (String(data).indexOf('Found 0 errors') >= 0) {
      startLove()
    }
  })
}

const startFileSync = (pattern: string) => {
  chokidar
    .watch(pattern, {})
    .on('add', path => copy(path, `dist/${path}`))
    .on('change', path => copy(path, `dist/${path}`))
    .on('unlink', path => remove(`dist/${path}`))
    .on('unlinkDir', path => remove(`dist/${path}`))
}

startTstl()

startFileSync('lib/**')
startFileSync('assets/audio/**')
startFileSync('assets/images/**')
startFileSync('assets/levels/**')
