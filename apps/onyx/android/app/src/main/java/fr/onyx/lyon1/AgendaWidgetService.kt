package fr.onyx.lyon1

import android.content.Intent
import android.widget.RemoteViewsService
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import io.flutter.Log
import org.json.JSONArray
import java.time.LocalDateTime
import java.time.ZoneId
import java.time.ZoneOffset
import java.time.format.DateTimeFormatter
import java.time.format.TextStyle
import java.util.Locale

class AgendaWidgetService : RemoteViewsService() {
    override fun onGetViewFactory(intent: Intent): RemoteViewsFactory {
        return AgendaRemoteViewsFactory(this.applicationContext, intent)
    }
}

sealed class DisplayItem {
    data class DayHeader(val date: LocalDateTime) : DisplayItem()
    data class EventItem(
        val name:       String,
        val start:      LocalDateTime,
        val end:        LocalDateTime,
        val location:   String,
        val description:String,
        val teacher:    String
    ) : DisplayItem()
}

class AgendaRemoteViewsFactory(
    private val context: Context,
    intent: Intent
) : RemoteViewsService.RemoteViewsFactory {

    private var displayItems: List<DisplayItem> = listOf()

    override fun onCreate() {}

    /**
     * Returns the same list but without past events.
     * Keeps the last day header before the first future event.
     */
    fun truncateList(events: List<Map<String, Any>> ): List<Map<String, Any>> {
        val now = LocalDateTime.now()
        var i = -1
        // Used to display the current day header event if the first event of the day finished
        var lastDay = 0
        var stop = false
        while (!stop) {
            i++
            if (events[i]["day"] as Boolean) {
                lastDay = i
                // If the day header is after today, stop
                if (LocalDateTime.parse(
                        events[i]["date"] as String,
                        DateTimeFormatter.ISO_DATE_TIME).toLocalDate()
                        .isAfter(now.toLocalDate())) {
                    stop = true
                    // Prevents the day header to be displayed twice
                    if (i < events.size - 1)
                        i++
                }
            } else {
                // If the event hasn't finished, stop
                if (
                    LocalDateTime.parse(
                        events[i]["end"] as String,
                        DateTimeFormatter.ISO_DATE_TIME
                    )
                        .isAfter(now)
                )
                    stop = true
            }
        }
        var newEventsList: List<Map<String, Any>> = listOf(events[lastDay])
        newEventsList = newEventsList.plus(events.subList(i, events.size))

        return (newEventsList)
    }

    fun parseDays(daysArray: JSONArray): List<DisplayItem> {
        var items = mutableListOf<DisplayItem>()
        val now = LocalDateTime.now()

        try {
            for (i in 0 until daysArray.length()) {
                val dayObj = daysArray.getJSONObject(i)
                val dayDate = LocalDateTime.parse(dayObj.getString("date"), DateTimeFormatter.ISO_DATE_TIME)
                    .atZone(ZoneOffset.UTC)
                    .withZoneSameInstant(ZoneId.systemDefault()).toLocalDateTime()

                items.add(DisplayItem.DayHeader(dayDate))
                Log.d("AgendaWidgetService", "Added day header: ${dayDate.dayOfWeek.getDisplayName(
                    TextStyle.SHORT_STANDALONE, Locale.getDefault())} $dayDate")

                val eventsArray = dayObj.getJSONArray("events")
                for (j in 0 until eventsArray.length()) {
                    val eventObj = eventsArray.getJSONObject(j)

                    // Parse UTC and convert to local time
                    val startUtc = LocalDateTime.parse(eventObj.getString("start"),
                        DateTimeFormatter.ISO_DATE_TIME)
                    val endUtc = LocalDateTime.parse(eventObj.getString("end"),
                        DateTimeFormatter.ISO_DATE_TIME)

                    // Convert UTC to local time (assuming the events are meant to be displayed in local time)
                    val startLocal = startUtc.atZone(ZoneOffset.UTC)
                        .withZoneSameInstant(ZoneId.systemDefault()).toLocalDateTime()
                    val endLocal = endUtc.atZone(ZoneOffset.UTC)
                        .withZoneSameInstant(ZoneId.systemDefault()).toLocalDateTime()

                    // Only add future events
                    if (endLocal.isAfter(now)) {
                        items.add(DisplayItem.EventItem(
                            name        = eventObj.getString("name"),
                            start       = startLocal,
                            end         = endLocal,
                            location    = eventObj.optString("location", ""),
                            description = eventObj.optString("description", ""),
                            teacher     = eventObj.optString("teacher", "")
                        ))
                    }
                }
            }
        } catch (e: Exception) {
            items = mutableListOf()
        }
        return (items)
    }

    override fun onDataSetChanged() {
        val widgetData = HomeWidgetPlugin.getData(context)
        val daysJson = widgetData.getString("agenda_events", "[]")
        displayItems = parseDays(JSONArray(daysJson))
    }

    override fun getCount() = displayItems.size

    override fun getViewAt(position: Int): RemoteViews {
        val item = displayItems[position]

        return when (item) {
            is DisplayItem.DayHeader -> {
                val views = RemoteViews(context.packageName, R.layout.agenda_widget_day_item)
                val date = item.date

                val dayName = date.dayOfWeek.getDisplayName(TextStyle.SHORT_STANDALONE, Locale.getDefault())
                    .replaceFirstChar {  if (it.isLowerCase()) it.titlecase(Locale.getDefault()) else it.toString() }
                val monthName = date.month.getDisplayName(TextStyle.SHORT_STANDALONE, Locale.getDefault())

                views.setTextViewText(R.id.date, "$dayName ${date.dayOfMonth} $monthName")
                views
            }

            is DisplayItem.EventItem -> {
                val views = RemoteViews(context.packageName, R.layout.agenda_widget_event_item)

                val timeFormat = "${item.start.hour.toString().padStart(2, '0')}:${item.start.minute.toString().padStart(2, '0')}" +
                        " - ${item.end.hour.toString().padStart(2, '0')}:${item.end.minute.toString().padStart(2, '0')}"

                views.setTextViewText(R.id.event_name, item.name)
                views.setTextViewText(R.id.event_details, "$timeFormat\n${item.location}")
                views
            }
        }
    }

    override fun getLoadingView() = null
    override fun getViewTypeCount() = 2
    override fun getItemId(position: Int) = position.toLong()
    override fun hasStableIds() = true
    override fun onDestroy() {}
}

