library(googlesheets4)
library(dotenv)
library(tidyverse)

load_dot_env()

meu_email <- Sys.getenv("GOOGLE_EMAIL")
url_da_planilha <- Sys.getenv("PLANILHA_URL")

gs4_auth(email = meu_email)

abas <- c("CIA", "CVA", "CVZ", "CCZ", "CVS", "CES", "CFS")

dados_completos <- map_df(abas, ~ {
  read_sheet(url_da_planilha, sheet = .x, skip = 3, col_types = "c") %>%
    filter(!is.na(`Nº CHAMADO`)) %>%
    mutate(AbaOrigem = .x)
})
