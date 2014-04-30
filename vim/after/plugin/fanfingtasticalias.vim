"" FanfingTastic aliases

if exists(':FanfingTasticAlias')
    FanfingTasticAlias <C-D> /\d/
    FanfingTasticAlias <C-U> /\u/
    FanfingTasticAlias <C-W> /\C[[:alnum:]]\@<![[:alnum:]]\\|[^[:upper:]]\@<=[[:upper:]]\\|[[:upper:]][[:lower:]]\@=/
    FanfingTasticAlias <C-E> /\C[[:alnum:]][[:alnum:]]\@!\\|[[:lower:][:digit:]][[:upper:]]\@=\\|[[:upper:]]\%([[:upper:]][[:lower:]]\)\@=/
endif

