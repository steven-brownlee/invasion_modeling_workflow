##

# Dreissenid Correlates Review R Script
# Date: Oct 24 2022
# Author: Steven Brownlee
# Email: sbrownle@sfu.ca

# Description: Script using the package 
#'revtools' to manage and process exported
# .bib files retrieved from literature search.

##

# 1.) Install packages as needed, load library:

#install.packages(c('revtools','tidyverse')


library(revtools)
library(tidyverse)

###

# 2.) Load exported .bib/.ris file from database.

# Search terms: (mussel* AND (dreissen* OR zebra OR quagga) AND (invas* OR non-native OR introduc*))
# AND (habitat OR environment* OR niche) AND (suitability OR requirement* OR limit*)

setwd("./literature_review")

# Web of Science search, Oct 24 2022:

wos_a <- read_bibliography('wos_search_2022.bib')

wos_a <- wos_a %>% select(title, abstract, author)

# ASFA search, Oct 24 2022: 

asfa_a <- read_bibliography('asfa_search_2022_a.ris')
asfa_b <- read_bibliography('asfa_search_2022_b.ris')
asfa_c <- read_bibliography('asfa_search_2022_c.ris')
asfa_d <- read_bibliography('asfa_search_2022_d.ris')
asfa_e <- read_bibliography('asfa_search_2022_e.ris')

asfa_a <- asfa_a %>% select(title, abstract, author)
asfa_b <- asfa_b %>% select(title, abstract, author)
asfa_c <- asfa_c %>% select(title, abstract, author)
asfa_d <- asfa_d %>% select(title, abstract, author)
asfa_e <- asfa_e %>% select(title, abstract, author)

search_comb <- rbind(asfa_a, asfa_b, asfa_c, asfa_d, asfa_e, wos_a)

# 3.) Identify and remove duplicates based on title:

search_match <- find_duplicates(search_comb, 
                                match_variable = "title", 
                                group_variables = NULL, 
                                match_function = "fuzzdist",
                                method = "fuzz_m_ratio", 
                                threshold = 0.1, 
                                to_lower = TRUE, 
                                remove_punctuation = FALSE)

search_unique <- extract_unique_references(search_comb, search_match)

# Since duplication matching process is time intensive, may want to write
# out results:

#write_bibliography(search_unique, 'search_unique.bib', format = 'bib')
#search_unique <- read_bibliography('search_unique.bib')

# 4.) Screen titles and abstracts using 'revtools' GUI:

# Criteria for inclusion/exclusion:

# [1.] Zebra/quagga mussels topic of exploration?     Y/N, yes included
# [2.] North American range?                          N'American included
# [3.] Observational, modeling or experimental?       Observational included
# [4.] Does it discuss correlates of distribution?    Y/N, yes included

# Note below: code to write out file products for steps of search commented out
# to prevent accidental overwriting.

#

# Screen by title and filter by excluded, as assessed by the criteria above.

search_title_screened <- screen_titles(search_unique) 

search_title_screened_subset <- search_title_screened[search_title_screened$screened_titles != 'excluded',]

# Screen by abstract and filter by excluded, as assessed by the criteria above.

search_abstract_screened <- screen_abstracts(search_title_screened_subset)

search_abstract_screened_subset <- search_abstract_screened[search_abstract_screened$screened_abstracts != 'excluded',]

# Select final collection of titles for textual review and export to .csv. 

search_abstract_screened_final <- search_abstract_screened_subset %>% select(title)

write.csv(search_abstract_screened_final, 'title_review.csv')