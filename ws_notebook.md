WebScraping
================

<img src="https://rvest.tidyverse.org/logo.png" style="width:7.0%" />

## Introdução a WebScraping

WebScraping é a prática de coleta dados de endereços web de forma
automática, usando um software ou script para coletar informações que
seriam difíceis ou impossíveis de obter manualmente.

<!-- ## Estrutura WEB -->
<!-- ```{r image, echo=FALSE, fig.align='left',out.width = "10%"} -->
<!-- knitr::include_graphics("https://raw.githubusercontent.com/learnbr/html-css/master/logo.png") -->
<!-- ``` -->
<!-- HTML5 (Hypertext Markup Language), é uma das primeiras e principais linguagens de marcação da web e CSS3 (Cascading Style Sheets) define estilos e design do projeto web. -->

## Estrutura básica html

    <!DOCTYPE html>
    <html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
        
        <link rel="stylesheet" href="style.css">
        
        <title>Posit</title>
    </head>
    <body>
        <nav class="navbar">
            <div class="pages">
                <a href="#">Linux</a>
                <a href="#">Windows</a>
                <a href="#">MacOS</a>
        </nav>

        <section class="content">
            <div class="content-ide">
                <img src="https://posit.co/wp-content/uploads/2022/09/posit.svg" alt="posit">

                <h1>RStudio IDE</h1>

                <p>O ambiente de codificação mais popular para R, 
                    construído com amor por Posit. Usado por milhões 
                    de pessoas semanalmente, o ambiente de desenvolvimento 
                    integrado (IDE) RStudio é um conjunto de ferramentas 
                    criadas para ajudá-lo a ser mais produtivo com R e Python. 
                    Ele inclui um console e um editor de realce de sintaxe que 
                    oferece suporte à execução direta de código. 
                    Ele também possui ferramentas para plotagem, visualização 
                    de histórico, depuração e gerenciamento de seu espaço de trabalho.</p>
            </div>
        </section>
    </body>
    </html>

`<table>` é um elemento usado para criar tabelas de dados. As tabelas
são usadas para exibir informações organizadas em linhas e colunas, com
cabeçalhos de coluna e linha opcionais. As tabelas são comumente usadas
para exibir dados como horários, informações de produtos, resultados de
pesquisa e muito mais.

    <table>
      <thead>
        <tr>
          <th>Nome</th>
          <th>Sobrenome</th>
          <th>Idade</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>João</td>
          <td>Silva</td>
          <td>30</td>
        </tr>
        <tr>
          <td>Maria</td>
          <td>Santos</td>
          <td>25</td>
        </tr>
      </tbody>
    </table>

`<thead>` define o cabeçalho da tabela ; `<th>` define um cabeçalho de
coluna; `<tbody>` define o corpo da tabela; `<tr>` define uma linha;
`<td>` define as células da tabela.

<!-- ![](https://raw.githubusercontent.com/learnbr/html-css/master/logo.png) -->

## Criando uma `function` no R

Uma função é um bloco de código, definido por parâmetros que retorna
dados como resultado.

``` r
porcem <- function(valor, desconto){
  x <- (valor*desconto)/100
  print(paste0(desconto , "%" , " de ", valor, " é igual a ", x))
}

porcem(100,10)
```

    ## [1] "10% de 100 é igual a 10"

``` r
porcem(323,18)
```

    ## [1] "18% de 323 é igual a 58.14"

``` r
porcem(547,26)
```

    ## [1] "26% de 547 é igual a 142.22"

``` r
porcem(1435,12)
```

    ## [1] "12% de 1435 é igual a 172.2"

## Criando função `get_table`

O primeiro passo para a criação da função de coleta de tabelas em
`HTML5` é ter a url definidida e o caminho Xpath da tabela, extraído com
auxílio do devTools do navegador.

Xpath (XML Path) é uma linguagem utilizada exclusivamente para
identificar ou endereçar as partes de um documento XML. Uma expressão
XPath pode ser uada para procura em um documento XML e extrair
informações de seus nós, que são qualquer parte de um documento, como um
elemento ou atributo.

``` r
url <- "https://kworb.net/spotify/country/br_daily.html"

get_table <- function(url){
  url %>% 
    read_html(encoding="utf-8") %>% 
    html_nodes(xpath = '//*[@id="spotifydaily"]') %>% 
    html_table(header = TRUE)
}
```

A ideia do operador `pipe (%>%)` é realizar uma expressão em sequência.

Na função `get_table` o único paramêtro é o link da pagina web:

1.  `read_html()` codifica a tabela em UTF-8 (8-bit Unicode
    Transformation Format é um tipo de codificação binária (Unicode) de
    comprimento variável)

2.  `html_nodes()` identifica na url o caminho a ser coletado com o
    argumento `xpath = ' '`

3.  `html_table()` identifica que a tabela há nome nas colunas com o
    parâmetro `header = TRUE`

## Extraindo Tabela de um código HTML

``` r
scraping <- sapply(url, get_table)

data <- do.call(rbind, scraping)
data <- as.data.frame(data)
```

A função `sapply()` usa lista, vetor ou quadro de dados como entrada e
fornece saída em vetor ou matriz. É útil para operações em objetos de
lista e retorna um objeto de lista do mesmo comprimento do conjunto
original. A função Sapply em R faz o mesmo trabalho que a função
lapply(), mas retorna um vetor.

A função `do.call()` constrói e executa uma ligação a partir de um nome
ou função e uma lista de argumentos a serem passados para ela.

## WebScraping armazenado em `data.frame`

| Pos | Artist and Title                                                           | Days | Streams   |
|----:|:---------------------------------------------------------------------------|-----:|:----------|
|   1 | AgroPlay - Nosso Quadro (w/ Ana Castela)                                   |   87 | 1,497,125 |
|   2 | Israel & Rodolffo - Seu Brilho Sumiu - Ao Vivo (w/ Mari Fernandez)         |   59 | 1,240,792 |
|   3 | Simone Mendes - Erro Gostoso - Ao Vivo                                     |   94 | 1,236,329 |
|   4 | Marília Mendonça - Leão                                                    |  143 | 1,169,687 |
|   5 | Zé Neto & Cristiano - Oi Balde - Ao Vivo                                   |   73 | 1,116,060 |
|   6 | Israel & Rodolffo - Bombonzinho - Ao Vivo (w/ Ana Castela)                 |  178 | 990,079   |
|   7 | Matheus & Kauan - Não Vitalício (Nunca Mais) - Ao Vivo (w/ Mari Fernandez) |   87 | 960,210   |
|   8 | Henrique & Juliano - Traumatizei - Ao Vivo Em Brasília                     |   87 | 953,617   |
|   9 | Guilherme & Benuto - Duas Três (w/ Ana Castela, Adriano Rhod)              |   80 | 917,953   |
|  10 | Hugo & Guilherme - Mágica - Ao Vivo                                        |   31 | 796,065   |

## Coletando apenas elementos específicos

``` r
link <- "https://www.rdocumentation.org/packages/rvest/versions/1.0.3"
link <- read_html(link)
```

### Por elemento e por rótulo

``` r
# BUsca pelo elemento HTML
link %>% html_elements("h2") %>% html_text2()
```

    ## [1] "Overview"                   "Installation"              
    ## [3] "Usage"                      "Functions in rvest (1.0.3)"

``` r
# Busca pela class 
link %>% html_elements(".ml-2") %>% html_text2()
```

    ## [1] "https://github.com/tidyverse/rvest" "https://rvest.tidyverse.org/"      
    ## [3] "Hadley Wickham"

## WebScraping com Prudência com `Polite`

As duas funções principais do pacote, `bow` e `scrape`, definem e
realizam uma sessão de coleta na web.

`bow` é usado para apresentar o cliente ao host e pedir permissão para
raspar (perguntando contra o arquivo `robots.txt` do host).

OBS:
`O robots.txt é um arquivo deve ser salvo na pasta raiz do site com objetivo de guiar os robôs de busca.`

`scrape` é a função principal para recuperar dados do servidor remoto.
Uma vez que a conexão é estabelecida, não há necessidade de bow
novamente.

``` r
pacman::p_load(polite)

session <- bow("https://www.cheese.com/by_type", force = TRUE)
result <- scrape(session, query=list(t="semi-soft", per_page=100)) %>%
  html_node("#main-body") %>% 
  html_nodes("h3") %>% 
  html_text()

knitr::kable(head(result))
```

| x                       |
|:------------------------|
| 3-Cheese Italian Blend  |
| Abbaye de Citeaux       |
| Abbaye du Mont des Cats |
| Adelost                 |
| ADL Brick Cheese        |
| Ailsa Craig             |
