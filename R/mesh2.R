## FUNCTIONS TO parse getNodeSet output

xpath2 <-function(Node, path){
     y <- XML::xpathSApply(Node, path, XML::xmlValue)
     ifelse(length(y)==0, NA,
        ifelse(length(y)>1, paste(y, collapse="; "), y))
}

## get mesh descriptor and qualifier
mesh2 <-function(Node){
path2 <- ".//meshHeading/descriptorName|.//meshHeading//qualifierName"
  # Get descriptors and qualifiers
   mesh <- XML::xpathSApply(Node, path2 , XML::xmlValue)
 if(length(mesh)>0){
  # Mark terms that are major topics of the article  with an asterisk
   topic <-  XML::xpathSApply(Node, ".//meshHeading//majorTopic_YN", XML::xmlValue)
   topic <- ifelse(topic=="Y", "*", "")
   # paste * to mesh term
   mesh <- paste0(mesh, topic)

   ## Paste "/" before qualifier names
   qual  <- XML::xpathSApply(Node,  path2, XML::xmlName)
   qual <- ifelse( qual =="qualifierName", "/", "")
  mesh <- paste0(qual, mesh)

   #merge descriptor and qualifier# SEE http://stackoverflow.com/questions/38364060/paste-some-elements-of-mixed-vector

   mesh <- as.vector(unlist(tapply(mesh, cumsum(!grepl("^/", mesh)), function(x) paste0(x[1], x[-1]))))
   }else{
     mesh<- NA
  }
   paste(mesh, collapse="; ")
}

# Mesh tags in NCBI nlm catalog have initial caps and majorTopic is an attribute
mesh3 <-function(Node){

  # Get descriptors and qualifiers
   path2 <- ".//MeshHeading/DescriptorName|.//MeshHeading/QualifierName"
   mesh <- XML::xpathSApply(Node, path2, XML::xmlValue)
 if(length(mesh)>0){
  # Mark terms that are major topics with an asterisk
   topic <-  XML::xpathSApply(Node, path2, XML::xmlGetAttr, "MajorTopicYN")
   topic <- ifelse(topic=="Y", "*", "")
   # paste * to mesh term
   mesh <- paste0(mesh, topic)

   ## Paste "/" before qualifier names
   qual  <- XML::xpathSApply(Node,  path2, XML::xmlName)
   qual <- ifelse( qual =="QualifierName", "/", "")
  mesh <- paste0(qual, mesh)
   mesh <- as.vector(unlist(tapply(mesh, cumsum(!grepl("^/", mesh)), function(x) paste0(x[1], x[-1]))))
   }else{
     mesh<- NA
  }
   paste(mesh, collapse="; ")
}
