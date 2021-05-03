call ale#linter#Define('r', {
\   'name': 'languageserver',
\   'lsp': 'stdio',
\   'executable': 'R',
\   'command': '%e --slave -e "languageserver::run()"', 
\   'project_root': '.' 
\})
