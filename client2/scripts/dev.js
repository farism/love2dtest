const { spawn } = require('child_process')
const chokidar = require('chokidar')
const path = require('path')

const BUILD_FOLDER = 'build'
const PATH = path.resolve(BUILD_FOLDER)

const start = () => {
  proc = spawn('love', [BUILD_FOLDER], {
    stdio: 'inherit',
  })
}

chokidar.watch(PATH, {}).on('change', filepath => {
  console.log('file changed: ', filepath.replace(PATH, ''))

  proc && proc.kill('SIGINT')

  start()
})

start()
