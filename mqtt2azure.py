import time
import random

from paho.mqtt import client as mqtt_client
from azure.iot.device import IoTHubDeviceClient, Message

broker = 'localhost'
port = 1883
topic = "rtl_433"
# Generate a Client ID with the subscribe prefix.
client_id = f'subscribe-{random.randint(0, 100)}'

CONNECTION_STRING = "XXXX"

# Define the JSON message to send to IoT Hub.
MSG_TXT = '{{"Received": "{first}","Topic": "{second}"}}'

def iothub_client_init():
    # Create an IoT Hub client
    client = IoTHubDeviceClient.create_from_connection_string(CONNECTION_STRING)
    return client

def connect_mqtt() -> mqtt_client:
    def on_connect(client, userdata, flags, rc):
        if rc == 0:
            print("Connected to MQTT Broker!")
        else:
            print("Failed to connect, return code %d\n", rc)

    client = mqtt_client.Client(client_id)
    # client.username_pw_set(username, password)
    client.on_connect = on_connect
    client.connect(broker, port)
    return client

def subscribe(client: mqtt_client):
	azure_client = iothub_client_init()
	print ( "IoT Hub device sending periodic messages, press Ctrl-C to exit" )
    def on_message(client, userdata, msg):
		msg_txt_formatted = MSG_TXT.format(first=msg.payload.decode(, second=msg.topic)
		message = Message(msg_txt_formatted, content_encoding='utf-8', content_type='application/json')
		print( "Sending message: {}".format(message) )
		azure_client.send_message(message)
		print ( "Message successfully sent" )
		time.sleep(1)
    client.subscribe(topic)
    client.on_message = on_message


def run():
    client = connect_mqtt()
    subscribe(client)
    client.loop_forever()


if __name__ == '__main__':
    print ( "IoT Hub Quickstart #1 - Simulated device" )
    print ( "Press Ctrl-C to exit" )
    run()