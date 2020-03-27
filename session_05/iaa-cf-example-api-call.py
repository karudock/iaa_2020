
import json
import requests


payload = {'name': 'Test user'}


r = requests.post('https://us-central1-zproject201807.cloudfunctions.net/iaa-cf-example',
    headers={'content-type': 'application/json'},
    data=json.dumps(payload))


if r.status_code==200:
    print('{}'.format(r.content))
else:
    print('[ ERROR ] Status Code: {}. {}'.format(r.status_code, r.content))



#ZEND
