import QtQuick 2.7
import QtQuick.Window 2.2

Window {
    visible: true
    width: 800
    height: 480
    color: "steelblue"

    Rectangle{
        id:backGround
        x:0;y:55
        width: 512
        height: 50
        color: "blue"
    }

    Calendar{}
}
