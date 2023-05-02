pacman::p_load(rvest, dplyr, stringr)

#### TAVBELA COMPLETA

# page <- seq(0,19260,60)
# url <- paste0("https://sofifa.com/players?type=all&aeh=21&offset=",page)

#### TABELA COM 60obs
url <- "https://sofifa.com/players?type=all"

get_table <- function(url){
  url %>% 
    read_html(encoding="utf-8") %>% 
    html_nodes(xpath = '//*[@id="body"]/div[1]/div/div[2]/div/table') %>% 
    html_table(header = T)
}

scraping <- sapply(url, get_table)

data <- do.call(rbind, scraping)
data <- as.data.frame(data)

