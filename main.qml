import QtQuick 2.10
import QtQuick.Window 2.10
import QtMultimedia 5.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property var availableCameras: QtMultimedia.availableCameras
    property var currentCamera: 0

    ColumnLayout {
        anchors.fill: parent
        VideoOutput{
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: Camera { id: camera
                             imageCapture {
                             onImageCaptured: {
                             photoPreview.source = preview
                             }
                    }
            }
            autoOrientation: true
            MouseArea {
                anchors.fill: parent
                onClicked: camera.imageCapture.capture()
            }
        }

        RowLayout {
            spacing: 20
            width: parent.width
            Label {
                Layout.fillWidth: true
                text: camera.displayName
            }
            Label {
                id: labelFoto
                Layout.fillWidth: true
            }
            Button {
                text: "Change Camera"
                onClicked: {
                    currentCamera++
                    if(currentCamera >= availableCameras.length)
                        currentCamera = 0
                    camera.deviceId = availableCameras[currentCamera].deviceId
                }
            }
        }

    }
}
