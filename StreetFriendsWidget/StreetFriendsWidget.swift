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
        .init(date: .now, catName: "StreetFriends", photoData: nil, isEmpty: true, isLastWeek: false)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let now = Date()
        completion(makeEntry(date: now))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let now = Date()
        let entry = makeEntry(date: now)
        let nextUpdate = nextRefreshDate(from: now)
        
        completion(Timeline(entries: [entry], policy: .after(nextUpdate)))
    }
}

// MARK: - SwiftData Fetch
private extension Provider {
    func makeEntry(date: Date) -> SimpleEntry {
        let context = ModelContext(SharedModelContainer.container)
        let calendar = Calendar.current
        
        guard let month = calendar.dateInterval(of: .month, for: date) else {
            return .init(date: date, catName: "불러오기 실패", photoData: nil, isEmpty: true, isLastWeek: false)
        }
        
        let startOfLast7Days = calendar.date(byAdding: .day, value: -7, to: month.end)!
        let isInLast7Days = date >= startOfLast7Days
        
        do {
            // 이번 달 Top 1 Cat
            if isInLast7Days, let top = try topCatInThisMonth(context: context, month: month) {
                return .init(date: date, catName: top.name, photoData: top.profilePhoto, isEmpty: false, isLastWeek: true)
            } else {
                // 가장 최근 Cat
                if let last = try mostRecentCat(context: context) {
                    return .init(date: date, catName: last.name, photoData: last.profilePhoto, isEmpty: false, isLastWeek: false)
                } else {
                    return .init(date: date, catName: "미등록", photoData: nil, isEmpty: true, isLastWeek: false)
                }
            }
        } catch {
            return .init(date: date, catName: "불러오기 실패", photoData: nil, isEmpty: true, isLastWeek: false)
        }
    }
    
    /// 최근 고양이 fetch 함수
    func mostRecentCat(context: ModelContext) throws -> Cat? {
        var descriptor = FetchDescriptor<Cat>(
            sortBy: [SortDescriptor(\Cat.creationDate, order: .reverse)]
        )
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).first
    }
    
    /// Top 1 집계 함수
    func topCatInThisMonth(context: ModelContext, month: DateInterval) throws -> Cat? {
        let predicate = #Predicate<Encounter> { e in
            e.date >= month.start && e.date < month.end && e.cat != nil
        }
        
        let descriptor = FetchDescriptor<Encounter>(predicate: predicate)
        let encounters = try context.fetch(descriptor)
        
        var counts: [UUID: Int] = [:]
        var catsById: [UUID: Cat] = [:]
        
        for e in encounters {
            guard let cat = e.cat else { continue }
            counts[cat.id, default: 0] += 1
            catsById[cat.id] = cat
        }
        
        guard let topId = counts.max(by: { $0.value < $1.value })?.key else {
            return nil
        }
        
        return catsById[topId]
    }
    
    /// 다음 갱신 시각 계산 함수
    func nextRefreshDate(from now: Date) -> Date {
        let calendar = Calendar.current
        
        guard let thisMonth = calendar.dateInterval(of: .month, for: now) else {
            return calendar.date(byAdding: .hour, value: 1, to: now) ?? now.addingTimeInterval(3600)
        }
        
        let nextMonthStartMidnight = calendar.startOfDay(for: thisMonth.end)
        
        let last7Start = calendar.date(byAdding: .day, value: -7, to: nextMonthStartMidnight)!
        let last7StartMidnight = calendar.startOfDay(for: last7Start)
        
        if now < last7StartMidnight {
            return last7StartMidnight
        } else {
            return nextMonthStartMidnight
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let catName: String
    let photoData: Data?
    let isEmpty: Bool
    let isLastWeek: Bool
}

// MARK: - View
struct StreetFriendsWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) private var family
    
    private let maxPixel: CGFloat = 320

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
                    
                    if entry.isLastWeek {
                        let month = Calendar.current.component(.month, from: entry.date)
                        
                        Image(.crown)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .rotationEffect(Angle(degrees: -12))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(.top)
                            .padding(.leading)
                            .offset(x: -5, y: 15)

                        VStack(alignment: .leading, spacing: 3) {
                            Text("\(month)월, 가장 자주 만난")
                                .font(.pretendard(.medium, size: 12))
                            Text(entry.catName)
                                .font(.pretendard(.semiBold, size: 14))
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .padding(.bottom)
                        .padding(.leading)
                        .offset(y: -25)
                    }
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
        .supportedFamilies([.systemSmall])
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall) {
    StreetFriendsWidget()
} timeline: {
    SimpleEntry(date: .now, catName: "미등록", photoData: nil, isEmpty: true, isLastWeek: false)
    SimpleEntry(date: .now, catName: "찐빵이", photoData: UIImage(named: "sampleCat")?.pngData(), isEmpty: false, isLastWeek: true)
}
