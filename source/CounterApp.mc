import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
(:glance)
class CounterApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        // Initialize counters if not already set
        if (Application.Properties.getValue("c1") == null) {
            Application.Properties.setValue("c1", 0);
        }
        if (Application.Properties.getValue("c2") == null) {
            Application.Properties.setValue("c2", 0);
        }
        if (Application.Properties.getValue("vibrateEnabled") == null) {
            Application.Properties.setValue("vibrateEnabled", true);
        }
        if (Application.Properties.getValue("soundEnabled") == null) {
            Application.Properties.setValue("soundEnabled", false);
        }
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new CounterView(), new CounterDelegate() ];
    }

    function getGlanceView() as [WatchUi.GlanceView] or [WatchUi.GlanceView, WatchUi.GlanceViewDelegate] or Null {
        return [ new CounterGlanceView() ];
    }

}

function getApp() as CounterApp {
    return Application.getApp() as CounterApp;
}