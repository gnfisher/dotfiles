if executable("golangci-lint")
  let g:ale_linters = {'go': ['golangci-lint', 'gofmt']}
endif

set tabstop=4 softtabstop=4 shiftwidth=4 " Default tab size
