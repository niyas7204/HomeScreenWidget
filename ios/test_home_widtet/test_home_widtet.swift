//
//  test_home_widtet.swift
//  test_home_widtet
//
//  Created by Administrator on 06/11/24.
//

import WidgetKit
import SwiftUI

private let appGroupId = "group.triel_home_widget"

struct Provider : TimelineProvider{
    func placeholder(in context: Context) ->   SimpleEntry {
        SimpleEntry(date: Date(), tittle: "placeholder tittle", body: "placeholder body",fileName: "Empty file")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let data = UserDefaults.init(suiteName: appGroupId)
        let fileName = data?.string(forKey: "widget_key") ?? "No file exist"
        let entry = SimpleEntry(date: Date(), tittle: data?.string(forKey:"tittle") ?? "tittle not found",  body: data?.string(forKey: "body") ?? "body not found" ,fileName:fileName)
        completion(entry)
        
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(in: context) { entry in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}





struct SimpleEntry : TimelineEntry{
    var date: Date
    let tittle : String
    let body : String
    let fileName : String
}


struct test_home_widgetEntryview :  View {
    var entry : Provider.Entry
    var ImageWidget :some View {
        if let uiImage = UIImage(contentsOfFile: entry.fileName){
           
            let image = Image(uiImage: uiImage)
            return AnyView(image)
        }
        print("image could not be loaded")
        return AnyView(EmptyView())
    }
    var body :some View{
        VStack
        {
            ImageWidget
            Text("hello")
        
         }
}
}
 
struct test_home_widtet: Widget{
    let kind: String = "test_home_screen"
    var body: some WidgetConfiguration{
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            test_home_widgetEntryview(entry: entry)
                
        }
        .configurationDisplayName("My display name")
        .description("example widget")
    }
}


struct test_home_screen_preview: PreviewProvider{
    static var previews: some View{
        test_home_widgetEntryview(entry: SimpleEntry(date: Date(), tittle: "Sample tittle", body: "sample body",fileName: "sample file"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
//
//struct Provider: AppIntentTimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
//    }
//
//    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: configuration)
//    }
//    
//    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        return Timeline(entries: entries, policy: .atEnd)
//    }
//
////    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
////        // Generate a list containing the contexts this widget is relevant in.
////    }
//}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let configuration: ConfigurationAppIntent
//}
//
//struct test_home_widtetEntryView : View {
//    var entry: Provider.Entry
//
//    var body: some View {
//        VStack {
//            Text("Time:")
//            Text(entry.date, style: .time)
//
//            Text("Favorite Emoji:")
//            Text(entry.configuration.favoriteEmoji)
//        }
//    }
//}
//
//struct test_home_widtet: Widget {
//    let kind: String = "test_home_widtet"
//
//    var body: some WidgetConfiguration {
//        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
//            test_home_widtetEntryView(entry: entry)
//                .containerBackground(.fill.tertiary, for: .widget)
//        }
//    }
//}
//
//extension ConfigurationAppIntent {
//    fileprivate static var smiley: ConfigurationAppIntent {
//        let intent = ConfigurationAppIntent()
//        intent.favoriteEmoji = "😀"
//        return intent
//    }
//    
//    fileprivate static var starEyes: ConfigurationAppIntent {
//        let intent = ConfigurationAppIntent()
//        intent.favoriteEmoji = "🤩"
//        return intent
//    }
//}
//
//#Preview(as: .systemSmall) {
//    test_home_widtet()
//} timeline: {
//    SimpleEntry(date: .now, configuration: .smiley)
//    SimpleEntry(date: .now, configuration: .starEyes)
//}
