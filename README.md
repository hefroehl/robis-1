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
[Export](#export)

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
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map.png)

```R
# map bounding box

m <- map_occurrences(d)
m + coord_quickmap(xlim = c(-20, 30), ylim=c(50, 60))

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

<a name="export"></a>
### Export

```R
# export to GeoJSON using the rwkt package

library(devtools)
install_github("pieterprovoost/rwkt")

data <- get_occurrences(743268, id="obis", children=TRUE, maxFeatures=5)
geometry <- paste0("GEOMETRYCOLLECTION(", paste(data$geom, collapse=","), ")")
data <- data[,c("id", "yearcollected", "tname", "collectioncode")]

geojson(geometry, pretty=TRUE, data=data)
```

```json
{
    "type": "FeatureCollection",
    "features": [
        {
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [
                    33.7082,
                    44.4106
                ]
            },
            "properties": {
                "id": 149287642,
                "yearcollected": 1996,
                "tname": "Ampelisca diadema",
                "collectioncode": "Laspibay-Black Sea"
            }
        },
        {
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [
                    33.7072,
                    44.4096
                ]
            },
            "properties": {
                "id": 149287011,
                "yearcollected": 1996,
                "tname": "Balanus improvisus",
                "collectioncode": "Laspibay-Black Sea"
            }
        },
        {
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [
                    11.109,
                    42.2386
                ]
            },
            "properties": {
                "id": 146490918,
                "yearcollected": 1999,
                "tname": "Chthamalus stellatus",
                "collectioncode": "pp"
            }
        },
        {
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [
                    11.109,
                    42.2386
                ]
            },
            "properties": {
                "id": 146490947,
                "yearcollected": 2000,
                "tname": "Balanus",
                "collectioncode": "pp"
            }
        },
        {
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [
                    11.109,
                    42.2386
                ]
            },
            "properties": {
                "id": 146491001,
                "yearcollected": 2001,
                "tname": "Chthamalus stellatus",
                "collectioncode": "pp"
            }
        }
    ]
}
```
