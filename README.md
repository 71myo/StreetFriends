<div align="center">

<img src="https://github.com/user-attachments/assets/3d934c53-b77d-45cc-ae7d-0040244156b0" width="120" alt="길거리 친구들 앱 아이콘" />

# 길거리 친구들

**길에서 만난 친구들과의 추억 일기 🐾**

</div>

<br>

## 📖 소개
**길거리 친구들**은 길에서 만난 고양이를 '친구'로 등록하고,
<br>
만날 때마다 사진과 일지로 '추억'을 쌓아 언제든 돌아볼 수 있는 앱입니다.

<img src="https://github.com/user-attachments/assets/012ed10b-1fa9-49ab-baca-8bf71178db51" width="400" alt="의자에 누워있는 찐빵이" />

이 앱은 치즈 고양이 **찐빵이** 덕분에 시작되었습니다.

길에서 친해진 찐빵이를 만날 때마다 반가운 마음에 사진을 찍었고, 사진첩에는 함께한 순간들이 쌓여 갔습니다.
<br>
사진뿐만 아니라 그날의 기억과 이야기도 함께 남겨 두고 싶다는 생각에서 길거리 친구들을 만들게 되었습니다.

<br>

| 개발 기간 | 개발 인원 | 플랫폼 |
| --- | --- | --- |
| 2025.08 ~ 2026.01 (1차 개발)<br>2026.11 (접근성 및 완성도 개선) | iOS 1명, 디자인 1명 | iOS 18.5+ |

<br>

## 📱 주요 기능

### 친구 등록 & 추억 쌓기
| 새로운 친구 등록 | 만났던 친구 추억 쌓기 | 중복 이름 안내 |
| :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/30fc3428-54de-4619-9e43-c56b21742784" width="200" alt="새로운 친구를 등록하는 화면" /> | <img src="https://github.com/user-attachments/assets/032a8dba-07ac-44ce-a83f-0c4b17462710" width="200" alt="만났던 친구에게 추억을 쌓는 화면" /> | <img src="https://github.com/user-attachments/assets/8c2501a9-6206-46d7-b266-375185e62eb5" width="200" alt="이미 사용 중인 이름을 입력했을 때 안내 문구가 표시된 화면" /> |

- 새로운 친구는 이름과 첫 추억을 함께 등록하고, 만났던 친구에게는 추억을 이어서 쌓을 수 있어요
- 이미 사용 중인 이름은 등록하거나 수정할 수 없도록 안내해요

### 친구 & 추억 보기
| 홈 | 친구 상세 | 추억 상세 |
| :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/6d79aee8-6fc5-4b8e-9e20-aec572b3c36e" width="200" alt="홈 화면" /> | <img src="https://github.com/user-attachments/assets/b9ec60a7-582f-41ed-8e66-ce40225dfe5d" width="200" alt="친구 상세 화면" /> | <img src="https://github.com/user-attachments/assets/78c76b48-ae4a-4dfd-82ad-9bc2a2a39b94" width="200" alt="추억 상세 화면" /> |

- 가장 자주 만난 친구, 즐겨찾는 친구, 모든 친구를 한눈에 볼 수 있어요
- 친구와의 추억을 폴라로이드 카드로 모아 볼 수 있어요
- 친구와 추억은 언제든 수정하거나 삭제할 수 있고, 수정 중 저장하지 않고 나가려 하면 한 번 더 확인해요

### 검색 & 즐겨찾기
| 검색 | 즐겨찾기 |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/0acdaca5-caaa-4153-b624-493d78b30b54" width="230" alt="친구 이름을 검색하면 일치하는 글자가 강조되는 화면" /> | <img src="https://github.com/user-attachments/assets/3b983041-158c-4db2-9197-505f94ef1c6f" width="230" alt="하트를 눌러 즐겨찾는 친구에 추가하는 화면" /> |

- 대소문자, 띄어쓰기와 상관없이 찾고, 일치하는 글자를 강조해요
- 하트를 누르면 홈의 즐겨찾는 친구에 바로 추가돼요

### 친구 & 추억 공유
| 친구 공유 카드 | 추억 공유 카드 |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/75dce4be-1958-4b3a-a447-9d829a8f5717" width="230" alt="친구 정보가 담긴 폴라로이드 공유 카드" /> | <img src="https://github.com/user-attachments/assets/8de49662-43ca-42c9-90e1-745e5bd847d9" width="230" alt="추억 사진과 일지가 담긴 폴라로이드 공유 카드" /> |

- 친구와 추억을 폴라로이드 카드 이미지로 만들어, 공유 시트로 메시지나 SNS에 바로 보낼 수 있어요
> 🛠 `ImageRenderer`로 SwiftUI 뷰를 이미지로 만들고, `Transferable` + `ShareLink`로 공유

### 홈 화면 위젯
| 최근 만난 친구 | 이달의 TOP 친구 |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/b2e2c0c6-d2fa-42e1-9a06-7bc40218978f" width="200" alt="가장 최근에 만난 친구 사진이 표시된 위젯" /> | <img src="https://github.com/user-attachments/assets/029df8f6-6735-4c09-aa26-19ba4a5d99b9" width="200" alt="왕관과 함께 이번 달 가장 자주 만난 친구가 표시된 위젯" /> |

- 평소에는 가장 최근에 만난 친구를 보여 주고, 매달 마지막 7일에는 그달 가장 자주 만난 친구를 왕관과 함께 보여 줘요
> 🛠 `WidgetKit` · `App Group`으로 앱과 같은 SwiftData 저장소를 읽고, "이달의 TOP 친구" 계산 로직을 앱과 공유해 결과를 일치시킴

### 첫 만남 기념일 알림
| 기념일 알림 | 알림을 탭하면 |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/15414e18-2c43-4d99-97f7-119b5d100ac8" width="200" alt="친구를 만난 지 1년이 되었다는 알림" /> | <img src="https://github.com/user-attachments/assets/19682334-4dbc-4692-9168-bad83668a8ec" width="200" alt="알림을 탭해 친구 상세 화면으로 이동하는 화면" /> |

- 친구를 처음 만난 날마다 오전 10시에 알림을 보내요
- 알림을 탭하면 그 친구의 상세 화면으로 바로 이동해요
> 🛠 `UserNotifications`로 기념일을 예약하고, 알림의 친구 정보로 상세 화면까지 딥링크 이동

<br>

## ♿ 접근성
모든 사용자가 길거리 친구들을 쓸 수 있도록, 접근성을 기능 개발과 같은 비중으로 다뤘습니다.

| 항목 | 내용 |
| --- | --- |
| **VoiceOver** | 아이콘 버튼 라벨, 카드 묶어 읽기, 모달 처리, 토스트·오류 음성 안내, 로터 머리말 이동 |
| **Dynamic Type** | 텍스트 스타일 기준 크기 조절, 큰 글자에서 잘림·겹침 방지, 내비게이션 바 큰 콘텐츠 뷰어 |
| **색상 대비** | Apple HIG 대비 기준으로 점검, 기준에 못 미치는 일부 보조 요소는 대비 증가(Increase Contrast) 설정에서 보완 |
| **터치 영역** | 아이콘 버튼 최소 44×44pt |

### 이렇게 해결했어요
- **카드를 한 번에 읽기**: 친구 카드의 사진, 이름, 즐겨찾기 상태를 하나로 묶어 "찐빵이, 즐겨찾는 친구"처럼 한 번에 읽어요. 작은 하트 버튼은 초점이 여러 번 멈추지 않도록 숨기고, 즐겨찾기는 친구 상세 화면에서 바꿀 수 있어요
- **잠깐 떴다 사라지는 안내도 들리게**: 토스트와 중복 이름 안내는 VoiceOver 사용자가 놓치기 쉬워 같은 문구를 음성으로 따로 읽어 주고, 화면 전환이 끝난 뒤 읽도록 해 안내가 끊기지 않게 했어요
- **알림창에 초점 가두기**: 알림창이 뜨면 VoiceOver 초점이 뒤 화면으로 빠져나가지 않게 하고, 두 손가락 문지르기로 닫을 수 있게 했어요
- **큰 글자에서도 정보가 잘리지 않게**: 글자 크기에 따라 레이아웃을 바꾸고, 공간이 좁은 내비게이션 바는 크기를 제한하는 대신 길게 누르면 크게 보여 주는 큰 콘텐츠 뷰어를 지원했어요
- **디자인과 대비 사이 균형 맞추기**: 주요 텍스트는 Apple HIG 대비 기준에 맞추고, 기준대로 바꾸면 디자인이 크게 흐트러지는 일부 보조 요소는 기본 색을 유지했어요. 대신 대비 증가 설정을 켠 사용자에게는 더 진한 색으로 바꿔 보여 줘요

### 이렇게 확인했어요
- 실기기에서 VoiceOver를 켜고 주요 흐름을 직접 사용
- Accessibility Inspector로 라벨, 동작, 대비 점검
- 가장 큰 글자 크기(AX5)와 iPhone SE에서 레이아웃 확인

### VoiceOver

| 홈 둘러보기 | 친구 등록하기 |
| :---: | :---: |
| <video src="https://github.com/user-attachments/assets/c1bd0b4f-ecb7-4898-b398-c892598c447f" width="230" controls></video> | <video src="https://github.com/user-attachments/assets/1179ac95-38ee-444c-bb77-53217983046a" width="230" controls></video> |
| 로터로 섹션 사이를 이동하고,<br>친구 카드를 한 번에 읽어요 | 중복 이름과 저장 결과를<br>음성으로 안내해요 |

### Dynamic Type
| 홈 (기본) | 홈 (AX5) | 친구 상세 (기본) | 친구 상세 (AX5) |
| :---: | :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/ed2b759f-e9f8-4b0b-af5a-d47d5c98d4c6" width="170" alt="기본 글자 크기의 홈 화면"> | <img src="https://github.com/user-attachments/assets/9a093acb-7aa0-4dc2-8531-d2dabcbb70a4" width="170" alt="가장 큰 글자 크기의 홈 화면"> | <img src="https://github.com/user-attachments/assets/f6ad77f1-6fca-459c-8f74-afdc6aa6b9e5" width="170" alt="기본 글자 크기의 친구 상세 화면"> | <img src="https://github.com/user-attachments/assets/30f50303-420c-4720-a119-aa277fa0d185" width="170" alt="가장 큰 글자 크기의 친구 상세 화면"> |

| 큰 콘텐츠 뷰어 |
| :---: |
| <img src="https://github.com/user-attachments/assets/d51c4d62-cb49-472a-ab22-354cf75cc631" width="200" alt="내비게이션 버튼을 길게 눌러 크게 표시된 화면"> |
| 크기를 제한한 내비게이션 버튼은<br>길게 누르면 크게 보여 줘요 |

<br>

## 🛠 기술 스택

**개발 환경**: iOS 18.5+ · Xcode 26 · Swift 5

SwiftUI와 잘 어울리는 최신 Apple 프레임워크를 직접 써 보는 것을 목표로, 외부 라이브러리 없이 개발했어요.

| 분류 | 기술 | 선택 이유 |
| --- | --- | --- |
| UI | SwiftUI | 최신 iOS 개발의 중심인 선언형 UI를 처음부터 끝까지 직접 다뤄 보기 위해 |
| 상태 관리 | Observation (`@Observable`) | 기존 `ObservableObject`를 대신해 SwiftUI와 함께 쓰도록 나온 최신 방식을 직접 써 보며 차이를 익히기 위해 |
| 데이터 | SwiftData | SwiftUI와 함께 쓰도록 설계된 최신 저장 프레임워크로, Swift 코드만으로 모델과 관계를 정의해 보기 위해 |
| 위젯 | WidgetKit | 앱 밖에서 동작하는 확장(Extension)을 직접 만들어 보고 싶어서. App Group으로 앱과 데이터를 공유하는 방법까지 함께 익힘 |
| 알림 | UserNotifications | 정해진 날짜에 보내는 간단한 알림이라, 서버 없이 기기에서 예약하는 로컬 알림으로 충분해서 |
| 아키텍처 | MVVM, Repository 패턴 | 가장 널리 쓰이는 MVVM을 직접 적용하며 화면과 로직의 역할 나누기를 익히기 위해. Repository로 데이터 저장을 분리해 Preview에서는 가짜 데이터로 화면을 확인 |
| 협업 | Git, GitHub (Issue · PR 템플릿), Figma | 모든 작업을 이슈와 PR 단위로 기록하고, 디자이너와 Figma로 협업 |

**그 밖에 사용한 기술**: PhotosUI(사진 선택) · ImageRenderer, ShareLink(공유 카드) · Swift Concurrency(알림 권한 요청과 예약)

<br>

## 🏗 아키텍처
### MVVM + Repository

View는 화면만 그리고, ViewModel이 화면 상태와 로직을 담당해요.
데이터 저장은 `CatRepository` 프로토콜 뒤에 숨겨서, ViewModel은 SwiftData를 직접 알지 않아요.

```mermaid
flowchart LR
    subgraph App["📱 App"]
        View["View<br/>(SwiftUI)"]
        VM["ViewModel<br/>(@Observable)"]
        Protocol["CatRepository<br/>(protocol)"]
        Impl["SwiftDataCatRepository"]
        Preview["PreviewCatRepository"]
    end

    subgraph Shared["🗂 App Group 공유 저장소"]
        Store[("SwiftData<br/>Cat · Encounter")]
    end

    subgraph Widget["🧩 Widget"]
        Provider["TimelineProvider"]
    end

    View -->|사용자 동작| VM
    VM -->|상태| View
    VM --> Protocol
    Protocol -.구현.-> Impl
    Protocol -.구현.-> Preview
    Impl --> Store
    Impl -->|저장 시 위젯 갱신 요청| Provider
    Provider -->|읽기| Store
```

| 계층 | 역할 | 예시 |
| --- | --- | --- |
| **View** | 화면 그리기, 사용자 입력 전달 | `HomeView`, `EncounterInputView` |
| **ViewModel** | 화면 상태 관리, 입력 검증, Repository 호출 | `HomeViewModel`, `CatDetailEditViewModel` |
| **Repository** | 데이터 생성·조회·수정·삭제, 이름 중복 검사 | `CatRepository`, `SwiftDataCatRepository` |
| **Model** | SwiftData 모델 | `Cat`, `Encounter` |

### 주요 설계

**1. Repository를 Environment로 주입**
- `CatRepository`를 SwiftUI `Environment`로 주입해, 실제 앱에서는 `SwiftDataCatRepository`, Preview에서는 `PreviewCatRepository`를 사용해요
- 주입을 빠뜨리면 기본값인 `DevNullCatRepository`가 바로 오류를 내서, 실수를 빨리 발견할 수 있어요

**2. 앱과 위젯이 같은 데이터를 사용**
- `SharedModelContainer`가 App Group 폴더에 SwiftData 저장소를 만들고, 앱과 위젯이 같은 저장소를 사용해요
- 모델(`Cat`, `Encounter`)과 "이번 달 가장 자주 만난 친구" 계산(`MonthlyTopCat`)을 두 타깃이 함께 써서, 홈 화면과 위젯의 결과가 항상 같아요
- 데이터가 바뀌면 Repository가 `WidgetCenter`로 위젯 갱신을 요청해요

**3. Router로 화면 이동 관리**
- `NavigationStack`의 경로를 `Router`가 관리해, 어느 화면에서든 `push` / `popToRoot`로 이동해요
- 기념일 알림을 탭하면 `DeepLinkStore` → `Router`를 거쳐 해당 친구의 상세 화면으로 바로 이동해요

**4. 공통 UI는 컴포넌트로 분리**
- 내비게이션 바, 입력 필드, 알림창, 토스트 등을 컴포넌트로 만들어 화면 간 디자인과 접근성 처리를 통일했어요

### 폴더 구조

```
StreetFriends
├── App                  # 앱 진입점, AppDelegate (알림 처리)
├── Data
│   ├── Models           # SwiftData 모델 (Cat, Encounter)
│   ├── Repositories     # CatRepository 프로토콜과 구현체
│   └── Shared           # 앱·위젯 공용 (저장소 설정, 월간 TOP 계산)
├── ViewModels           # 화면별 ViewModel
├── Views
│   ├── Screens          # 화면 단위 View
│   └── Components       # 재사용 UI 컴포넌트
└── Utils                # Router, 토스트, 알림 스케줄러, Extension

StreetFriendsWidget      # 홈 화면 위젯
```

<br>

## 💡 고민과 해결

<br>

## 🌱 배운 점

<br>

## 👥 만든 사람

| iOS | Design |
| :---: | :---: |
| <a href="https://github.com/71myo">김효정</a> | 황윤정 |
