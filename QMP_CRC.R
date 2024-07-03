# Load necessary packages
library(mia)
library(stringr)
library(S4Vectors)


### Defining FILE PATHS ###
path_to_assay <- "CRC_assay.csv"
path_to_coldata <- "CRC_coldata.csv"
path_to_rowdata <- "CRC_rowdata.csv"

### Importing FILES ###
CRC_assay <- read.csv(path_to_assay, row.names = 1, check.names = FALSE)
colnames(CRC_assay) <- gsub("\\.", "-", colnames(CRC_assay))

CRC_coldata <- read.csv(path_to_coldata, row.names = 1)
CRC_rowdata <- read.csv(path_to_rowdata, row.names = 1)

# Replace periods with underscores in rowdata column names
colnames(CRC_rowdata) <- str_replace_all(colnames(CRC_rowdata), "\\.", "_")

# Convert empty strings to NA in coldata and rowdata
CRC_coldata[CRC_coldata == ""] <- NA
CRC_rowdata[CRC_rowdata == ""] <- NA

# Convert CRC_coldata and CRC_rowdata to DataFrame objects
CRC_coldata <- DataFrame(CRC_coldata)
CRC_rowdata <- DataFrame(CRC_rowdata)

# Convert colData fields to factors
CRC_coldata[] <- lapply(CRC_coldata, function(x) {
  if (is.character(x)) {
    return(as.factor(x))
  } else {
    return(x)
  }
})

### Constructing TSE ###
tse <- TreeSummarizedExperiment(
  assays = SimpleList(counts = as.matrix(CRC_assay)),
  colData = CRC_coldata,
  rowData = CRC_rowdata
)

### SAVE into RDA ###
save(tse, file = "CRCtse.rda")
