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
    toggleState("submit", !is.null(input$email) && input$email != "" && !is.null(input$web_file) && !is.null(input$transc_file))
  })
  
  web_file <- reactive({
    get(input$web_file)
  })
  
  observeEvent(input$submit, {
    web_file <- input$web_file
    transc_file <- input$transc_file
    info("Thank you!")
  
  # observeEvent(input$submit, {
  #   
  #   web_file <- input$web_file
  #   
  #   output$web_file <- renderText({
  #     paste(web_file$size)
  #   })

    transc_file <- input$transc_file
    # transc.rna = load.gene.data(transc_file, 2) # this is where it breaks
   # how to determine what column? Numeric??
    Theta <- input$Theta
    filter <- input$filter

  if (input$pathway == "Kegg") {
    kegg.pathways = load.WebGestalt(web_file, 'Kegg') # this is also where is breaks
    # Warning: Error in readLines: 'con' is not a connection
    KEGGgene.ids = get.genes.kegg(kegg.pathways)
  #   prioritized.data = list.filter(transc.rna$transposed.data,KEGGgene.ids)
  #   if (filter == 1) {
  #     KEGGprioritized.50meanfiltered.data = overall.mean.filter(KEGGprioritized.data, Theta)
  #   } else {
  #     KEGGprioritized.50varfiltered.data = overall.mean.filter(KEGGprioritized.data, Theta)
  #   }
  }
  else if (input$pathway == "TF") {
    tf.pathways = load.WebGestalt(web_file, 'TF')
    TFgene.ids = get.genes.tf(tf.pathways)
  #   prioritized.data = list.filter(transc.rna$transposed.data,TFgene.ids)
  #   if (filter == 1) {
  #     TFprioritized.50meanfiltered.data = overall.mean.filter(TFprioritized.data, Theta)
  #   } else {
  #     TFprioritized.50varfiltered.data = overall.mean.filter(TFprioritized.data, Theta)
  #   }
  }
  else {
    wiki.pathways = load.WebGestalt(web_file, 'Wiki')
    Wikigene.ids = get.genes.wiki(wiki.pathways)
  #   prioritized.data = list.filter(transc.rna$transposed.data,Wikigene.ids)
  #   if (filter == 1) {
  #     Wikiprioritized.50meanfiltered.data = overall.mean.filter(Wikiprioritized.data, Theta)
  #   } else {
  #     Wikiprioritized.50varfiltered.data = overall.mean.filter(Wikiprioritized.data, Theta)
  #   }
  }

  # sendmailOptions(smtpServer="ASPMX.L.GOOGLE.COM")
  # 
  # from <- ""
  # to <- ""
  # subject <- ""
  # msg <- c("",
  #          mime_part(final_output, ""))
  # # get the final output
  # 
  # sendmail(from, to, subject, msg)
  })
})


