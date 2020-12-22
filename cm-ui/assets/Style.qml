pragma Singleton
import QtQuick 2.9

Item {



    property alias fontAwesome: fontAwesomeLoader.name

    property int widthWindow
    property int heightWindow

    readonly property real fontSize: (widthWindow * heightWindow) * 0.0002
    readonly property real fontSize2: (widthWindow * heightWindow) * 0.00009


  //              these are the theme colors
    readonly property color colourBackground: "#efefef"
    readonly property color colourNavigationBarBackground: "#000000"
    readonly property color colourNavigationBarFont: "#ffffff"
    readonly property color colourCommandBarBackground: "#cecece"
    readonly property color colourCommandBarFont: "#131313"
    readonly property color colourCommandBarFontDisabled: "#636363"
    readonly property color colourDataControlsBackground: "#ffffff"
    readonly property color colourDataControlsFont: "#131313"
    readonly property color colourPanelBackground: "#ffffff"
    readonly property color colourPanelBackgroundHover: "#ececec"
    readonly property color colourPanelHeaderBackground: "#131313"
    readonly property color colourPanelHeaderFont: "#ffffff"
    readonly property color colourPanelFont: "#131313"
    readonly property color colourItemBackground: "#fefefe"
    readonly property color colourItemBackgroundHover: "#efefef"
    readonly property color colorItemBorder: "#efefef"
    readonly property color colorItemDateFont: "#636363"
    readonly property color colorItemTitleFont: "#131313"
    readonly property color colourDashboardBackground: "#f36f24"
    readonly property color colourDashboardFont: "#ffffff"
    readonly property color colourFormButtonBackground: "#f36f24"
    readonly property color colourFormButtonFont: "#ffffff"
    readonly property color colourDataSelectorBackground: "#131313"
    readonly property color colourDataControlsBackgroundSelected: "#f36f24"
    readonly property color colourDataSelectorFont: "#ffffff"
    readonly property color colourShadow: "#dedede"


    readonly property real sizeScreenMargin: heightWindow * 0.032//20
    readonly property real sizeControlSpacing: heightWindow * 0.016//10




    readonly property int pixelSizeNavigationBarIcon:0.5 * heightNavigationButtonIcon//42
    readonly property int pixelSizeNavigationBarText: 0.3 * heightNavigationButtonDescription// 22
    readonly property real widthNavigationBarCollapsed: -1
    readonly property real heightNavigationBarExpanded: widthNavigationButton

    readonly property real widthNavigationButtonIcon:1/3 * widthNavigationButton// 80
    readonly property real heightNavigationButtonIcon: 1/8 * heightWindow//widthNavigationButtonIcon
    readonly property real widthNavigationButtonDescription: 2/3 * widthNavigationButton//160
    readonly property real heightNavigationButtonDescription: heightNavigationButtonIcon
    readonly property real widthNavigationButton:0.4 * heightWindow// widthNavigationButtonIcon + widthNavigationButtonDescription
    readonly property real heightNavigationButton: Math.max(heightNavigationButtonIcon, heightNavigationButtonDescription)


    readonly property real heightCommandBar: heightCommandButton
    readonly property int pixelSizeCommandBarIcon:  0.42 * widthCommandButton
    readonly property int pixelSizeCommandBarText: 0.2 * widthCommandButton

    readonly property real widthCommandButton:0.14 * heightWindow
    readonly property real heightCommandButton: widthCommandButton



    readonly property int pixelSizeDataControls: 0.46 * heightDataControls
    readonly property real widthDataControls: 0.4 * widthWindow
    readonly property real heightDataControls: 0.065 * heightWindow
    readonly property int sizeDataControlsRadius: 0.0082 * heightWindow


    readonly property int pixelSizePanelHeader: 0.4 * Style.fontSize
    readonly property real heightPanelHeader: 0.06 * heightWindow
    readonly property real sizeShadowOffset: 0.0082 * heightWindow



    readonly property real sizeItemMargin: 0.0082 * heightWindow



    readonly property real widthFormButton: 0.26 * widthWindow
    readonly property real heightFormButton: 0.065 * heightWindow

    readonly property int pixelSizeFormButtonIcon: 0.7 * Style.fontSize2
    readonly property int pixelSizeFormButtonText: 0.5 * Style.fontSize2
    readonly property int sizeFormButtonRadius: 0.009 * heightWindow

    function heightForWidth(w, ss)
    {
        return w/ss.width * ss.height;
    }



    FontLoader {
        id: fontAwesomeLoader
        source: "qrc:/assets/fontawesome.ttf"
    }
}
