import QtQuick 1.1
import "engine.js" as Engine

Item {
    id: appWindow
    width: 480
    height: 854
    //anchors.fill: parent

    property int initialMouseX;
    property int initialMouseY;
    property int finalMouseX;
    property int finalMouseY;
    property bool flipping: false;
    property bool throwing: false;
    property int oriX: (appWindow.width - paper.width) / 2;
    property int oriY: appWindow.height - paper.height;
    property real wind;
    property real windspeed: Math.abs(appWindow.wind);
    property int count: 0;
    property int score: 0;
    property bool dropping: false;
    property int rebound: 0;        // 0 for not rebound. 1 for left, 2 for right

    Component.onCompleted: {
        appWindow.wind = (Math.round(Math.random()*200) / 20 - 5).toFixed(2);
    }

    Rectangle {
        id: paperBin
        width: 60
        height: 150
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        y: appWindow.height - paperBin.height - 350
        z: (appWindow.dropping) ? 4 : 2
    }

    Rectangle {
        id: paper
        width: 50
        height: 50
        color: "blue"
        x: appWindow.oriX
        y: appWindow.oriY
        z: 3
    }

    MouseArea {
        id: flipArea
        anchors.fill: parent

        onPressed: {
            initialMouseX = mouse.x;
            initialMouseY = mouse.y;
        appWindow.flipping = true;
//            if (initialMouseX >= 215 && initialMouseX <= 265 && initialMouseY >= 804 && initialMouseY <= 854 ) {
                //the press is inside the paper area, register the press
//                console.log("Initial mouse x: " + mouse.x);
//                console.log("Initial mouse y: " + mouse.y);
//                appWindow.flipping = true;
//            }
        }

        onReleased: {
        finalMouseX = mouse.x;
            finalMouseY = mouse.y;
            if (appWindow.flipping) {
                //it's flipping!
                //console.log("Final mouse x: " + mouse.x);
                //console.log("Final mouse y: " + mouse.y);
                appWindow.flipping = false;
                appWindow.throwing = true;
                frameTimer.start();
            }
//            if (mouse.X != initialMouseX && mouse.y != initialMouseY) {
                //it's not a clicked
//                finalMouseX = mouse.x;
//                finalMouseY = mouse.y;
//                if (appWindow.flipping) {
                    //it's flipping!
//                    console.log("Final mouse x: " + mouse.x);
//                    console.log("Final mouse y: " + mouse.y);
//                    appWindow.flipping = false;
//                    appWindow.throwing = true;
//                    frameTimer.start();
//                }
//            } else {
//                console.log("Clicked detected!");
//            }
        }

        //onDoubleClicked: {
        //    appWindow.throwing = false;
        //    frameTimer.stop();
        //    paper.x = appWindow.oriX;
        //    paper.y = appWindow.oriY;
        //    appWindow.wind = (Math.round(Math.random()*200) / 20 - 5).toFixed(2);
        //}
    }

    Text {
        id: windSpeedText
        text: appWindow.windspeed
        anchors.horizontalCenter: parent.horizontalCenter
        y: 20
    }

    Image {
        id: windIndicator
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: windSpeedText.bottom
        anchors.topMargin: 20
        source: (appWindow.wind > 0) ? "right.png" : "left.png"
    }

    Text {
        id: scoreText
        text: appWindow.score
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: windIndicator.bottom
        anchors.topMargin: 50
    }

    Rectangle {
        id: quitArea
        color: "red"
        anchors.right: parent.right
        anchors.top: parent.top
    width: 80
    height: 80

        MouseArea {
        anchors.fill: parent
        onClicked: Qt.quit()
        }
    }

    Timer {
        id: frameTimer
        interval: 10
        repeat: true
        onTriggered: {
            Engine.startThrow();
        }
    }
}
