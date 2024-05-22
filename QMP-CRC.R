# Load the mia R package
library(mia)

### Defining FILE PATHS ###

url_to_assay <- url("https://raw.githubusercontent.com/ShadmanIshraq/CRC_QMP_example_data/main/CRC_assay.csv")
url_to_coldata <- url("https://raw.githubusercontent.com/ShadmanIshraq/CRC_QMP_example_data/main/CRC_coldata.csv")
url_to_rowdata <- url("https://raw.githubusercontent.com/ShadmanIshraq/CRC_QMP_example_data/main/CRC_rowdata.csv")


### Importing FILES ###

CRC_assay <- read.csv(url_to_assay,row.names = 1)
colnames(CRC_assay) <- gsub("\\.", "-", colnames(CRC_assay))

CRC_coldata <- read.csv(url_to_coldata, row.names = 1)
CRC_rowdata <- read.csv(url_to_rowdata, row.names = 1)

### Constructing TSE ###

tse <- TreeSummarizedExperiment(assays = list(counts = CRC_assay),
                                colData = CRC_coldata,
                                rowData = CRC_rowdata)

### SAVE into RDS ###
saveRDS(tse, file = "CRCtse.rds")


