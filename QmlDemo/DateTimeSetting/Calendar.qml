/*!
*  Copyright (C) 2019, BL Electronic Corporation
*  All rights reserved.
*
*  @projectName        untitled
*  @file               Calendar.qml
*  @brief
*
*  Details.
*
*  @version            V1.0
*  @author             XX
*  @date               2019-10-09
*
*  @history:           Created.
*/
import QtQuick 2.0
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Item {
    id: calendar
    visible: true
    width: 514; height: 160;

    property int curyear: 2019
    property int curmonth: 8
    property int curday: 4
    property int hour: 1
    property int minutes: 1

    //time format
    property string curTimeFormat: "24H"  //12H

    Component.onCompleted: {
        updateDate();//load DateTime
    }

    function updateDate(){
        var info = "2019-10-09#00:55"; //获取到的数据为24小时制
        var dateTime = info.split("#");
        var dateString = dateTime[0].split("-");
        var timeStr = dateTime[1].split(":");
        curyear = parseInt(dateString[0]);
        curmonth = parseInt(dateString[1])
        curday = parseInt(dateString[2])

        hour = parseInt(timeStr[0])
        minutes = parseInt(timeStr[1])
    }

    onCurTimeFormatChanged: {
        tumblerHourColumn.updateModel()
    }

    Component{
        id: tumblerStyle

        //Tumbler style
        TumblerStyle{
            id: style
            delegate: Item{
                implicitHeight: (yearTumbler.height - padding.top - padding.bottom) / style.visibleItemCount
                opacity: 0.4 + Math.max(0, 1 - Math.abs(styleData.displacement)) * 0.6
                Text {
                    id: label
                    text: styleData.value
                    font.pixelSize: 28
                    color: "white";
                    anchors.centerIn: parent
                }
            }
            property Component frame: Item {}
            property Component background: Item {}
            property Component separator: Item {}
            property Component foreground: Item {}
        }
    }

    //year
    Tumbler {
        id: yearTumbler
        x: 4; width: 90; height: 160
        style: tumblerStyle

        TumblerColumn {
            id: tumblerYearColum
            width: 90

            model: ListModel {
                Component.onCompleted: {
                    for (var i = 2000; i < 2100; ++i) {
                        append({value: i.toString()});
                    }
                }
            }
            onCurrentIndexChanged: {
                //当前如果为2月  可能需要更新2月份天数    下标为1
                if(tumblerMonthColum.currentIndex === 1)
                {
                    tumblerDayColumn.updateModel()
                }
            }

        }
        Component.onCompleted: {
            yearTumbler.setCurrentIndexAt(0,curyear-2000);
        }
    }

    //month
    Tumbler {
        id: monthTumbler
        anchors.left: yearTumbler.right
        anchors.leftMargin: 20
        width: 45; height: 160
        style: tumblerStyle

        TumblerColumn {
            id: tumblerMonthColum
            width: 45
            model: ListModel {
                Component.onCompleted: {
                    for (var i = 1; i <= 12; ++i) {
                        append({value: i.toString()});
                    }
                }
            }

            //update dayTumbler
            onCurrentIndexChanged: {
                tumblerDayColumn.updateModel()
            }
        }

        Component.onCompleted: {
            monthTumbler.setCurrentIndexAt(0,curmonth-1)
        }
    }

    //day
    Tumbler{
        id: dayTumbler
        anchors.left: monthTumbler.right
        anchors.leftMargin: 32
        width: 45; height: 160
        style: tumblerStyle

        readonly property var days: [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

        TumblerColumn {
            id: tumblerDayColumn
            width: 45
            model: 31

            function updateModel() {

                var previousIndex = tumblerDayColumn.currentIndex;
                var newDays = dayTumbler.days[tumblerMonthColum.currentIndex]

                //闰年&2月份 下标+1
                if((tumblerYearColum.currentIndex%4 == 0) && (tumblerMonthColum.currentIndex == 1)){

                    newDays = dayTumbler.days[tumblerMonthColum.currentIndex]+1
                }

                var array = [];
                for (var i = 0; i < newDays; ++i) {
                    array.push(i + 1);
                }
                model = array;
                dayTumbler.setCurrentIndexAt(0, Math.min(newDays - 1, previousIndex));
            }
            onCurrentIndexChanged: {}
        }
        Component.onCompleted: {
            dayTumbler.setCurrentIndexAt(0,curday-1)
        }
    }


    //hour
    Tumbler{
        id: hourTumbler
        anchors.left: dayTumbler.right
        anchors.leftMargin: 28
        width: 45; height: 160
        style: tumblerStyle

        readonly property var days: [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

        TumblerColumn {
            id: tumblerHourColumn
            width: 45
            model: 24

            function updateModel() {
                 var array = [];
                if(curTimeFormat === "24H"){
                    for (var i = 0; i < 24; ++i) {
                        array.push(i);
                    }
                }else if( curTimeFormat === "12H" ){
                    for (var j = 1; j <= 12; ++j) {
                        array.push(j);
                    }
                }
                model = array;

                if(curTimeFormat === "12H"){
                    var formatHour = (calendar.hour===0)?12:((calendar.hour+12)%12)
                    hourTumbler.setCurrentIndexAt(0,formatHour-1);
                }else{
                    hourTumbler.setCurrentIndexAt(0,calendar.hour)
                }
            }

            onCurrentIndexChanged: {}

        }
        Component.onCompleted: {
            tumblerHourColumn.updateModel();
        }
    }

    Tumbler{
        id: minutesTumbler
        anchors.left: hourTumbler.right
        anchors.leftMargin: 30
        width: 45; height: 160
        style: tumblerStyle

        TumblerColumn {
            id: tumblerMinutesColumn
            width: 45
            model: ListModel {
                Component.onCompleted: {
                    for (var i = 0; i < 60; ++i) {
                        append({value: i.toString()});
                    }
                }
            }
            onCurrentIndexChanged: {}
        }
        Component.onCompleted: {
            minutesTumbler.setCurrentIndexAt(0,minutes)
        }
    }
}
