**[summary](#techniche) | [usage](#usage) | [walk through notebooks](#running-the-notebooks) | [license](#license)**

## Lumin Human

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

### Context
Night-time lights (NTL) data from earth observation satellites is an alternative data source for research on socio-economic indicators in cases when national or large-N survey data is unavailable, uncertain, or cost-prohbitive. Unsettled questions, new satellites, and novel machine learning techniques make this a fruitful area for continuing research on a range of questions with significant social, economic and socio-environmental implications. 

### Scientific objective
Explore recent techniques and tools that utilize night-time lights (NTL) satellite data in conjunction with socio-economic indicators.

### Scientific question
Can NTL satellite data help predict poverty indicators in rural regions of five countries in the Sub-Saharan Africa region?

### Approach
A recent paper proposing novel approaches involving NTL data serves as a framework and guide for our approach:
Jean et al, 2016. Combining satellite imagery and machine learning to predict poverty. Science, Vol. 353, Issue 6301, pp. 790-794, DOI: 10.1126/science.aaf7894 

### Data understanding
The prediction target is a geo-located indicator of mean annual economic well-being at the unit of a village (rural) or census tract (urban). The underlying data source is household consumption expenditures (spending) - a determinant of employment, poverty and health outcomes - from the World Bank Living Standards Measurement Study (LSMS), which is available at this [link](https://microdata.worldbank.org/index.php/catalog/lsms/about).

We initially focus on two potential sources of NTL data. First, the NOAA Defense Meteorological Satellite Program - Operational Linescan System (DMSP -OLS) is the default data source for existing NTL data in socio-economic research, and is available at this [link](https://ngdc.noaa.gov/eog/dmsp/downloadV4composites.html). Second, we explore the Day/Night Band (DNB) of the Visible Infrared Imaging Radiometer Suite (VIIRS) of NASA/NOAA's Suomi National Polar-orbiting Partnership satellite, which offers potentially higher-quality data, in expectation of the release in 2019 of pre-processed data in a light-noise adjusted form usable for the present research task. The VIIRS dataset is described at this [link](https://earthdata.nasa.gov/earth-observation-data/near-real-time/download-nrt-data/viirs-nrt). 

##### Data understanding - Results
Both NTL data sources (DMSP and VIIRS) are extracted from Google Earth Engine. The script in Google Earth Engine can be found at this [link](https://code.earthengine.google.com/a4343a0c38c2cf49ea2240cd3ffb6971). Replace with your own local drive pathways and file names.

Daytime satellite image data will subsequently be acquired for use in conjunction with the NTL data.

### Data processing
We aggregate the household-level consumption expenditure values to the community level and plot these values on the NTL image. 

##### Data processing - Results:
[Notebook in nbviewer](https://nbviewer.jupyter.org/github/geohackweek/ghw2019_lumin_human/blob/master/notebooks/read_and_plot_survey_data_lumin_human.ipynb)

### Modeling
We envision modeling tasks that proceed from the more simple baseline comparison models to the more elaborate three-stage modeling worfklow (object detection - CNN - ridge regression) with enriched and expanded data that is developed in the above paper. 

[Results - slides](https://github.com/geohackweek/ghw2019_lumin_human/blob/master/contributors/Yohan/geohack.pdf)

### Evaluation
We envision the evaluation metric to be rooot mean squared error (RMSE), as used in the above paper. 
    
### Deployment 
We envision the deployment of the model for user tasking through a basic interactive web application.


 
