##

# Dreissenid Correlates Review R Script
# Date: Sept 28 2021
# Author: Steven Brownlee
# Email: sbrownle@sfu.ca

# Description: Script using the package 
#'revtools' to manage and process exported
# .bib files retrieved from literature search.

##

# 1.) Install packages as needed, load library:

#install.packages('revtools')
#install.packages('tidyverse')

library(revtools)
library(tidyverse)

###

# 2.) Load exported .bib/.ris file from database.

# Search terms: (mussel* AND (dreissen* OR zebra OR quagga) AND (invas* OR non-native OR introduc*))
# AND (habitat OR environment* OR niche) AND (suitability OR requirement* OR limit*)

# Web of Science search, May 24 2021:

WoS_01 <- read_bibliography('wos_search_2021.bib')

# write.csv(WoS_01, 'WoS_01.csv')

# ASFA search, May 24 2021: 

ASFA_a <- read_bibliography('asfa_search_2021_a.ris')
ASFA_b <- read_bibliography('asfa_search_2021_b.ris')
ASFA_c <- read_bibliography('asfa_search_2021_c.ris')
ASFA_d <- read_bibliography('asfa_search_2021_d.ris')

ASFA_comb <- rbind(ASFA_a, ASFA_b, ASFA_c, ASFA_d)

# write.csv(ASFA_01_comb, 'ASFA_01.csv')

# 3.) Identify and remove duplicates based on title:

WoS_match <- find_duplicates(WoS_01, match_variable = "title", group_variables = NULL, match_function = "fuzzdist",
                             method = "fuzz_m_ratio", threshold = 0.1, to_lower = TRUE, remove_punctuation = FALSE)
ASFA_match <- find_duplicates(ASFA_comb, match_variable = "title", group_variables = NULL, match_function = "fuzzdist",
                              method = "fuzz_m_ratio", threshold = 0.1, to_lower = TRUE, remove_punctuation = FALSE)

WoS_unique_2021 <- extract_unique_references(WoS_01, WoS_match)
ASFA_unique_2021 <- extract_unique_references(ASFA_comb, ASFA_match)

# save(WoS_unique_2021, file = "WoS_unique.rData")

# save(ASFA_unique_2021, file = "ASFA_unique.rData")

setwd()

load("WoS_unique_2021.rData")
load("ASFA_unique_2021.rData")

# 4.) Screen titles and abstracts using 'revtools' GUI:

# Criteria for inclusion/exclusion:

# [1.] Zebra/quagga mussels topic of exploration?     Y/N, yes included
# [2.] North American range?                          N'American included
# [3.] Observational, modeling or experimental?       Observational included
# [4.] Does it discuss correlates of distribution?    Y/N, yes included

# Note below: code to write out file products for steps of search commented out
# to prevent accidental overwriting.

#

setwd('/home/sbrownlee/mnt/10TB/NCA/SFU/AA - Dreissenid Literature Review Github Repository/Dreissenid_Literature_Review')

WoS_title_screened <- screen_titles(WoS_unique) 

#write_bibliography(WoS_title_screened, 'WoS_title_screened_2021.bib', format = 'bib')

WoS_title_screened <- read_bibliography('WoS_title_screened_2021.bib')

WoS_subset <- WoS_title_screened[WoS_title_screened$screened_titles != 'excluded',]

WoS_abstract_screened <- screen_abstracts(WoS_subset)

#write_bibliography(WoS_abstract_screened, 'WoS_abstract_screened_2021.bib', format = 'bib')

WoS_abstract_screened_2021 <- read_bibliography('WoS_abstract_screened_2021.bib')

WoS_abstract_screened_subset <- WoS_abstract_screened_2021[WoS_abstract_screened_2021$screened_abstracts != 'excluded',]

WoS_titles <- WoS_abstract_screened_subset %>% select(title)

#

ASFA_title_screened <- screen_titles(ASFA_unique)

#write_bibliography(ASFA_title_screened, 'ASFA_title_screened.bib', format = 'bib')

ASFA_title_screened <- read_bibliography('ASFA_title_screened.bib')

ASFA_subset<- ASFA_title_screened[ASFA_title_screened$screened_titles != 'excluded',]

ASFA_abstract_screened <- screen_abstracts(ASFA_subset)

#write_bibliography(ASFA_abstract_screened, 'ASFA_abstract_screened.bib', format = 'bib')

ASFA_abstract_screened <- read_bibliography('ASFA_abstract_screened_2021.bib')

# Note: Minor difference in formatting between WoS and ASFA, column is 'screened_abstracts' not
# 'abstract_screened'. Unknown why it's different.

ASFA_abstract_screened_subset <- ASFA_abstract_screened[ASFA_abstract_screened$screened_abstracts != 'excluded',]

# 5.) Concatenate final list of papers from ASFA and WoS, filter for duplicates and retrieve 
# records for final review list.

ASFA_titles <- ASFA_abstract_screened_subset %>% select(title)

WoS_titles <- WoS_abstract_screened_subset %>% select(title)

titles_comb <- rbind(WoS_titles, ASFA_titles)

titles_unique <- unique(titles_comb)

write.csv(titles_unique, 'title_review.csv')