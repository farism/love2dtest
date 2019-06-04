const { execSync } = require('child_process')

console.log(process.npm_config_argv)

execSync('exec < /dev/tty && git cz --hook --colors', { stdio: 'inherit' })

// child_process.execSync('npm init', {stdio: 'inherit'});

// exec('exec < /dev/tty && git cz --hook --colors', (code, stdout, stderr) => {
//   console.log('Exit code:', code)
//   console.log('Program output:', stdout)
//   console.log('Program stderr:', stderr)

//   // process.stdout.write(stdout)
// })
