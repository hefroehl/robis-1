# robis

R package for retrieving data from the OBIS Web Services

## Install

```R
devtools::install_github("pieterprovoost/robis")
```

## Usage

[Occurrences](#occurrences)  
[Gridded taxon distribution](#distribution)  
[Bodiversity indices](#biodiversity)  
[Export](#export)

<a name="occurrences"></a>
### Occurrences
#### Find by species name

```R
names <- c("Carcharodon carcharias", "Mola mola", "Ursus maritimus", "Aptenodytes forsteri")
data <- get_occurrences(names)
````

#### Find by AphiaID (species only)

Finding species occurrences by AphiaID is considerably faster than by species name. AphiaIDs can be retrieved from WoRMS using [taxizesoap](https://github.com/ropensci/taxizesoap) or [get_aphiaid.R](https://gist.github.com/pieterprovoost/754d5363509e8e7176bc).

```R
data <- get_occurrences(137094)
````

#### Find by OBIS Taxon ID

Species:

```R
data <- get_occurrences(409234, id="obis")
````

Higher level taxa (slow):

````R
data <- get_occurrences(780806, id="obis", children=TRUE)
````

#### Find by storedpath

```R
data <- get_occurrences("x739909x738303x741923x762719x766931
  x766932x642142x778875x781762x778804x696387x752492x739483x769778x")
````

#### Bounding box

```R
data <- get_occurrences("Carcharodon carcharias", bbox=c(-180,-20,180,20))
````

#### Filtering

```R
data <- get_occurrences("Abra alba", 
  filter=list(yearcollected=2010, institutioncode="Scottish Natural Heritage"))

# explicit where clause

data <- get_occurrences("Abra alba", where="monthcollected > 8")
````

#### Create occurrence map

```R
map_occurrences(data)
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map.png)

#### Change color criterium

```R
data <- get_occurrences("Balaenoptera musculus",
  where="resource_id = 22 or resource_id = 2553")
map_occurrences(data, color="resname")
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map2.png)

#### Map bounding box

```R
m <- map_occurrences(data)
m + coord_quickmap(xlim = c(-20, 30), ylim=c(50, 60))
```

<a name="distribution"></a>
### Gridded taxon distribution

```R
data <- get_distribution("Mola mola")
map_distribution(data)
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map3.png)

<a name="biodiversity"></a>
### Bodiversity indices
#### C-squares

```R
data <- get_summaries()
map_summaries(data, "shannon")
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map4.png)

#### Hexgrid

```R
data <- get_hexsummaries()
map_summaries(data, "shannon")
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/map5.png)

```R
data <- get_hexsummaries(typeName = "hexgrid5")
data <- data[data$centre_latitude > -10,]

map_summaries(data, "es", style=style_jet(seq(0, 50, by=5))) + 
  coord_map("ortho", orientation=c(90, 0, 0)) +
  theme(legend.position="right")
```

![map](https://raw.githubusercontent.com/pieterprovoost/robis/master/ortho.png)

<a name="export"></a>
### Export
#### Export to GeoJSON using the rwkt package

See [here](https://github.com/pieterprovoost/robis/blob/master/eubranchus.geojson) for an example file

```R
library(devtools)
install_github("pieterprovoost/rwkt")
library(rwkt)

data <- get_occurrences(743268, id="obis", children=TRUE, maxFeatures=5)
geometry <- paste0("GEOMETRYCOLLECTION(", paste(data$geom, collapse=","), ")")
data <- data[,c("id", "yearcollected", "tname", "collectioncode")]

toGeoJSON(geometry, pretty=TRUE, data=data)
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
