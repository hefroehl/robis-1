# robis

R package for retrieving data from the OBIS Web Services (under development)

## Install

```R
library(devtools)
install_github("pieterprovoost/robis")
```

## Usage

[AphiaID](#aphiaid)  
[Occurrences](#occurrences)  
[Gridded taxon distribution](#distribution)  
[Bodiversity indices](#biodiversity)  

<a name="aphiaid"></a>
### AphiaID

```R
# get AphiaID from WoRMS

get_aphiaid(c("Abra alba", "Lanice"))
```

```text
[1] "141433" "129697"
```

<a name="occurrences"></a>
### Occurrences

```R
# find by species name (species only)

names <- c("Carcharodon carcharias", "Mola mola", "Ursus maritimus", "Aptenodytes forsteri")
data <- get_occurrences(names)

# find by AphiaId (species only)

data <- get_occurrences(137094)

# find by OBIS Taxon ID (species only)

data <- get_occurrences(409234, id="obis")

# find by OBIS Taxon ID (any taxon level, slow)

data <- get_occurrences(780806, id="obis", children=TRUE)

# find by storedpath (any taxon level)

data <- get_occurrences("x739909x738303x741923x762719x766931
  x766932x642142x778875x781762x778804x696387x752492x739483x769778x")

# bounding box

data <- get_occurrences("Carcharodon carcharias", bbox=c(-180,-20,180,20))

# filter

data <- get_occurrences("Abra alba", 
  filter=list(yearcollected=2010, institutioncode="Scottish Natural Heritage"))

# explicit where clause

data <- get_occurrences("Abra alba", where="monthcollected > 8")

# create map

map_occurrences(data)

# zoom map

m <- map_occurrences(d)
m + coord_quickmap(xlim = c(-20, 30), ylim=c(50, 60))
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map.png)

```R
# change color criterium

data <- get_occurrences(get_aphiaid("Balaenoptera musculus"),
  where="resource_id = 22 or resource_id = 2553")
map_occurrences(data, color="resname")
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map2.png)

<a name="distribution"></a>
### Gridded taxon distribution

```R
data <- get_distribution("Mola mola")
map_distribution(data)
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map3.png)

<a name="biodiversity"></a>
### Bodiversity indices

```R
# c-squares

data <- get_summaries()
map_summaries(data, "shannon")
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map4.png)

```R
# hexgrid

data <- get_hexsummaries()
map_summaries(data, "shannon")
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map5.png)

