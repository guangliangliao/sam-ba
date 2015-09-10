TEMPLATE = subdirs

OTHER_FILES += TODO

rootdocs.path = /
rootdocs.files = README.md LICENSE.txt
unix:contains(QT_ARCH, arm):rootdocs.files += README.armv7.md
INSTALLS += rootdocs

qtconf.path = /
qtconf.files = qt.conf
INSTALLS += qtconf

SUBDIRS = \
        doc \
	sambacommon \
	plugins \
	examples \
	sambacmd

# copy Qt libs
unix:{
	qtlibs.path = /
	qtlibs.commands = \
		$(COPY) $$[QT_INSTALL_LIBS]/libQt5Core.so.5 \$(INSTALL_ROOT)/lib && \
		$(COPY) $$[QT_INSTALL_LIBS]/libQt5Gui.so.5 \$(INSTALL_ROOT)/lib && \
		$(COPY) $$[QT_INSTALL_LIBS]/libQt5Network.so.5 \$(INSTALL_ROOT)/lib && \
		$(COPY) $$[QT_INSTALL_LIBS]/libQt5Qml.so.5 \$(INSTALL_ROOT)/lib && \
		$(COPY) $$[QT_INSTALL_LIBS]/libQt5Quick.so.5 \$(INSTALL_ROOT)/lib && \
		$(COPY) $$[QT_INSTALL_LIBS]/libQt5SerialPort.so.5 \$(INSTALL_ROOT)/lib && \
		$(COPY) $$[QT_INSTALL_LIBS]/libicudata.so.54 \$(INSTALL_ROOT)/lib && \
		$(COPY) $$[QT_INSTALL_LIBS]/libicui18n.so.54 \$(INSTALL_ROOT)/lib && \
		$(COPY) $$[QT_INSTALL_LIBS]/libicuuc.so.54 \$(INSTALL_ROOT)/lib && \
		$(COPY_DIR) $$[QT_INSTALL_LIBS]/../qml/QtQuick.2 \$(INSTALL_ROOT)/qml
	INSTALLS += qtlibs
}
else:win32:{
        qtlibs.path = /
        CONFIG(debug, debug|release):{
            qtlibs.files = \
                    $$[QT_INSTALL_LIBS]/../bin/Qt5Cored.dll \
                    $$[QT_INSTALL_LIBS]/../bin/Qt5Guid.dll \
                    $$[QT_INSTALL_LIBS]/../bin/Qt5Networkd.dll \
                    $$[QT_INSTALL_LIBS]/../bin/Qt5Qmld.dll \
                    $$[QT_INSTALL_LIBS]/../bin/Qt5Quickd.dll \
                    $$[QT_INSTALL_LIBS]/../bin/Qt5SerialPortd.dll
        }
        else:{
            qtlibs.files = \
                    $$[QT_INSTALL_LIBS]/../bin/Qt5Core.dll \
                    $$[QT_INSTALL_LIBS]/../bin/Qt5Gui.dll \
                    $$[QT_INSTALL_LIBS]/../bin/Qt5Network.dll \
                    $$[QT_INSTALL_LIBS]/../bin/Qt5Qml.dll \
                    $$[QT_INSTALL_LIBS]/../bin/Qt5Quick.dll \
                    $$[QT_INSTALL_LIBS]/../bin/Qt5SerialPort.dll
        }
        INSTALLS += qtlibs

        otherlibs.path = /
        otherlibs.files = \
                $$[QT_INSTALL_LIBS]/../bin/icudt54.dll \
                $$[QT_INSTALL_LIBS]/../bin/icuin54.dll \
                $$[QT_INSTALL_LIBS]/../bin/icuuc54.dll \
                $$[QT_INSTALL_LIBS]/../bin/libwinpthread-1.dll \
                $$[QT_INSTALL_LIBS]/../bin/libgcc_s_dw2-1.dll
                ~#$$[QT_INSTALL_LIBS]/../bin/libstdc++-6.dll \
        INSTALLS += otherlibs

        qmlmodules.path = /qml
        qmlmodules.files = $$[QT_INSTALL_LIBS]/../qml/QtQuick.2
        INSTALLS += qmlmodules
}

plugins.depends = sambacommon
sambacmd.depends = sambacommon
