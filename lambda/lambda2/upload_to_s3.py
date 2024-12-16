import logging
import os
from boto3 import client as boto3_client
from common import *
from message_wrapper import *

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
lambda_client = boto3_client("lambda", region_name="ap-southeast-2")


def lambda_handler(event, context):
    # logger.debug("event %s", json.dumps(event))

    environment = os.environ["ENV"]
    my_secret_name = os.environ["PG_SECRET_NAME"]
    my_credentials = fetch_secret(my_secret_name)

    logger.info(f"my_secret_name: {my_secret_name}")

    try:
        # ------------------------------------------------------------------------------
        #   Code to write message to S3
        # ------------------------------------------------------------------------------

        bucket_name = str(os.environ["BUCKET_NAME"])
        try:
            s3_response = upload_file(bucket_name, str({"key": "value"}))
            logger.info(f"s3_response: {s3_response}")
        except Exception as e:
            raise Exception("Could not upload file! %s" % e)

    except Exception as e:
        logger.error("Call to upload_to_s3 lambda has failed")
        logger.error(e)
        sys.exit(1)

    finally:
        # do something
        logger.info("the end")
