package fr.onyx.lyon1

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

import es.antonborri.home_widget.HomeWidgetPlugin
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

/**
 * Implementation of an Home screen widget. It displays a list of upcoming events
 * sent by Flutter side.
 */
class AgendaWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onEnabled(context: Context) {}

    override fun onDisabled(context: Context) {}
}

internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    val widgetData = HomeWidgetPlugin.getData(context)
    val views = RemoteViews(context.packageName, R.layout.agenda_widget).apply {
        val lastUpdateString = widgetData.getString("agenda_last_update", null)
        var lastUpdateText = context.getString(R.string.agenda_widget_last_update)

        if (lastUpdateString != null) {
            try {
                val lastUpdate = LocalDateTime.parse(lastUpdateString, DateTimeFormatter.ISO_LOCAL_DATE_TIME)
                lastUpdateText += lastUpdate.format(DateTimeFormatter.ofPattern("dd/MM/yy HH:mm"))
            } catch (e: Exception) {
                lastUpdateText += context.getString(R.string.no_data)
            }
        } else {
            lastUpdateText += context.getString(R.string.no_data)
        }

        setTextViewText(R.id.last_updated, lastUpdateText)

        setEmptyView(R.id.list_view, R.id.empty)
        val intent = Intent(context, AgendaWidgetService::class.java)
        /** setRemoteAdapter(int, Intent) is deprecated
         * but the alternative setRemoteAdapter(int, RemoteCollectionItems)
         * requires API 31 (current min is 24)*/
        setRemoteAdapter(R.id.list_view, intent)
    }

    appWidgetManager.notifyAppWidgetViewDataChanged(appWidgetId, R.id.list_view)
    appWidgetManager.updateAppWidget(appWidgetId, views)
}
