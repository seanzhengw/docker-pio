FROM python:latest

# install platformio
RUN pip install -U platformio 

# preinstall platform atmelavr, ststm32 and libs.
RUN mkdir /tmp/pio_fake_project \
    && pio init --project-dir="/tmp/pio_fake_project" --board=uno --silent \
    && pio init --project-dir="/tmp/pio_fake_project" --board=nucleo_f103rb --silent \
    && pio lib --global install "STM32duino FreeRTOS" ArduinoJson Ethernet \
    && echo "#include <Arduino.h>" >> /tmp/pio_fake_project/src/main.cpp \
    && echo "void setup() {}" >> /tmp/pio_fake_project/src/main.cpp \
    && echo "void loop() {}" >> /tmp/pio_fake_project/src/main.cpp \
    && pio run --project-dir="/tmp/pio_fake_project" --silent

# Clean up
RUN rm -r /tmp/pio_fake_project

CMD ["/bin/sh"]


