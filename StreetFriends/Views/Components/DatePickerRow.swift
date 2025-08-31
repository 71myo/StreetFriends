//
//  DatePickerRow.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

import SwiftUI

struct DatePickerRow: View {
    @Binding var date: Date
    
    var body: some View {
        Text(date.formattedDot)
            .font(.pretendard(.medium, size: 16))
            .foregroundStyle(.netural60)
            .padding(12)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .frame(height: 40)
            .overlay(alignment: .trailing) {
                DatePicker("", selection: $date,
                           in: ...Date(), // 미래 날짜 선택 방지
                           displayedComponents: .date)
                .labelsHidden()
                .tint(.green60)
                .colorMultiply(.clear)
            }
    }
}

#Preview {
    DatePickerRow(date: .constant(.now))
}
