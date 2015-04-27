## this script read a statement and classify the expenses

## require xlsx and stringr packages
library(xlsx); library(stringr)

cat("to start the computation, write computeStatement()")

computeStatement <- function() {

  dateOfFile <- "2015-04-27"
  file <- paste("C:/Users/user/Documents/_Documents importants/Banques/Swedbank/Swedbank_statement_", 
                dateOfFile, ".csv", sep = "")
  
  ## read the files
  statement <- read.csv(file)
  categories <- read.csv("C:/Users/user/Documents/R_DSSgitWD3/perso_tools/Vilnius/sw_categories2.csv")
  
  rm(file)
  
  ## it's possible to group the following operations in one line :
  ## remove all operations that are not debit or credit, 
  ## like opening/closing balance, summary turnover,...
  statement <- statement[which(statement$X == 20),]
  #### other possibility :
  # statement <- statement[which(statement$Code == "K"|statement$Code == "MK"|statement$Code == "TT"),]
  ## remove Credit operations and keep only Debit ones
  statement <- statement[which(statement$D.K == "D"),]
  # remove non-euro transaction (beware of losing important data)
  statement <- statement[which(statement$Currency == "EUR"),]
  
  ## keep only the relevant columns
  statement <- statement[,c(3:7, 10)]
  
  ## remove drawings from ATM
  statement <- statement[!grepl("GRYNIEJI", statement$Details),]
  
  ## bank fees
  statement[,2] <- as.character(statement[,2])
  statement[,3] <- as.character(statement[,3])
  for(i in 1:length(statement$Code)){
          if("TT" %in% statement[i,6]){
                  statement[i,2] <- "Swedbank"}}
  
  ## special case for Indie Bar
  statement[grepl("Indie Bar", statement$Details),2] <- "Indie Bar"
  
  ## date
  statement[,1] <- as.Date(statement[,1], format = "%Y-%m-%d")
  ## require stringr for the substr() function
  ## change the date of record with the real date of purchase
  for(i in 1:length(statement$Details)){
          if(grepl("PIRKINYS", statement[i,3])){
                  realDate <- substr(statement[i,3],27,36)
                  statement[i,1] <- as.Date(realDate, "%Y.%m.%d")
          }
  }
  rm(realDate)
  
  ## create an empty data frame
  tempDF <- data.frame(matrix(NA, nrow=length(statement$Beneficiary), ncol=1))
  colnames(tempDF) <- "category"
  
  # attach categories to statement
  statement <- cbind(statement, tempDF)
  rm(tempDF)
  # ## change the names by the real names
  categories[,1] <- as.character(categories[,1]) # for the FUN to grab the "chr"
  categories[,3] <- as.character(categories[,3])
  categories[,4] <- as.character(categories[,4])
  
  for(i in 1:length(statement[,2])){
          for(z in 1:length(categories[,2])){
                  if(grepl(categories[z,2], statement[i,2])){
                          statement[i,2]<- categories[z,3]
                          statement[i,7]<- categories[z,1]
                          statement[i,3]<- categories[z,4]}
          }}
  rm(i,z)
  
  ## change the columns order
  statement <- statement[,c(1:3,7,4:6)]
  colnames(statement) <- c("Date", "Tiers", "Objet", "Category", "Montant",
                            "Curr", "Code")
  
  ## write in an Excel file
  write.xlsx(statement,file="C:/Users/user/Documents/_Documents importants/Banques/Swedbank/tempStatement.xlsx", 
             row.names = FALSE)

} ## end of computeStatement() function

