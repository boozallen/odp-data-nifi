import json
import java.io
from org.apache.commons.io import IOUtils
from java.nio.charset import StandardCharsets
from org.apache.nifi.processor.io import StreamCallback
class ModJSON(StreamCallback):
    def __init__(self, flowfile):
        self.flowfile = flowfile
    def process(self, inputStream, outputStream):
        text = IOUtils.toString(inputStream, StandardCharsets.UTF_8)
        elasticjson = json.loads(text)
        geojson_text = self.flowfile#.getAttribute('geojson')
        geojson = json.loads(geojson_text)
        if (len(geojson['interpretations']) > 0):
            latitude = str(geojson['interpretations'][0]['feature']['geometry']['center']['lat'])
            longitude = str(geojson['interpretations'][0]['feature']['geometry']['center']['lng'])
            elasticjson['geo_location'] = latitude + ',' + longitude
        outputStream.write(bytearray(json.dumps(elasticjson, indent=4).encode('utf-8')))

flowFile = session.get()
if (flowFile != None):
    flowFile = session.write(flowFile, ModJSON(flowFile.getAttribute('geojson')))
    session.transfer(flowFile, REL_SUCCESS)
    session.commit()
