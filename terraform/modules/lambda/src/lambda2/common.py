import os
import sys
import json
import boto3
import logging

from botocore.exceptions import ClientError
from boto3 import client as boto3_client

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

s3 = boto3.resource("s3")
s3_client = boto3.client("s3")


# Create a function to fetch secrets from the AWS secret manager
# This function uses parameters passed into the lambda function as environment variables
def fetch_secret(secret_name):
    session = boto3.session.Session()
    # Create a variable to hold the region name for the os environment
    region_name = os.environ["AWS_REGION"]
    # Create a client to use the AWS secret manager
    client = session.client(service_name="secretsmanager", region_name=region_name)
    # Decrypt secret from the AWS Key Management Service (KMS)
    get_secret_value_response = client.get_secret_value(SecretId=secret_name)
    # Extract the secret string data from the decrypted secret, if it exists.
    secret_string = get_secret_value_response["SecretString"]
    secret = json.loads(secret_string)

    return secret


# Upload the file to S3 bucket
def upload_file(file_name, bucket, object_name=None):
    """Upload a file to an S3 bucket
    :param file_name: File to upload
    :param bucket: Bucket to upload to
    :param object_name: S3 object name. If not specified then file_name is used
    :return: True if file was uploaded, else False
    """

    # If S3 object_name was not specified, use file_name
    if object_name is None:
        object_name = os.path.basename(file_name)

    # Upload the file
    try:
        s3_client.upload_file(file_name, bucket, object_name)
    except ClientError as e:
        logging.error(e)
        return False
    return True


# Remove file from the temporary storage
def remove_file(file_path):
    if os.path.isfile(file_path):
        try:
            print(file_path)
            os.remove(file_path)
        except Exception as e:
            print(e)
