# Dynamic riskscapes for prey: Disentangling the impact of human and cougar presence on deer behavior using GPS smartphone locations

Dataset DOI: [10.5061/dryad.51c59zwkg](10.5061/dryad.51c59zwkg)

## Description of the data and file structure

This dataset includes high-resolution animal movement and environmental data used to evaluate prey behavioral responses to spatial and temporal risk from predators and humans. Data were collected between 2015 and 2022 across two ecologically distinct study areas in the American Southwest (Book Cliffs, Colorado/Utah and Pine Valley, Utah). The dataset supports risk-sensitive habitat selection and movement analyses by integrating information on animal space use, landscape features, and modeled risk surfaces.

**Important note:** Only the wildlife GPS data and associated environmental covariates are included in this Dryad data package. The raw human mobility data (e.g., smartphone detections) and aggregated products used in the original study are not included in this repository due to privacy and data-sharing restrictions. The data were obtained through a commercial license and are therefore proprietary, subject to data-sharing restrictions, and handled in compliance with applicable privacy laws.

Reuse potential statements in the associated publication refer to the full dataset, including withheld raw human mobility data, and do not apply to this Dryad data package.

### Files and variables

#### File: MD\_dataset.RDS

**Description:** 

**Wildlife GPS Data:** Location data were collected from GPS-collared female mule deer (*Odocoileus hemionus*). Deer GPS fixes were recorded at 2-hour intervals. Each GPS location is associated with a phenological season (e.g., late gestation, rearing, hunting) and a diel period (day, night, crepuscular). To protect sensitive wildlife location information, all raw spatial coordinates have been removed. Derived environmental and behavioral metrics are retained for reuse. Full covariates are described in Table 1.

**Environmental Covariates:** Spatially explicit raster data include vegetation indices (NDVI), terrain ruggedness, and reclassified land cover categories (e.g., open, forested, shrub). These covariates were extracted for each animal location and included with the 'Wildlife GPS Data.' 

**Risk Surfaces:** The dataset includes modeled probability surfaces representing the relative risk of human and cougar encounters, generated using resource selection functions. These covariates were extracted for each animal location and included with the 'Wildlife GPS Data.'

**Derived Movement Data:** Step lengths and turn angles were calculated between successive deer GPS fixes. These data were used in integrated step selection analyses to evaluate behavioral responses to risk. These covariates were calculated for each animal location and included with the 'Wildlife GPS Data.'

**Table 1.** Variable key for wildlife GPS data.

| Variable                 | Description                                                                                  |
| :----------------------- | :------------------------------------------------------------------------------------------- |
| burst\_                  | Unique movement burst identifier (each burst includes one used and multiple available steps) |
| sl\_                     | Step length (meters) between consecutive GPS locations                                       |
| ta\_                     | Turn angle (radians) between consecutive steps                                               |
| t1\_                     | Start time of movement step (POSIXct format)                                                 |
| t2\_                     | End time of movement step (POSIXct format)                                                   |
| dt\_                     | Duration between GPS fixes (e.g., "2 hours")                                                 |
| tod\_end\_               | Time-of-day category at the end of the step (day, night, or crepuscular)                     |
| case\_                   | Logical indicator for whether the step was used (TRUE) or available (FALSE)                  |
| step\_id\_               | Unique step identifier shared across used and available steps within a burst                 |
| cos\_ta                  | Cosine of turn angle (used in movement modeling)                                             |
| log\_sl                  | Natural log of step length (used in modeling movement rate)                                  |
| NDVI                     | Normalized Difference Vegetation Index at the end of the step                                |
| season                   | Biological season category (e.g., late\_gestation, birthing\_rearing, hunting)               |
| elev\_s2                 | Elevation (meters) at the end of the step                                                    |
| TRI\_s2                  | Terrain Ruggedness Index at the end of the step                                              |
| nlcd\_s2                 | Land cover classification at the end of the step (e.g., Forested, Shrub)                     |
| dt\_rds                  | Distance (meters) to nearest improved road at the end location                               |
| lionRSF\_s2              | Cougar encounter risk (relative probability) at the end of the step                          |
| season.year              | Combined biological season and year identifier (e.g., birthing\_rearing\_2019)               |
| hmd\_avg\_counts\_season | Average number of smartphone detections (human mobility) during the season                   |
| hmd\_prob\_use\_season   | Modeled human encounter risk (relative probability) during the season                        |
| site                     | Study area identifier (BookCliffs or PineValley)                                             |
| animalID                 | Anonymized individual animal identifier                                                      |

## Code/software

Program R (version 4.3.1)


## Human subjects data

The data provider has anonymized the data. Human data has been scaled such that personal information is no longer identifiable. 