#!//opt/boxen/homebrew/bin/python

import boto.sns, os, json, sys

f = open('/tmp/hezuo-builder/deploy.log', 'r')

REGION  = os.environ['AWS_REGION']
TOPIC   = os.environ['SNS_TOPIC_ARN']
SUBJECT = 'Hezuo Build in ' + os.environ['ENV_TYPE'] + ' completed.'


MESSAGE = f.read()

f.close()

conn = boto.sns.connect_to_region( REGION )
pub = conn.publish( topic = TOPIC, message = MESSAGE, subject = SUBJECT )

sys.exit(0)
