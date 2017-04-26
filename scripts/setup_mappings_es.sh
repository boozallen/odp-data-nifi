#!/bin/bash

echo "Enter Elasticsearch IP > "
read ip
echo "You entered: $ip"

curl -u elastic:changeme -XPUT 'http://'$ip':9200/odp_hackathon' -d '
{
	"mappings": {
		"awards": {
			"properties": {
				"geo_location": {
					"type": "geo_point"
				}
			}
		},
		"transactions": {
			"properties": {
				"geo_location": {
					"type": "geo_point"
				}
			}
		}
	}
}'

printf "\n"
