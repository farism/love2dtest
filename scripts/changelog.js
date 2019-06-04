const child_process = require('child_process')

child_process.spawn(
  'yarn',
  [
    'lerna',
    'exec',
    '--concurrency',
    '1',
    '--stream',
    `conventional-changelog \\
      --preset=angular \\
      --release-count=0 \\
      --commit-path=$PWD \\
      --pkg=$PWD/package.json \\
      --outfile=$PWD/CHANGELOG.md \\
      --lerna-package=$LERNA_PACKAGE_NAME
    `,
  ],
  {
    stdio: 'inherit',
  }
)

child_process.spawn(
  'yarn',
  [
    'conventional-changelog',
    '--preset=angular',
    '--release-count=0',
    '--outfile=CHANGELOG.md',
  ],
  {
    stdio: 'inherit',
  }
)
