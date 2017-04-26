import json
import java.io
from org.apache.commons.io import IOUtils
from java.nio.charset import StandardCharsets
from org.apache.nifi.processor.io import StreamCallback
class ModJSON(StreamCallback):
  def __init__(self):
        pass
  def process(self, inputStream, outputStream):
    text = IOUtils.toString(inputStream, StandardCharsets.UTF_8)
    corenlp = json.loads(text)
    locations = []
    for sentence in corenlp['sentences']:
        for token in sentence['tokens']:
            if token['ner'] == 'LOCATION':
                locations.append(token['word'])
    outputStream.write(bytearray(json.dumps(locations, indent=4).encode('utf-8')))
flowFile = session.get()
if (flowFile != None):
  flowFile = session.write(flowFile, ModJSON())
  flowFile = session.putAttribute(flowFile, "filename", flowFile.getAttribute('filename').split('.')[0]+'_translated.json')
session.transfer(flowFile, REL_SUCCESS)
session.commit()
