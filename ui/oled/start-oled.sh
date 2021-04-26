#!/bin/bash

# Parameter
FILENAME='oled.py'
START="python3 $FILENAME"
SCREEN='oled'
OLEDPATH='/home/pi/oled'

#Starten
start() {
    if ps ax | grep -v grep | grep -v -i SCREEN | grep $FILENAME > /dev/null
    then
        echo 'UI is running already'
    else
        echo 'UI started!'

        cd $OLEDPATH && screen -dmS $SCREEN $START
        sleep 4

        if ps ax | grep -v grep | grep -v -i SCREEN | grep $FILENAME > /dev/null
        then
            echo 'UI is up and running!'
        else
            echo 'UI cannot be started'
        fi
    fi
}

# Stoppen
stop() {
    if ps ax | grep -v grep | grep -v -i SCREEN | grep $FILENAME > /dev/null
    then
        echo 'UI has been switched off'
        screen -S oled -X stuff ^C
        sleep 1

        if ps ax | grep -v grep | grep -v -i SCREEN | grep $FILENAME > /dev/null
        then
            echo 'UI couldn't be switched off
        else
            echo 'UI is switched off'
        fi
    else
        echo 'UI is already off'
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    status)
        if ps ax | grep -v grep | grep -v -i SCREEN | grep $FILENAME > /dev/null
        then
            echo "UI is running"
        else
            echo "UI is not running"
        fi
        ;;
    *)
        echo "Usage: ui.sh {start|stop|restart|status}"
        exit 1
        ;;
esac
exit 0
