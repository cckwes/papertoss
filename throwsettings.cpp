#include "throwsettings.h"

ThrowSettings::ThrowSettings(QObject *parent) :
    QObject(parent)
{
}

void ThrowSettings::setHighScore(int level, int score)
{
    QSettings settings("Linux4us", "ThrowIn");

    switch (level)
    {
    case 0:
        //easy
        settings.setValue("easyhighscore", score);
        break;

    case 1:
        //intermediate
        settings.setValue("mediumhighscore", score);
        break;

    case 2:
        //difficult
        settings.setValue("hardhighscore", score);
        break;

    default:
        //default as easy
        settings.setValue("easyhighscore", score);
        break;
    }
}

int ThrowSettings::getHighScore(int level)
{
    QSettings settings("Linux4us", "ThrowIn");

    int hScore;

    switch (level)
    {
    case 0:
        //easy
        hScore = settings.value("easyhighscore").toInt();
        break;

    case 1:
        //intermediate
        hScore = settings.value("mediumhighscore").toInt();
        break;

    case 2:
        //difficult
        hScore = settings.value("hardhighscore").toInt();
        break;

    default:
        //default as easy
        hScore = settings.value("easyhighscore").toInt();
        break;
    }

    return hScore;
}
