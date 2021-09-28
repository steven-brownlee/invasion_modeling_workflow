---
title: "Paper Review Overview Document"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Review Process

Papers collected via the search strings laid out in the 'search structure' document
were filtered using the 'revtools' package in R. The script 'Dreissenid_paper_review_R_script'
represents the full filtering routine with annotations for transparency and replicability.


```{r echo = FALSE}
## install.packages('webshot')
## webshot::install_phantomjs()

# Above packages may need to be install to run DiagrammeR code below.

library('DiagrammeR')

grViz("digraph flowchart {
  node [fontname = Helvetica, shape =  rectangle, fontsize = 12, 
       style = filled]
 
  tab1 [label = '@@1', fillcolor = LightSteelBlue, alpha = 0.5]
  tab2 [label = '@@2', fillcolor = LightBlue1]
  tab3 [label = '@@3', fillcolor = PaleTurquoise1]
  tab4 [label = '@@4', fillcolor = PaleTurquoise2]
  tab5 [label = '@@5', fillcolor = LightBlue2]
  tab6 [label = '@@6', fillcolor = PaleTurquoise3]
  tab7 [label = '@@7', fillcolor = LightBlue3]
  tab8 [label = '@@8', fillcolor = Honeydew2]
  tab9 [label = '@@9', fillcolor = Honeydew3]
  tab10 [label = '@@10', fillcolor = DarkSeaGreen3]
  
  tab1 -> tab2 [arrowhead = vee];
  tab1 -> tab3 [arrowhead = vee];
  
  tab3 -> tab4 [arrowhead = vee];
  tab4 -> tab6 [arrowhead = vee];
  tab6 -> tab8 [arrowhead = vee];
  
  tab2 -> tab5 [arrowhead = vee];
  tab5 -> tab7 [arrowhead = vee];
  tab7 -> tab8 [arrowhead = vee];
  
  tab8 -> tab9 [arrowhead = vee];
  tab9 -> tab10 [arrowhead = vee];
  
  # Add tabs to reflect initial duplicate screens for each search
  
  }

[1]: 'Query Databases'
  [2]: 'ASFA (n = 3539)'
  [3]: 'Web of Science (n = 1468)'
  [4]: 'Screen records by title (n = 262)'
  [5]: 'Screen records by title (n = 81)'
  [6]: 'Screen records by abstract (n = 44)'
  [7]: 'Screen records by abstract (n = 63)'
  [8]: 'Combine database records (n = 107)'
  [9]: 'Screen for duplicates (n = 89)'
  [10]: 'Export for analysis'
  
  ")
```
### Analysis and Results of Review

The above figure, taken from the pre-established search protocol in the 'search
structure' document, shows the results for each of the steps of filtering papers.

Papers were evaluated at the title and then the abstract level for meeting the following
criteria in sequential order:

> [1.] Zebra/quagga mussels topic of exploration?     Y/N, yes include

> [2.] North American range?                          North American included

> [3.] Observational, modeling or experimental?       Observational included

> [4.] Does it discuss correlates of distribution?    Y/N, yes included

Failure to meet any of the criteria would result in the paper being excluded from the analysis.
At the abstract level, the stage at which a paper failed to meet a criterion was noted within the 
review sheet and replicated here seperately for the ASFA and WoS searches.

Database records were combined together after filtering and screened for duplicates before being 
exported for analysis. 