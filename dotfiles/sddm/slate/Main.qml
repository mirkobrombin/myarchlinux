/***********************************************************************/


import QtQuick 2.0

import SddmComponents 2.0


Rectangle {
    width: 640
    height: 480

    TextConstants { id: textConstants }

    Connections {
        target: sddm

        onLoginSucceeded: {
            errorMessage.color = "#039be5"
            errorMessage.text = textConstants.loginSucceeded
        }

        onLoginFailed: {
            errorMessage.color = "#e53935"
            errorMessage.text = textConstants.loginFailed
        }
    }

    Repeater {
        model: screenModel
        Background {
            x: geometry.x; y: geometry.y; width: geometry.width; height:geometry.height
            source: config.background
            fillMode: Image.Tile
            onStatusChanged: {
                if (status == Image.Error && source != config.defaultBackground) {
                    source = config.defaultBackground
                }
            }
        }
    }

    Rectangle {
        property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x; y: geometry.y; width: geometry.width; height: geometry.height
        color: "#191919"
        transformOrigin: Item.Top

        Rectangle {
            id: archlinux
            anchors.centerIn: parent
            height: parent.height / 7 * 2.5
            width: height * 1
            color: "#1F1F1F"

            Column {
                id: mainColumn
                anchors.centerIn: parent
                width: parent.width * 0.9
                spacing: archlinux.height / 32.5

                Row {
                    width: parent.width
                    Text {
                        id: lblName
                        width: parent.width; height: archlinux.height / 12
                        color: "white"
                        text: textConstants.userName
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                        font.pixelSize: 12
                    }
                }

                Row {
                    width: parent.width
                    spacing: Math.round(archlinux.height / 70)

                    TextBox {
                        id: name
                        width: parent.width; height: archlinux.height / 12
                        text: userModel.lastUser
                        font.pixelSize: 12
                        color: "#252525"
                        textColor: "#FFFFFF"

                        KeyNavigation.backtab: rebootButton; KeyNavigation.tab: password

                        Keys.onPressed: {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, session.index)
                                event.accepted = true
                            }
                        }
                    }
                }

                Row {
                    width: parent.width
                    spacing : Math.round(archlinux.height / 70)
                    Text {
                        id: lblPassword
                        width: parent.width; height: archlinux.height / 12
                        color: "white"
                        text: textConstants.password
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                        font.pixelSize: 12
                    }
                }

                Row {
                    width: parent.width
                    spacing : Math.round(archlinux.height / 70)

                    PasswordBox {
                        id: password
                        width: parent.width; height: archlinux.height / 12
                        font.pixelSize: 12
                        tooltipBG: "lightgrey"
                        focus: true
                        color: "#252525"
                        textColor: "#FFFFFF"
                        Timer {
                            interval: 200
                            running: true
                            onTriggered: password.forceActiveFocus()
                        }

                        KeyNavigation.backtab: name; KeyNavigation.tab: session

                        Keys.onPressed: {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, session.index)
                                event.accepted = true
                            }
                        }
                    }
                }

                Row {
                    spacing: Math.round(archlinux.height / 70)
                    width: parent.width / 2
                    z: 100

                    Row {
                        z: 100
                        width: parent.width * 1.2
                        spacing : Math.round(archlinux.height / 70)
                        anchors.bottom: parent.bottom

                        ComboBox {
                            id: session
                            width: parent.width * 1.68; height: archlinux.height / 12
                            font.pixelSize: 12

                            color: "#252525"
                            textColor: "#FFFFFF"
                            arrowIcon: "angle-down.png"

                            model: sessionModel
                            index: sessionModel.lastIndex

                            KeyNavigation.backtab: password; KeyNavigation.tab: layoutBox
                        }
                    }
                }

                Column {
                    width: parent.width
                    Text {
                        id: errorMessage
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: textConstants.prompt
                        color: "white"
                        font.pixelSize: 12
                    }
                }

                Row {
                    spacing: Math.round(archlinux.height / 70)
                    anchors.horizontalCenter: parent.horizontalCenter
                    property int btnWidth: Math.max(loginButton.implicitWidth,
                                                    shutdownButton.implicitWidth,
                                                    rebootButton.implicitWidth, archlinux.height - 30)
                    Button {
                        id: loginButton
                        text: textConstants.login
                        width: parent.btnWidth
                        height: archlinux.height / 12
                        font.pixelSize: 12
                        color: "#252525"
                        textColor: "#FFFFFF"

                        onClicked: sddm.login(name.text, password.text, session.index)

                        KeyNavigation.backtab: layoutBox; KeyNavigation.tab: shutdownButton
                    }
                }

                Row {
                    spacing: Math.round(archlinux.height / 70)
                    anchors.horizontalCenter: parent.horizontalCenter
                    property int btnWidth: Math.max(loginButton.implicitWidth,
                                                    shutdownButton.implicitWidth,
                                                    rebootButton.implicitWidth, archlinux.height - 30)

                    Button {
                        id: shutdownButton
                        text: textConstants.shutdown
                        width: parent.btnWidth
                        height: archlinux.height / 12
                        font.pixelSize: 12
                        color: "#252525"
                        textColor: "#FFFFFF"

                        onClicked: sddm.powerOff()

                        KeyNavigation.backtab: loginButton; KeyNavigation.tab: rebootButton
                    }
                }

                Row {
                    spacing: Math.round(archlinux.height / 70)
                    anchors.horizontalCenter: parent.horizontalCenter
                    property int btnWidth: Math.max(loginButton.implicitWidth,
                                                    shutdownButton.implicitWidth,
                                                    rebootButton.implicitWidth, archlinux.height - 30)

                    Button {
                        id: rebootButton
                        text: textConstants.reboot
                        width: parent.btnWidth
                        height: archlinux.height / 12
                        font.pixelSize: 12
                        color: "#252525"
                        textColor: "#FFFFFF"

                        onClicked: sddm.reboot()

                        KeyNavigation.backtab: shutdownButton; KeyNavigation.tab: name
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        if (name.text == "")
            name.focus = true
        else
            password.focus = true
    }
}
