/****************************************************************
** DbusService
** DBus IPC接口
**
**
** dbusservice.h
**
** 周涛 Zhou Tao   2017-08-10T17:23:42
**
** 深圳市宝凌电子股份有限公司
**
**
****************************************************************/
#ifndef DBUSSERVICE_H
#define DBUSSERVICE_H

#include <QObject>

class DbusService : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(DbusService)
#ifdef g_dbusService
#undef g_dbusService
#endif
#define g_dbusService (DbusService::GetInstance())
public:
    static DbusService *GetInstance()
    {
         if(m_pInstance == NULL){
            m_pInstance = new DbusService();
         }
         return m_pInstance;
    }

    void sendMessage(int cmd, QString data);//发送状态
    void sendMessageList(int cmd, QStringList listString);//发送字符串列表

signals:
    void sign_Control(const int &cmd, const QString &data);

public slots:
    //void controlSlot(const int &cmd, const QString &data);

private:
    DbusService(QObject *parent = 0);
    static DbusService *m_pInstance;
};

#endif // DBUSSERVICE_H
