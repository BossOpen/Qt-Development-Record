#!/bin/sh
echo "dbus_interface.h dbus_adaptor.h"
rm -f dbus_interface.h
rm -f dbus_adaptor.h
echo "create dbus_interface.h dbus_adaptor.h"
/opt/Qt5.6.1/5.6/gcc_64/bin/qdbusxml2cpp -p dbus_interface.h: org.cn180s.dbus.xml
/opt/Qt5.6.1/5.6/gcc_64/bin/qdbusxml2cpp -a dbus_adaptor.h: org.cn180s.dbus.xml
