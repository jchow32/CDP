

library(shiny)


shinyUI(fluidPage(
  titlePanel(strong("Complementary Domain Prioritization")),
  br(),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", label="WEBGESTALT INPUT", accept = '.tsv'),
      
      radioButtons("pathway", label = "ENRICHMENT PATHWAY", 
                   choices = list("KEGG" = "Kegg", "Transcription factor" = "TF", "WikiPathways" = "Wiki"), selected="Kegg"),
      
      br(),
      
      fileInput("transc_file", label = "TRANSCRIPTOMIC DATA"),
      
      tags$hr(),
      
      radioButtons("filter", label = "INDEPENDENT FILTERING", choices = list("Mean Abundance" = 1, "Variance" = 2), selected=1),
    
      numericInput("num", label="Theta", min = 0, step = 0.1, value=0.5),
      
      actionButton("Submit", "Submit")
      ),
    
    
    mainPanel(
      h3("Stage 1: Gene List Generation"),
      h4("Enrichment Analysis with WebGestalt"),
      br(),
      p("Gene list generation is driven by proteomic data analysis. Quantitative proteomic
data is used along with class labels to detect significant proteins at a given threshold. 
"),
        p("Following KEGG, WikiPathways (WikiP) or TF enrichment
analysis, the resulting pathways and gene sets are downloaded from WebGestalt as
.tsv files. The result of this stage is a set of pathways or gene sets derived from
proteomic data."),
    
      br(),
     
      h3("Stage 2: Gene Prioritization and Filtering"),
      h4("Gene List Prioritization with Pathway Enrichment"),
      br(),
      p("The enriched pathways or gene sets are then queried against the relevant database
to extract the genes belonging to each pathway or gene set of interest."),
      
      tags$ul(
      tags$li("Pathway information for KEGG is extracted using the KEGGREST R package."),
      tags$li("Pathway information for WikiPathways is retrieved using the official web service provided
by WikiPathways."),
      tags$li("Gene set information from the transcription factor database
(via MSigDB) is downloaded and queried locally.")
      ),
      
      p("Resulting gene lists are applied to the entire transcriptomics data set,
thus prioritizing genes involved in pathways showing enrichment at the protein expression level and removing genes not present in these pathways."),
      br(),
      
      h4("Independent Filters"),
      br(),
      p("Invariant filtering is applied to further enhance the power of detection by applying variance or mean abundance filtering."), 
      
      tags$ul(
      tags$li("Variance filtering is defined as ranking
the genes according to variance across samples."),
      tags$li("Mean abundance filtering ranks the genes by the mean
abundance of each gene.")
    ),
    p("For either variance or abundance based filtering, a θ can be specified, which is the target number of ranked variables; otherwise, it is the top θ fraction of ranked variables."),
      br()
      
    )
  )
))

