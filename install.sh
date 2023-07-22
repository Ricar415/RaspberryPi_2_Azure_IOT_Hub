#!/bin/sh
export IOT_FILE_PATH=$(pwd)

# Update
sudo apt update -y
sudo apt upgrade -y

# Install Python & PIP
sudo apt install -y python3
sudo apt install -y python3-pip

# Install MQTT Broker
sudo pip3 install --no-input paho-mqtt

# Install Azure IOT Python module
sudo pip3 install --no-input azure-iot-device
sudo pip3 install --no-input azure-iot-hub

# Install RTL_SDR Support 
cd ~
sudo apt-get install -y git git-core cmake libusb-1.0-0-dev build-essential
git clone git://git.osmocom.org/rtl-sdr.git
cd rtl-sdr/ && mkdir -p build && cd build/
cmake ../ -DINSTALL_UDEV_RULES=ON
sudo make
sudo make install
sudo ldconfig
cd ~
sudo cp ./rtl-sdr/rtl-sdr.rules /etc/udev/rules.d/
# + Config
sudo cp $IOT_FILE_PATH/no-rtl.conf /etc/modprobe.d/no-rtl.con

# Install RTL_433
sudo apt-get install -y libtool libusb-1.0.0-dev librtlsdr-dev rtl-sdr doxygen
git clone https://github.com/merbanan/rtl_433.git
cd rtl_433/ && mkdir -p build && cd build && cmake ../ && make
sudo make install

# Install SYSTEMD
sudo apt-get install -y systemd

# Config services
sudo cp $IOT_FILE_PATH/rtl_433.service /etc/systemd/system/rtl_433.service
sudo mkdir -p /etc/rtl_433
sudo cp $IOT_FILE_PATH/service.conf /etc/rtl_433/service.conf

sudo cp $IOT_FILE_PATH/mqtt2azure.py /home/pi/mqtt2azure.py 
sudo cp $IOT_FILE_PATH/mqtt2azure.service /etc/systemd/system/mqtt2azure.service

sudo systemctl daemon-reload

sudo systemctl enable rtl_433.service
sudo systemctl enable mqtt2azure.service

# Init services
sudo systemctl start rtl_433.service
sudo systemctl start mqtt2azure.service

#sudo reboot

exit 0