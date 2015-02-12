# robis

Retrieve data from the OBIS Web Services (under development)

## Install

```R
library(devtools)
install_github("pieterprovoost/robis")
```

## Usage
### Occurrences

```R
library(robis)

# get AphiaID from WoRMS

get_aphiaid("Abra alba")

# find by AphiaId

data <- get_occurrences(137094, 500, type="aphiaid")

# find by species name

names <- c("Carcharodon carcharias", "Mola mola", "Ursus maritimus", "Aptenodytes forsteri")
data <- get_occurrences(names, 500)

# create map

map_occurrences(data)
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map.png)
