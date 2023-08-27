#install.packages("igraph")
#Use the library "igraph"
library(igraph)

#An empty bipartite network
g <- graph.empty(directed = F)
#The nodes in nodelist1, and nodelist2 are unique values.
nodelist1<- c("1030", "1010", "1060", "1050", "1020", "1040", "1070")
nodelist2 <-c("B1", "B2","B3","B4", "B5") 
#The list of edges
edge.list <- c("B1", "1030", "B1", "1010", "B1", "1060", "B1", "1020", "B2", "1030", 
               "B2", "1010", "B2", "1060", "B2", "1040", "B3", "1050", "B3", "1020", "B3","1070", "B4","1020","B4","1040","B5","1020","B5","1040","B5","1070")
#add nodes: "TRUE" or "FALSE" in "type" indicate two modes of nodes.
g <- add.vertices(g,nv=length(nodelist1),attr=list(name=nodelist1), type=rep(FALSE,length(nodelist1)))
g <- add.vertices(g,nv=length(nodelist2),attr=list(name=nodelist2), type=rep(TRUE,length(nodelist2)))
g <- add.edges(g,edge.list)


#Incidence matrix computation
incidence<-as_incidence_matrix(g)

#Print out the created bipartite network
print(g, v=TRUE)
shape <- ifelse(V(g)$type, "circle", "square") # assign shape by node type
col <- ifelse(V(g)$type, "red", "yellow") # assign color by node type
plot(g, vertex.shape = shape, layout=layout_as_bipartite, vertex.color = col)


#Project to one-mode
proj.g <- bipartite.projection(g)

plot(proj.g[[1]], main = "Bipartite Projection: Credit_cards")
plot(proj.g[[2]], main = "Bipartite Projection: Customer_ID")

#Compute the matrix P
P<-t(incidence)%*%incidence

#Create a bipartite matrix using a dataframe
data_bipartite<-data.frame("Credit_cards"=c("B1", "B1", "B1", "B1", "B2", "B2", "B2", "B2", "B3", "B3", "B3", "B4", "B4", "B5", "B5", "B5"),
                           "Customer_ID"=c("1030", "1010", "1060", "1020", "1030", "1010", "1060", "1040", "1050", "1020", "1070", "1020", "1040","1020","1040","1070"))
nodelist1<- unique(data_bipartite$Credit_cards)
nodelist2 <- unique(data_bipartite$Customer_ID)
edges.list<-as.vector(t(as.matrix(data.frame(data_bipartite))))
g <- graph.empty(directed = F)
g <- add.vertices(g,nv=length(nodelist1),attr=list(name=nodelist1), type=rep(FALSE,length(nodelist1)))
g <- add.vertices(g,nv=length(nodelist2),attr=list(name=nodelist2), type=rep(TRUE,length(nodelist2)))
g <- add.edges(g,edges.list)

shape <- ifelse(V(g)$type, "circle", "square") # assign shape by node type
col <- ifelse(V(g)$type, "red", "yellow") # assign color by node type
plot(g, vertex.shape = shape, layout=layout_as_bipartite, vertex.color = col)

