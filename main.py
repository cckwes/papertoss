#!/usr/bin/python

#
# qml viewer using pyside
#

from PySide.QtCore import *
from PySide.QtGui import *
from PySide.QtDeclarative import *
import sys

sys.argv[0] = "PaperToss"
app = QApplication(sys.argv)
view = QDeclarativeView()
view.setSource('main.qml')
view.engine().quit.connect(view.close)
view.showFullScreen()

app.exec_()
