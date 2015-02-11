# robis

Retrieve data from the OBIS Web Services (under development)

## Install

```R
library(devtools)
install_github("pieterprovoost/robis")
```

## Usage

```R
library(robis)
species <- c("Carcharodon carcharias", "Mola mola", "Ursus maritimus", "Aptenodytes forsteri")
data <- get_occurrences(species, 500)
map_occurrences(data)
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map.png)
