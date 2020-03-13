call ale#linter#Define('r', {
\   'name': 'languageserver',
\   'lsp': 'stdio',
\   'command': 'R --slave -e "languageserver::run()"',
\   'project_root': 'DESCRIPTION',
\   'language': 'r',
\})
