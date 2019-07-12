/*
 * This file was generated by qdbusxml2cpp version 0.8
 * Command line was: qdbusxml2cpp -p dbus_interface.h: org.cn180s.dbus.xml
 *
 * qdbusxml2cpp is Copyright (C) 2016 The Qt Company Ltd.
 *
 * This is an auto-generated file.
 * Do not edit! All changes made to it will be lost.
 */

#ifndef DBUS_INTERFACE_H
#define DBUS_INTERFACE_H

#include <QtCore/QObject>
#include <QtCore/QByteArray>
#include <QtCore/QList>
#include <QtCore/QMap>
#include <QtCore/QString>
#include <QtCore/QStringList>
#include <QtCore/QVariant>
#include <QtDBus/QtDBus>

/*
 * Proxy class for interface org.cn180s.dbus
 */
class OrgCn180sDbusInterface: public QDBusAbstractInterface
{
    Q_OBJECT
public:
    static inline const char *staticInterfaceName()
    { return "org.cn180s.dbus"; }

public:
    OrgCn180sDbusInterface(const QString &service, const QString &path, const QDBusConnection &connection, QObject *parent = 0);

    ~OrgCn180sDbusInterface();

public Q_SLOTS: // METHODS
Q_SIGNALS: // SIGNALS
    void control(int cmd, const QString &data);
    void reply(int cmd, const QString &data);
    void replyList(int cmd, const QStringList &data);
};

namespace org {
  namespace cn180s {
    typedef ::OrgCn180sDbusInterface dbus;
  }
}
#endif
