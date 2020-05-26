library(plotly)
library(htmlwidgets)
coronavirus_df <- read.csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv",
                           stringsAsFactors = FALSE)
df <- coronavirus_df %>% 
  filter(type == "confirmed") %>%
  group_by(country) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases) %>%
  mutate(parents = "Coronavirus - Confirmed Cases") %>%
  ungroup() 
p <- plot_ly(data = df,
             type = "treemap",
             values = ~total_cases,
             labels = ~country,
             parents = ~parents,
             domain = list(column=0),
             name = "Confirmed",
             textinfo = "label+value+percent parent")
saveWidget(p, file="coronatree.html")
saveWidget(p, file="coronatree.pdf")
p
