# NiFi Ingestion Templates

This folder contains some example Nifi Dataflow templates to process data.  To use these templates, on the Component Toolbar, drag the template icon onto the canvas and select the template you wish to use.  For more detailed information on Nifi templates see (http://nifi.apache.org/docs/nifi-docs/html/user-guide.html#templates).


## Hackathon_Pull_Data_Webservice_GeoLocate_Elastic

This template will pull data from an API endpoint and page through the data.  It will attempt to enhance the data by adding a geolocation based on zipcode and then ingest the data into ElasticSearch.

![alt text](https://github.com/boozallen/odp-data-nifi/raw/master/docs/images/Hackathon_API_Flow.png "Webservice Paging with GeoLocation Dataflow")


To trigger the webservice stop/start the TriggerWebservice processor.  This template is designed to hit the endpoints for "awards" and "transactions".

![alt text](https://github.com/boozallen/odp-data-nifi/raw/master/docs/images/TriggerFlow.png "Trigger Flow")

It is executing webservice calls against

```
https://spending-api.us/api/v1/${schemaType}/?page=${pageNumber}
```

The data is then put through a geoprocessor and indexed via ElasticSearch.  The below image shows the configuration for the index and type within ElasticSearch that the data can be queried.

![alt text](https://github.com/boozallen/odp-data-nifi/raw/master/docs/images/ElasticProcessor.png "ElasticSearch Configuration")
