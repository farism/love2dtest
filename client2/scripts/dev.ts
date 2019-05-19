/// <reference types="node" />
/// <reference types="lodash" />

import { ChildProcess, spawn } from 'child_process'

let loveProcess: ChildProcess

const startLove = () => {
  if (loveProcess) {
    loveProcess.kill()
  }

  loveProcess = spawn('love', ['build'], { stdio: 'inherit' })

  loveProcess.on('close', (code, signal) => {
    if (signal === null) {
      startLove()
    }
  })
}

const tstlProcess = spawn('tstl', ['-p', 'tsconfig.json', '-w'], {})

tstlProcess.stdout.on('data', data => {
  if (String(data).indexOf('Found 0 errors') >= 0) {
    startLove()
  }
})
