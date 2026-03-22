import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class CounterMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :reset) {
            Application.Properties.setValue("c1",0);
            Application.Properties.setValue("c2",0);
        }
        if (item == :exit) {
            System.exit();
        }
    }

}