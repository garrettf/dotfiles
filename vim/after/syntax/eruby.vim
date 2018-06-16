" Use markdown syntax highlighting inside 'md do' blocks in eruby files
" (feel free to replace with 'pandoc.vim' if you use the vim-pandoc-syntax plugin)
syn include @markdownSyntax syntax/markdown.vim
syn region erubyMarkdown start=/<% md do %>/ end=/<% end %>/ contains=@markdownSyntax keepend
