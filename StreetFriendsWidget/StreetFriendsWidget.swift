//
//  StreetFriendsWidget.swift
//  StreetFriendsWidget
//
//  Created by Hyojeong on 12/23/25.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        .init(date: .now, catName: "StreetFriends", photoData: nil, isEmpty: true)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        completion(makeEntry(date: .now))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = makeEntry(date: .now)
        // MARK: - TODO 월 마지막 주에 갱신되도록 수정하기
        completion(Timeline(entries: [entry], policy: .never))
    }
}

// MARK: - SwiftData Fetch
private extension Provider {
    func makeEntry(date: Date) -> SimpleEntry {
        let context = ModelContext(SharedModelContainer.container)
        
        do {
            var descriptor = FetchDescriptor<Cat>(sortBy: [SortDescriptor(\Cat.creationDate, order: .reverse)])
            descriptor.fetchLimit = 1
            
            let cats = try context.fetch(descriptor)
            
            guard let last = cats.first else {
                return .init(date: date, catName: "미등록", photoData: nil, isEmpty: true)
            }
            
            return .init(date: date, catName: last.name, photoData: last.profilePhoto, isEmpty: false)
        } catch {
            return .init(date: date, catName: "불러오기 실패", photoData: nil, isEmpty: true)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let catName: String
    let photoData: Data?
    let isEmpty: Bool
}

// MARK: - View
struct StreetFriendsWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) private var family
    
    private var maxPixel: CGFloat {
        switch family {
        case .systemSmall: 320
        case .systemMedium: 520
        default: 520
        }
    }

    var body: some View {
        ZStack {
            if entry.isEmpty {
                Image(.mysteryCat)
                    .resizable()
                    .scaledToFit()
                    .padding()
            } else {
                if let data = entry.photoData,
                   let uiImage = WidgetImageDownsampler.makeThumbnail(from: data, maxPixel: maxPixel) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                    
//                    Image(.crown)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 40, height: 40)
//                        .rotationEffect(Angle(degrees: -12))
//                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//                        .padding(.top)
//                        .padding(.leading)
//                        .offset(x: -5, y: 15)
//
//                    VStack(alignment: .leading, spacing: 3) {
//                        Text(entry.date, style: .time)
//                        Text(entry.catName)
//                    }
//                    .foregroundStyle(.white)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
//                    .padding(.bottom)
//                    .padding(.leading)
//                    .offset(y: -25)
                } else {
                    Image(.mysteryCat)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            }
        }
    }
}

struct StreetFriendsWidget: Widget {
    let kind: String = "StreetFriendsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                StreetFriendsWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                StreetFriendsWidgetEntryView(entry: entry)
            }
        }
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall) {
    StreetFriendsWidget()
} timeline: {
    SimpleEntry(date: .now, catName: "미등록", photoData: nil, isEmpty: true)
    SimpleEntry(date: .now, catName: "찐빵이", photoData: UIImage(named: "sampleCat")?.pngData(), isEmpty: false)
}
