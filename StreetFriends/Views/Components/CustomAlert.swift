//
//  DeleteAlert.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/7/25.
//

import SwiftUI

struct CustomAlert: View {
    let name: String
    @Binding var isPresented: Bool
    var onDelete: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            // ALERT
            VStack(spacing: 0) {
                // 텍스트
                VStack(spacing: 5) {
                    Text("\(name)\(name.eulReul) 친구에서 삭제할까요?")
                        .font(.pretendard(.semiBold, size: 17))
                    
                    Text("삭제 후에는 친구 목록에서\n더 이상 볼 수 없어요.")
                        .font(.pretendard(.regular, size: 13))
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical, 20)
                
                Divider()
                
                // 버튼
                HStack {
                    Spacer()
                    
                    Button {
                        isPresented = false
                        onDelete()
                    } label: {
                        Text("삭제")
                            .font(.pretendard(.regular, size: 17))
                            .foregroundStyle(.red)
                    }
                    
                    
                    Spacer()
                    Divider()
                    Spacer()
                    
                    Button {
                        isPresented = false
                    } label: {
                        Text("취소")
                            .font(.pretendard(.regular, size: 17))
                    }
                    
                    Spacer()
                } //: HSTACK
                .frame(height: 44)
            } //: VSTACK
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 52)
        }
    }
}

#Preview {
    CustomAlert(name: "찐빵이", isPresented: .constant(true), onDelete: {})
}
