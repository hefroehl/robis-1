# robis

R package for retrieving data from the OBIS Web Services (under development)

## Install

```R
library(devtools)
install_github("pieterprovoost/robis")
```

## Usage

### AphiaID

```R
# get AphiaID from WoRMS

get_aphiaid(c("Abra alba", "Lanice"))
```

```text
[1] "141433" "129697"
```

### Occurrences

```R
# find by AphiaId

data <- get_occurrences(137094, 500, type="aphiaid")

# find by species name

names <- c("Carcharodon carcharias", "Mola mola", "Ursus maritimus", "Aptenodytes forsteri")
data <- get_occurrences(names, 500)

# bounding box

data <- get_occurrences("Carcharodon carcharias", bbox=c(-180,-20,180,20))

# filter

data <- get_occurrences("Abra alba", filter=c(yearcollected=2010, monthcollected=7))

# create map

map_occurrences(data)
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map.png)
