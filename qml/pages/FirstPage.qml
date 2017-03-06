/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import io.thp.pyotherside 1.3

Page {
    id: page

    Python{
        id:imgpy
         Component.onCompleted: {
             console.log(app.port)
             addImportPath(Qt.resolvedUrl('./'));
             imgpy.importModule('scan',function () {
                 imgpy.startScan();
              });


      }

         function startScan(){
             imgpy.call('scan.scanPort',[app.port],function(result){
                       });
         }

      onReceived:{
          console.log(data.toString())
          if(data.toString() == "OK"){
            busy.running = false;
            //webview.url = "http://127.0.0.1:"+app.port+"/web/index.html"
               var url = "http://127.0.0.1:"+app.port.toString()+"/web/index.html";
              console.log(url)
               webview.visible = true;
              webview.url =url
            console.log(webview.url)
          }
      }
    }


    BusyIndicator {
        id:busy
        running: true
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
    }

     WebView{
        id:webview
        visible: false
        anchors.fill: parent
       // experimental.userAgent:"Qt; Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36  (KHTML, like Gecko) Chrome/32.0.1667.0 Safari/537.36"

        Row {
                id:footItem
                spacing: Theme.paddingLarge
                anchors{
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                    bottomMargin: Theme.paddingMedium
                }
                Button{
                  id:about
                  text:qsTr("About")
                  onClicked:{
                     pageStack.push(aboutPage)
                  }
                }
                Button{
                    id:exit
                    text:qsTr("Double click to Quit")
                    onDoubleClicked: Qt.quit()
                }
        }
    }

     Page{
         id:aboutPage
         Label{
             id:label
             text:" A demo of web html5 test <br/>"+
                  " This html5 game is written by abshinri <br/>"+
                  " You can use this web server to run some html5 apps,"+
                  "This app use 9527 port at first,if this port is used,it will"+
                  " use port between 9000 and 50000.<br/>"+
                  "Just have fun ;)"
             wrapMode: Text.WordWrap
             anchors{
                 centerIn: parent
             }

             width: parent.width - Theme.paddingLarge

         }
     }
}
