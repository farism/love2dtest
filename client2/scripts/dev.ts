/// <reference types="node" />

import { ChildProcess, spawn } from 'child_process'
import * as chokidar from 'chokidar'
import { copy, remove } from 'fs-extra'

let loveProcess: ChildProcess

const startLove = () => {
  if (loveProcess) {
    loveProcess.kill('SIGINT')
  }

  loveProcess = spawn('love', ['build'], { stdio: 'inherit' })
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

const startAssetSyncing = (pattern: string) => {
  chokidar
    .watch(pattern, {})
    .on('add', path => copy(path, `build/${path}`))
    .on('change', path => copy(path, `build/${path}`))
    .on('unlink', path => remove(`build/${path}`))
    .on('unlinkDir', path => remove(`build/${path}`))
}

startTstl()

startAssetSyncing('audio/**')
startAssetSyncing('images/**')
startAssetSyncing('levels/**')
startAssetSyncing('lib/**')
