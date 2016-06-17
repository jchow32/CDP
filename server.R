# source("http://bioconductor.org/biocLite.R")
# biocLite("SSOAP",suppressUpdates=T)
# biocLite("AnnotationDbi",suppressUpdates=T)
# biocLite("GSEABase",suppressUpdates=T)
# biocLite("Biostrings",suppressUpdates=T)
# biocLite("KEGGREST",suppressUpdates=T)
# install.packages('devtools',repos='http://cran.us.r-project.org')
# library(devtools)
# install_github("Anderson-Lab/ComplementaryDomainPrioritization")

library(ComplementaryDomainPrioritization)
library(shiny)

shinyServer(function(input, output) {
  reactive({ 
  
  file <- input$file
  if (input$pathway == "Kegg") {
    kegg.pathways = load.WebGestalt(file, 'Kegg')
    KEGGgene.ids = get.genes.kegg(kegg.pathways)
  }
  else if (input$pathway == "TF") {
    tf.pathways = load.WebGestalt(file, 'TF')
    TFgene.ids = get.genes.tf(tf.pathways)
  }
  else {
    wiki.pathways = load.WebGestalt(file, 'Wiki')
    Wikigene.ids = get.genes.wiki(wiki.pathways)
  }
  
  })
})


