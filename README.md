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

data <- get_occurrences("Abra alba", 
  filter=list(yearcollected=2010, institutioncode="Scottish Natural Heritage"))

# explicit where clause

data <- get_occurrences("Abra alba", where="monthcollected > 8")

# create map

map_occurrences(data)
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map.png)

```R
# change color criterium

data <- get_occurrences(get_aphiaid("Balaenoptera musculus"), type="aphiaid", 
  where="resource_id = 22 or resource_id = 2553")
map_occurrences(data, color="resname")
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map2.png)

### Gridded species distribution
