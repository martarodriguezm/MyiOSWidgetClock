//
//  MyClockWidget.swift
//  MyClockWidget
//
//  Created by Marta Rodriguez on 27/6/25.
//
import WidgetKit
import SwiftUI

struct ClockEntry: TimelineEntry {
    let date: Date
}

struct ClockProvider: TimelineProvider {
    func placeholder(in context: Context) -> ClockEntry {
        ClockEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (ClockEntry) -> Void) {
        completion(ClockEntry(date: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ClockEntry>) -> Void) {
        let currentDate = Date()
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        let entry = ClockEntry(date: currentDate)
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}

struct ClockWidgetEntryView : View {
    var entry: ClockEntry

    var body: some View {
        VStack {
            Text(entry.date, style: .time)
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
            Text("Have a great day!")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .containerBackground(for: .widget) {
            Color.black
        }
    }
}

@main
struct MyClockWidget: Widget {
    let kind: String = "MyClockWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ClockProvider()) { entry in
            ClockWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.accessoryRectangular]) // StandBy!
        .containerBackgroundRemovable(false) // Fondo visible
        .contentMarginsDisabled()
        .configurationDisplayName("Clock Widget")
        .description("Shows the current time with a daily message.")
    }
}

#Preview(as: .accessoryRectangular) {
    MyClockWidget()
} timeline: {
    ClockEntry(date: .now)
}
