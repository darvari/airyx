/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.5
import QtQuick.Window 2.2
import org.kde.plasma.core 2.0 as PlasmaCore

Image {
    id: root
    source: "images/marmoset.png"

    property int stage

    onStageChanged: {
        if (stage == 2) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: PlasmaCore.Units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }


	Text {
	    id: osname
	    color: "#eff0f1"
	    text: "ravynOS"
	    font.pointSize: 72 
	    font { family: "Nimbus Sans"; weight: Font.Regular }
	    anchors.verticalCenter: parent.verticalCenter
	    x: (PlasmaCore.Units.gridUnit * 2)
	}

	Text {
	    id: verstext
	    color: "#eff0f1"
	    text: "Pygmy Marmoset v0.4.0pre3"
	    font.pointSize: 20
	    font { family: "Nimbus Sans"; weight: Font.Regular }
	    x: (PlasmaCore.Units.gridUnit * 2)
	    y: (osname.y + osname.height)
	}

        // TODO: port to PlasmaComponents3.BusyIndicator
        Image {
            id: busyIndicator
            anchors.centerIn: parent
            source: "images/busywidget.svgz"
            sourceSize.height: PlasmaCore.Units.gridUnit * 3
            sourceSize.width: PlasmaCore.Units.gridUnit * 3
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                // Not using a standard duration value because we don't want the
                // animation to spin faster or slower based on the user's animation
                // scaling preferences; it doesn't make sense in this context
                duration: 2000
                loops: Animation.Infinite
                // Don't want it to animate at all if the user has disabled animations
                running: PlasmaCore.Units.longDuration > 1
            }
        }
        Row {
            spacing: PlasmaCore.Units.smallSpacing*2
            anchors {
                bottom: parent.bottom
                right: parent.right
                margins: PlasmaCore.Units.gridUnit
            }
            //Text {
            //    color: "#eff0f1"
                // Work around Qt bug where NativeRendering breaks for non-integer scale factors
            //    // https://bugreports.qt.io/browse/QTBUG-67007
            //    renderType: Screen.devicePixelRatio % 1 !== 0 ? Text.QtRendering : Text.NativeRendering
            //    anchors.verticalCenter: parent.verticalCenter
            //    text: i18ndc("plasma_lookandfeel_org.kde.lookandfeel", "This is the first text the user sees while starting in the splash screen, should be translated as something short, is a form that can be seen on a product. Plasma is the project name so shouldn't be translated.", "Plasma made by KDE")
            //}
            Image {
                source: "images/kde.svgz"
                sourceSize.height: PlasmaCore.Units.gridUnit * 2
                sourceSize.width: PlasmaCore.Units.gridUnit * 2
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: PlasmaCore.Units.veryLongDuration * 2
        easing.type: Easing.InOutQuad
    }
}
