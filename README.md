# Home-Assistant Config 
This is my [Home Assistant](https://home-assistant.io/) configuration running on Raspberry Pi 3, installed using [Hassbian](https://home-assistant.io/getting-started/hassbian-installation/)

**Software running:**
- Home Assistant
- InfluxDB: for long term data analysis
- Grafana: to visualise InfluxDB data into pretty charts
- MySensors Gateway: catching temperature from each room

*please see `install.md` how to install them*


**Devices I have :**
- [MySensors temperature nodes](../../../MySLipo)
- [LazyGardener](../../../LazyGardener): My own irrigation controller
- LG smart TV
- [RFLink](http://www.nemcon.nl/blog2/) to read 433mHz things, connected over GPIO serial port
- [HomeEasy](http://service.smartwares.eu/) (433mHz) dimmers, sockets, wall buttons
- IR receiver & LED
- [Kodi](https://kodi.tv/) running on old laptop 
- Xiaomi Mi Flora: controls plants soil moisture
- PIR sensor attached to Raspberry Pi
- [OctoPrint](http://octoprint.org/)
- Sonoff with [custom FW](../../../MQTT-relay)
- [ESP8266 based TFT display](../../../MQTT-weather-display)

**Automations:**
- reads IR remote from Pioneer A/V and transmitting codes for TV - that's one remote to rule them all!
- if A/V is in DVD mode, switch TV input to HDMI and use IR remote's joystick to control Kodi
- watch weather and room temperature to send it over MQTT to ESP8266 display
- turn on the lamp when move is detected during night: midnight until 30 minutes after sunset
- watch disk usage, if nearly full send me notification
- when 3D print ends send me notification - only on request
- turn on each LazyGardener's valves one by one for time selected from input_slider
- turn on selected LazyGardener's valve with auto turn off timeout feature

### Todo List
- scenes: dim lights when playing movie on Kodi
- dim ESP8266 display over night and turn it on in case somebody turns on light during night
- watch batteries and send notification when low

