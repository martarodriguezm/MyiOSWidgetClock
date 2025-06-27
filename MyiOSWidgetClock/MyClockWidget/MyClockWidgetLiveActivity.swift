//
//  MyClockWidgetLiveActivity.swift
//  MyClockWidget
//
//  Created by Marta Rodriguez on 27/6/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MyClockWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MyClockWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MyClockWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension MyClockWidgetAttributes {
    fileprivate static var preview: MyClockWidgetAttributes {
        MyClockWidgetAttributes(name: "World")
    }
}

extension MyClockWidgetAttributes.ContentState {
    fileprivate static var smiley: MyClockWidgetAttributes.ContentState {
        MyClockWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MyClockWidgetAttributes.ContentState {
         MyClockWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MyClockWidgetAttributes.preview) {
   MyClockWidgetLiveActivity()
} contentStates: {
    MyClockWidgetAttributes.ContentState.smiley
    MyClockWidgetAttributes.ContentState.starEyes
}
