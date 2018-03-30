# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-webappdemo

CONFIG += sailfishapp

QT = core network

SOURCES += src/harbour-webappdemo.cpp \
    src/requestmapper.cpp \
    src/controller/dumpcontroller.cpp \
    src/controller/fileuploadcontroller.cpp \
    src/controller/formcontroller.cpp \
    src/controller/sessioncontroller.cpp \
    src/controller/templatecontroller.cpp

HEADERS += \
    src/requestmapper.h \
    src/controller/dumpcontroller.h \
    src/controller/fileuploadcontroller.h \
    src/controller/formcontroller.h \
    src/controller/sessioncontroller.h \
    src/controller/templatecontroller.h

OTHER_FILES += qml/harbour-webappdemo.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-webappdemo.changes.in \
    rpm/harbour-webappdemo.spec \
    rpm/harbour-webappdemo.yaml \
    harbour-webappdemo.ini \
    translations/*.ts \
    harbour-webappdemo.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256


# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-webappdemo-de.ts


config.path = /usr/share/harbour-webappdemo
config.files = harbour-webappdemo.ini


INSTALLS += config

include(QtWebApp/logging/logging.pri)
include(QtWebApp/httpserver/httpserver.pri)
include(QtWebApp/templateengine/templateengine.pri)
