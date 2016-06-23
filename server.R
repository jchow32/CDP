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

shinyServer(function(input, output, session) {
  
  # observe({
  #   if (input$file == '' || input$transc_file == '') {
  #     session$sendCustomMessage(type = "disableBtn", list(id="submitBtn"))
  #   }
  #   else {
  #     session$sendCustomMessage(type = "enableBtn", list(id="submitBtn"))
  #   }
  # })
  
  observeEvent(input$Submit, {
  
  file <- input$web_file
  
  transc_file <- input$transc_file
  transc.rna = load.gene.data(transc_file, 2)
  # how to determine what column? Numeric??
  
  Theta <- input$theta
  
  filter <- input$filter
  
  if (input$pathway == "Kegg") {
    kegg.pathways = load.WebGestalt(file, 'Kegg')
    KEGGgene.ids = get.genes.kegg(kegg.pathways)
    prioritized.data = list.filter(transc.rna$transposed.data,KEGGgene.ids)
    if (filter == 1) {
      KEGGprioritized.50meanfiltered.data = overall.mean.filter(KEGGprioritized.data, Theta)
    } else {
      KEGGprioritized.50varfiltered.data = overall.mean.filter(KEGGprioritized.data, Theta)
    }
  }
  else if (input$pathway == "TF") {
    tf.pathways = load.WebGestalt(file, 'TF')
    TFgene.ids = get.genes.tf(tf.pathways)
    prioritized.data = list.filter(transc.rna$transposed.data,TFgene.ids)
    if (filter == 1) {
      TFprioritized.50meanfiltered.data = overall.mean.filter(TFprioritized.data, Theta)
    } else {
      TFprioritized.50varfiltered.data = overall.mean.filter(TFprioritized.data, Theta)
    }
  }
  else {
    wiki.pathways = load.WebGestalt(file, 'Wiki')
    Wikigene.ids = get.genes.wiki(wiki.pathways)
    prioritized.data = list.filter(transc.rna$transposed.data,Wikigene.ids)
    if (filter == 1) {
      Wikiprioritized.50meanfiltered.data = overall.mean.filter(Wikiprioritized.data, Theta)
    } else {
      Wikiprioritized.50varfiltered.data = overall.mean.filter(Wikiprioritized.data, Theta)
    }
  }

  })
})


