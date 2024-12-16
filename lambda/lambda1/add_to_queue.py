import logging
import os
from boto3 import client as boto3_client
from common import fetch_secret
from message_wrapper import get_queue, send_message
import sys

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
lambda_client = boto3_client("lambda", region_name="us-east-1")


def lambda_handler(event, context):
    # logger.debug("event %s", json.dumps(event))

    # environment = os.environ["ENV"]
    my_secret_name = os.environ["PG_SECRET_NAME"]
    fetch_secret(my_secret_name)

    logger.info(f"my_secret_name: {my_secret_name}")

    try:
        # ------------------------------------------------------------------------------
        #   Code to write message to SQS
        # ------------------------------------------------------------------------------

        queue_name = str(os.environ["QUEUE_NAME"])
        queue = get_queue(queue_name)

        try:
            sqs_response = send_message(queue, str({"key": "value"}))
            logger.info(f"sqs_response: {sqs_response}")
        except Exception as e:
            raise Exception("Could not add file! %s" % e)

    except Exception as e:
        logger.error("Call to add_to_queue lambda has failed")
        logger.error(e)
        sys.exit(1)

    finally:
        # do something
        logger.info("the end")
