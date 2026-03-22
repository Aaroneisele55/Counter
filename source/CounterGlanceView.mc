import Toybox.Application;
import Toybox.Graphics;
import Toybox.WatchUi;
(:glance)
class CounterGlanceView extends WatchUi.GlanceView {

    function initialize() {
        GlanceView.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();

        var c1Value = Application.Properties.getValue("c1");
        var c2Value = Application.Properties.getValue("c2");
        if (c1Value == null) {
            c1Value = 0;
        }
        if (c2Value == null) {
            c2Value = 0;
        }

        var leftLabel = WatchUi.loadResource(Rez.Strings.glanceCounter1);
        var rightLabel = WatchUi.loadResource(Rez.Strings.glanceCounter2);

        var centerX = width / 2;
        var lineY = (height * 0.55).toNumber();
        var leftX = (width * 0.28).toNumber();
        var rightX = (width * 0.72).toNumber();

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.clear();

        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(leftX, (height * 0.12).toNumber(), Graphics.FONT_XTINY, leftLabel, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(rightX, (height * 0.12).toNumber(), Graphics.FONT_XTINY, rightLabel, Graphics.TEXT_JUSTIFY_CENTER);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(leftX, (height * 0.15).toNumber(), Graphics.FONT_NUMBER_HOT, "" + c1Value, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(rightX, (height * 0.15).toNumber(), Graphics.FONT_NUMBER_HOT, "" + c2Value, Graphics.TEXT_JUSTIFY_CENTER);

        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(centerX, (height * 0.20).toNumber(), centerX, (height * 0.86).toNumber());
    }
}
