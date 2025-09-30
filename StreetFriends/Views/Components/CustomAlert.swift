//
//  CustomAlert.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/7/25.
//

import SwiftUI

struct CustomAlert: View {
    enum Role {
        case delete(name: String)
        case deleteEncounter
        case save
    }
    
    let role: Role
    
    var title: String {
        switch role {
        case .delete(let name):
            return "\(name)\(name.eulReul) 친구에서 삭제할까요?"
        
        case .deleteEncounter:
            return "이 기록을 삭제할까요?"
            
        case .save:
            return "저장하지 않고 뒤로 가시나요?"
        }
    }
    
    var message: String {
        switch role {
        case .delete:
            return "삭제 후에는 친구 목록에서\n더 이상 볼 수 없어요."
        
        case .deleteEncounter:
            return "삭제 후에는 목록에서\n더 이상 볼 수 없어요."
            
        case .save:
            return "변경한 내용은 저장되지 않습니다."
        }
    }

    var leftTitle: String {
        switch role {
        case .delete, .deleteEncounter:
            "삭제"
        case .save:
            "뒤로가기"
        }
    }
    
    var rightTitle: String {
        switch role {
        case .delete, .deleteEncounter:
            "취소"
        case .save:
            "수정하기"
        }
    }
    
    @Binding var isPresented: Bool
    
    let leftAction: () -> Void
    let rightAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            // ALERT
            VStack(spacing: 0) {
                // 텍스트
                VStack(spacing: 5) {
                    Text(title)
                        .font(.pretendard(.semiBold, size: 17))
                    
                    Text(message)
                        .font(.pretendard(.regular, size: 13))
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical, 20)
                
                Divider()
                
                // 버튼
                HStack {
                    Spacer()
                    
                    // 왼쪽 버튼(primary)
                    Button {
                        isPresented = false
                        leftAction()
                    } label: {
                        Text(leftTitle)
                            .font(.pretendard(.regular, size: 17))
                            .foregroundStyle(.red)
                    }
                    
                    
                    Spacer()
                    Divider()
                    Spacer()
                    
                    // 오른쪽 버튼(secondary)
                    Button {
                        isPresented = false
                        rightAction()
                    } label: {
                        Text(rightTitle)
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
    CustomAlert(role: .delete(name: "찐빵이"), isPresented: .constant(true), leftAction: {}, rightAction: {})
}
