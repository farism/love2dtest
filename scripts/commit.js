const { exec } = require('shelljs')

console.log(process.npm_config_argv)

exec('exec < /dev/tty && git cz --hook --colors', (code, stdout, stderr) => {
  console.log('Exit code:', code)
  console.log('Program output:', stdout)
  console.log('Program stderr:', stderr)
})
