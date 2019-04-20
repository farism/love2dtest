const { exec } = require('child_process')
const chokidar = require('chokidar')
const path = require('path')

const CWD = path.resolve(__dirname, '../build/src')

let proc

const start = () => {
  proc = exec('love .', { cwd: CWD })

  proc.stdout.on('data', console.log)

  proc.stderr.on('data', console.error)
}

// One-liner for current directory, ignores .dotfiles
chokidar.watch(CWD, {}).on('all', (event, path) => {
  proc && proc.kill('SIGINT')

  start()
})

start()
