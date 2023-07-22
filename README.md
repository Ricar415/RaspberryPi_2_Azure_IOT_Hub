# RaspberryPi_2_Azure_IOT_Hub
RPi package for reading data from radio MQTT IOT device and send it to Azure IOT Hub

## Clean installation steps:

1- Raspberry Pi Configuration:<br><br>
	- Installing Raspbian<br>
	- Changing RPi password<br>
	- Open SSH/VNC connection to Raspberry<br><br><br>
2- Azure configuration<br><br>
	In Azure IOT Hub, create a device and copy the primary string connection into the file mqtt2azure.py in the CONNECTION_STRING.<br><br><br>
3- Remove \r from install file:<br><br>
```bash
sed -i 's/\r//' install.sh
```
<br><br>
4- Package installation:<br><br>
```bash
chmod +x install.sh
./install.sh
```
<br><br>
### Content:<br><br>

	- Python 3<br>
	- PIP<br>
	- RTL_433 	(https://www.sensorsiot.org/install-rtl_433-for-a-sdr-rtl-dongle-on-a-raspberry-pi/)<br>
	- MQTT BROKER (https://www.emqx.com/en/blog/how-to-use-mqtt-in-python)<br>
	- AZURE IOT 	(https://dev.to/nihalbaig0/stream-data-to-azure-iot-hub-from-raspberry-pi-1ed3)<br>
