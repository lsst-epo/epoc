import argparse
import logging
import os

import jenkinsapi


logging.basicConfig(level=logging.DEBUG)

parser = argparse.ArgumentParser(description='Jenkins job sync')
parser.add_argument('operation', choices=['get', 'put'])
parser.add_argument('url', help='Jenkins server to contact')
parser.add_argument('user', help='User for Jenkins auth')
parser.add_argument('token', help='Token for Jenkins auth')

args = parser.parse_args()

server = jenkinsapi.jenkins.Jenkins(args.url, username=args.user, password=args.token)

if args.operation == 'put':
    for job_name in os.listdir('jobs'):
        with open('jobs/%s' % job_name, 'r') as f:
            job_xml = f.read()

        logging.info('Creating job: %s' % job_name) 
        server.create_job(jobname=job_name, xml=job_xml)
else:
    for job_name in server.keys():
        job_xml = server[job_name].get_config()
        with open('jobs/%s' % job_name, 'w') as f:
           f.write(job_xml)

        logging.info('Fetched job: %s' % job_name)
