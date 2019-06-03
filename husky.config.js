module.exports = {
  'pre-commit': 'lerna run lint-staged',
  'commit-msg': 'commitlint -E HUSKY_GIT_PARAMS',
}
