const { execSync } = require('child_process')

const argv = process.env.npm_config_argv || {}
const original = argv.original || []

if (original[0] === 'lerna' && original[1] === 'publish') {
} else {
  execSync('exec < /dev/tty && git cz --hook --colors', {
    stdio: 'inherit',
  })
}
