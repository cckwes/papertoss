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
    property real paperDir: 0;

    Component.onCompleted: {
        appWindow.wind = (Math.round(Math.random()*200) / 20 - 5).toFixed(2);
    }

//    Image {
//        anchors.fill: parent
//        source: "landscape1.png"
//    }

    Image {
        id: paperBin
        width: 120
        height: 150
        smooth: true
        //fillMode: Image.PreserveAspectFit
        source: "images/bin.png"
        anchors.horizontalCenter: parent.horizontalCenter
        y: appWindow.height - paperBin.height - 350
        z: (appWindow.dropping) ? 4 : 2
    }

    Image {
        id: paper
        width: 50
        height: 50
        smooth: true
        source: "images/paper.png"
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

    Column {
        spacing: 20
        width: parent.width
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20

        Row {
            width: parent.width / 2
            spacing: 20

            Text {
                id: windSpeedLabel
                text: "Wind: "
                font.weight: Font.Bold
                font.pixelSize: 25
            }

            Text {
                id: windSpeedText
                text: appWindow.windspeed + " m/s"
                font.pixelSize: 25
            }
        }

//        Row {
//            width: parent.width / 2
//            spacing: 20

//            Text {
//                id: windDirection
//                text: "Direction: "
//                font.weight: Font.Bold
//                font.pixelSize: 25
//            }

//            Image {
//                id: windIndicator
//                height: 50
//                smooth: true
//                fillMode: Image.PreserveAspectFit
//                source: (appWindow.wind > 0) ? "right.png" : "left.png"
//            }
//        }

        Row {
            width: parent.width / 2
            spacing: 20

            Text {
                id: winLabel
                text: "Win Streak: "
                font.weight: Font.Bold
                font.pixelSize: 25
            }

            Text {
                id: scoreText
                text: appWindow.score
                font.pixelSize: 25
            }
        }
    }

    Image {
        id: quitArea
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
        width: 80
        source: "images/quit.png"
        fillMode: Image.PreserveAspectFit

        MouseArea {
            anchors.fill: parent
            onClicked: Qt.quit()
        }
    }

    Image {
        id: toRightFan
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 150
        height: 150
        fillMode: Image.PreserveAspectFit
        source: "images/fan_right.png"
        smooth: true
        visible: (appWindow.wind > 0) ? true : false
    }

    Image {
        id: toLeftFan
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 150
        height: 150
        fillMode: Image.PreserveAspectFit
        source: "images/fan_left.png"
        smooth: true
        visible: (appWindow.wind < 0) ? true : false
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
