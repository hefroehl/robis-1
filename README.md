# robis

Retrieve data from the OBIS Web Services

## Install

```R
library("robis")
```

## Usage

```R
species <- c("Carcharodon carcharias", "Mola mola", "Ursus maritimus", "Aptenodytes forsteri")
data <- get_occurrences(species, 500)
map_occurrences(data)
```
