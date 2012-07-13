#ifndef THROWSETTINGS_H
#define THROWSETTINGS_H

#include <QObject>
#include <QSettings>

class ThrowSettings : public QObject
{
    Q_OBJECT
public:
    explicit ThrowSettings(QObject *parent = 0);
    Q_INVOKABLE int getHighScore(int level);
    
signals:
    
public slots:
    void setHighScore(int level, int score);

};

#endif // THROWSETTINGS_H
