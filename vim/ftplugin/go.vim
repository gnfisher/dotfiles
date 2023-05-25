if executable("golangci-lint")
  let g:ale_linters = {'go': ['golangci-lint', 'gofmt']}
endif
