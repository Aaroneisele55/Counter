import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Application;

class CounterSettingsMenu extends WatchUi.Menu2 {

    function initialize() {
        Menu2.initialize({:title=>Rez.Strings.AppName});

        addItem(new WatchUi.MenuItem(Rez.Strings.reset, null, :reset, null));
        addItem(
            new WatchUi.ToggleMenuItem(
                Rez.Strings.vibrateEnabled,
                null,
                :toggleVibration,
                getBooleanProperty("vibrateEnabled", true),
                null
            )
        );
        addItem(
            new WatchUi.ToggleMenuItem(
                Rez.Strings.soundEnabled,
                null,
                :toggleSound,
                getBooleanProperty("soundEnabled", false),
                null
            )
        );
        addItem(new WatchUi.MenuItem(Rez.Strings.exit, null, :exit, null));
    }

    private function getBooleanProperty(key as String, defaultValue as Boolean) as Boolean {
        var value = Application.Properties.getValue(key);
        if (value == null) {
            return defaultValue;
        }

        return value as Boolean;
    }
}

class CounterMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as WatchUi.MenuItem) as Void {
        var itemId = item.getId();

        if (itemId == :reset) {
            Application.Properties.setValue("c1",0);
            Application.Properties.setValue("c2",0);
            WatchUi.requestUpdate();
            WatchUi.popView(WatchUi.SLIDE_LEFT);
            return;
        }

        if (itemId == :toggleVibration) {
            persistToggleState(item as WatchUi.ToggleMenuItem, "vibrateEnabled");
            return;
        }

        if (itemId == :toggleSound) {
            persistToggleState(item as WatchUi.ToggleMenuItem, "soundEnabled");
            return;
        }

        if (itemId == :exit) {
            System.exit();
        }
    }

    private function persistToggleState(toggleItem as WatchUi.ToggleMenuItem, key as String) as Void {
        Application.Properties.setValue(key, toggleItem.isEnabled());
        WatchUi.requestUpdate();
    }

}