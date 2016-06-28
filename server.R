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
library(sendmailR)
library(shinyjs)

shinyServer(function(input, output, session) {
  observe({
    toggleState("submit", !is.null(input$email) && input$email != "" && !is.null(input$web_file) && !is.null(input$transc_file) && input$Theta != "")
  })
  
  observeEvent(input$submit, {
    web_file <- input$web_file
    pathway <- input$pathway
    transc_file <- input$transc_file
    # transc.rna = load.gene.data(transc_file$datapath, 2) # this is where it breaks
    # how to determine what column? Numeric??
    Theta <- input$Theta
    filter <- input$filter
    info("Thank you!")

    # output$filter <- renderText({
    #    paste(filter)
    # })

  if (input$pathway == "Kegg") {
    kegg.pathways = load.WebGestalt(web_file$datapath, 'Kegg') 
    KEGGgene.ids = get.genes.kegg(kegg.pathways)
    # prioritized.data = list.filter(transc.rna$transposed.data,KEGGgene.ids)
    # if (is.null(filter)) {
    #   next
    # } else if (filter == 1) {
    #   KEGGprioritized.50meanfiltered.data = overall.mean.filter(KEGGprioritized.data, Theta)
    # } else if (filter == 2) {
    #   KEGGprioritized.50varfiltered.data = overall.var.filter(KEGGprioritized.data, Theta)
    # } else {
    #   KEGGprioritized.50meanfiltered.data = overall.mean.filter(KEGGprioritized.data, Theta)
    #   KEGGprioritized.50varfiltered.data = overall.var.filter(KEGGprioritized.data, Theta)
    # }
  }
  else if (input$pathway == "TF") {
    tf.pathways = load.WebGestalt(web_file$datapath, 'TF')
    TFgene.ids = get.genes.tf(tf.pathways)
    # prioritized.data = list.filter(transc.rna$transposed.data,TFgene.ids)
    # if (is.null(filter)) {
    #   next
    # } else if (filter == 1) {
    #   TFprioritized.50meanfiltered.data = overall.mean.filter(TFprioritized.data, Theta)
    # } else if (fitler == 2) {
    #   TFprioritized.50varfiltered.data = overall.var.filter(TFprioritized.data, Theta)
    # } else {
    #   TFprioritized.50meanfiltered.data = overall.mean.filter(TFprioritized.data, Theta)
    #   TFprioritized.50varfiltered.data = overall.var.filter(TFprioritized.data, Theta)
    # }
  }
  else {
    wiki.pathways = load.WebGestalt(web_file$datapath, 'Wiki')
    Wikigene.ids = get.genes.wiki(wiki.pathways)
    # prioritized.data = list.filter(transc.rna$transposed.data,Wikigene.ids)
    # if (is.null(filter)) {
    #   next
    # } else if (filter == 1) {
    #   Wikiprioritized.50meanfiltered.data = overall.mean.filter(Wikiprioritized.data, Theta)
    # } else if (filter ==2) {
    #   Wikiprioritized.50varfiltered.data = overall.var.filter(Wikiprioritized.data, Theta)
    # } else {
    #   Wikiprioritized.50meanfiltered.data = overall.mean.filter(Wikiprioritized.data, Theta)
    #   Wikiprioritized.50varfiltered.data = overall.var.filter(Wikiprioritized.data, Theta)
    # }
  }

  # sendmailOptions(smtpServer="ASPMX.L.GOOGLE.COM") 
  # from <- ""
  # to <- ""
  # subject <- ""
  # msg <- c("",
  #          mime_part(final_output, ""))
  # # get the final output
  # sendmail(from, to, subject, msg)
  })
})
