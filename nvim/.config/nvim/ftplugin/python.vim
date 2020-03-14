let b:ale_linters = ['pyls', 'flake8']
let b:ale_fixers = [
\   'autopep8',
\   'remove_trailing_lines',
\   'isort',
\   'ale#fixers#generic_python#BreakUpLongLines',
\   'yapf',
\]
