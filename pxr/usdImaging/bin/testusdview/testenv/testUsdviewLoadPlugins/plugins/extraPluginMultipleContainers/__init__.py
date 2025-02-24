#
# Copyright 2018 Pixar
#
# Licensed under the terms set forth in the LICENSE.txt file available at
# https://openusd.org/license.
#
from __future__ import print_function

from pxr import Tf
from pxr.Usdviewq.plugin import PluginContainer


class ExtraContainer1(PluginContainer):

    def registerPlugins(self, plugRegistry, plugCtx):

        self._extra1 = plugRegistry.registerCommandPlugin(
            "ExtraContainer1.extraCommand1",
            "Extra Command 1", lambda plugCtx: print("Extra Command 1 Invoked"))
        self._extra2 = plugRegistry.registerCommandPlugin(
            "ExtraContainer1.extraCommand2",
            "Extra Command 2", lambda plugCtx: print("Extra Command 2 Invoked"))

    def configureView(self, plugRegistry, plugUIBuilder):

        extraMenu = plugUIBuilder.findOrCreateMenu("Extra")
        extraMenu.addItem(self._extra1)
        extraMenu.addItem(self._extra2)

Tf.Type.Define(ExtraContainer1)


class ExtraContainer2(PluginContainer):

    def registerPlugins(self, plugRegistry, plugCtx):

        self._extra1 = plugRegistry.registerCommandPlugin(
            "ExtraContainer2.extraCommand1",
            "Extra Command 1", lambda plugCtx: print("Extra Command 1 Invoked"))
        self._extra2 = plugRegistry.registerCommandPlugin(
            "ExtraContainer2.extraCommand2",
            "Extra Command 2", lambda plugCtx: print("Extra Command 2 Invoked"))

    def configureView(self, plugRegistry, plugUIBuilder):

        extraMenu = plugUIBuilder.findOrCreateMenu("Extra")
        extraMenu.addItem(self._extra1)
        extraMenu.addItem(self._extra2)

Tf.Type.Define(ExtraContainer2)
