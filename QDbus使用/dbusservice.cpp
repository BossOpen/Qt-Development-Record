/****************************************************************
** DbusService
** DBus IPC接口
**
**
** dbusservice.cpp
**
** 周涛 Zhou Tao   2017-08-10T17:23:42
**
** 深圳市宝凌电子股份有限公司
**
**
****************************************************************/
#include "dbusservice.h"

#include "dbus_adaptor.h"
#include "dbus_interface.h"

#include <QDebug>

DbusService* DbusService::m_pInstance = NULL;

DbusService::DbusService(QObject *parent) : QObject(parent)
{
    if (!QDBusConnection::sessionBus().isConnected()) {
        qWarning("Cannot connect to the D-Bus session bus.\n"
                 "Please check your system settings and try again.\n");
    }

    // add D-Bus interface and connect to D-Bus
    new DbusAdaptor(this);
    QDBusConnection::sessionBus().registerObject("/", this);

    org::cn180s::dbus *iface;
    iface = new org::cn180s::dbus(QString(), QString(), QDBusConnection::sessionBus(), this);
    //connect(iface, SIGNAL(control(int,QString)), this, SLOT(controlSlot(int,QString)));
    connect(iface, SIGNAL(control(int,QString)), this, SIGNAL(sign_Control(int,QString)));
}

//发送状态
void DbusService::sendMessage(int cmd, QString data)
{
    QDBusMessage msg = QDBusMessage::createSignal("/", "org.cn180s.dbus", "reply");
    msg << cmd << data;
    QDBusConnection::sessionBus().send(msg);
}

//发送字符串列表
void DbusService::sendMessageList(int cmd,QStringList listString)
{
    QDBusMessage msg = QDBusMessage::createSignal("/", "org.cn180s.dbus", "replyList");
    msg << cmd << listString;
    QDBusConnection::sessionBus().send(msg);
}

/*void DbusService::controlSlot(const int &cmd, const QString &data)
{
    qDebug()<<"controlSlot "<<cmd<<data;
}*/
