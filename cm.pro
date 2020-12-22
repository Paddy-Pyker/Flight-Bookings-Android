TEMPLATE = subdirs

SUBDIRS += \
     cm-lib \
     cm-ui
   

cm-ui.depends = cm-lib
