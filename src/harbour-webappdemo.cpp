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


#include <QtQuick>
#include <sailfishapp.h>
#include <QGuiApplication>
#include <QDir>
#include <QFile>
#include "httplistener.h"
#include "templatecache.h"
#include "httpsessionstore.h"
#include "requestmapper.h"
#include "filelogger.h"
#include "staticfilecontroller.h"

using namespace stefanfrings;

/** Cache for template files */
TemplateCache* templateCache;

/** Storage for session cookies */
HttpSessionStore* sessionStore;

/** Controller for static files */
StaticFileController* staticFileController;

/** Redirects log messages to a file */
FileLogger* logger;



int main(int argc, char *argv[])
{
    QGuiApplication  app(argc,argv);
    QString appname = "harbour-webappdemo";
    app.setApplicationName(appname);
    app.setOrganizationName("Sailor-CN");

    // Find the configuration file
    QString configFileName= "/usr/share/" + appname + "/"+ appname + ".ini";

    // Configure static file controller
    QSettings* fileSettings = new QSettings(configFileName,QSettings::IniFormat, &app);
    fileSettings->beginGroup("docroot");
    staticFileController = new StaticFileController(fileSettings, &app);

    // Configure and start the TCP listener
    QSettings* listenerSettings = new QSettings(configFileName,QSettings::IniFormat, &app);
    listenerSettings->beginGroup("listener");
    new HttpListener(listenerSettings,new RequestMapper(&app), &app);

    qWarning("Application has started");


    QQuickView* view = SailfishApp::createView();
    view->setSource(SailfishApp::pathTo("qml/harbour-webappdemo.qml"));
    view->show();
    return app.exec();
}
