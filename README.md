<div align="center">

<img src="https://github.com/user-attachments/assets/3d934c53-b77d-45cc-ae7d-0040244156b0" width="120" alt="길거리 친구들 앱 아이콘" />

# 길거리 친구들

**길에서 만난 친구들과의 추억 일기 🐾**

</div>

<br>

## 📖 소개
**길거리 친구들**은 길에서 만난 고양이를 '친구'로 등록하고,
<br>
만날 때마다 사진과 일지로 '추억'을 쌓아 언제든 돌아볼 수 있는 앱이에요.

<img src="https://github.com/user-attachments/assets/012ed10b-1fa9-49ab-baca-8bf71178db51" width="400" alt="의자에 누워있는 찐빵이" />

이 앱은 치즈 고양이 **찐빵이** 덕분에 시작되었어요.

길에서 친해진 찐빵이를 만날 때마다 반가운 마음에 사진을 찍었고, 사진첩에는 함께한 순간들이 쌓여 갔어요.
<br>
사진뿐만 아니라 그날의 기억과 이야기도 함께 남겨 두고 싶다는 생각에서 길거리 친구들을 만들게 되었어요.

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

- 새로운 친구는 이름과 첫 추억을 함께 등록하고, 만났던 친구에게는 추억을 이어서 쌓을 수 있어요.
- 이미 사용 중인 이름은 등록하거나 수정할 수 없도록 안내해요.

### 친구 & 추억 보기
| 홈 | 친구 상세 | 추억 상세 |
| :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/6d79aee8-6fc5-4b8e-9e20-aec572b3c36e" width="200" alt="홈 화면" /> | <img src="https://github.com/user-attachments/assets/b9ec60a7-582f-41ed-8e66-ce40225dfe5d" width="200" alt="친구 상세 화면" /> | <img src="https://github.com/user-attachments/assets/78c76b48-ae4a-4dfd-82ad-9bc2a2a39b94" width="200" alt="추억 상세 화면" /> |

- 가장 자주 만난 친구, 즐겨찾는 친구, 모든 친구를 한눈에 볼 수 있어요.
- 친구와의 추억을 폴라로이드 카드로 모아 볼 수 있어요.
- 친구와 추억은 언제든 수정하거나 삭제할 수 있고, 수정 중 저장하지 않고 나가려 하면 한 번 더 확인해요.

### 검색 & 즐겨찾기
| 검색 | 즐겨찾기 |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/0acdaca5-caaa-4153-b624-493d78b30b54" width="230" alt="친구 이름을 검색하면 일치하는 글자가 강조되는 화면" /> | <img src="https://github.com/user-attachments/assets/3b983041-158c-4db2-9197-505f94ef1c6f" width="230" alt="하트를 눌러 즐겨찾는 친구에 추가하는 화면" /> |

- 대소문자, 띄어쓰기와 상관없이 찾고, 일치하는 글자를 강조해요.
- 하트를 누르면 홈의 즐겨찾는 친구에 바로 추가돼요.

### 친구 & 추억 공유
| 친구 공유 카드 | 추억 공유 카드 |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/75dce4be-1958-4b3a-a447-9d829a8f5717" width="230" alt="친구 정보가 담긴 폴라로이드 공유 카드" /> | <img src="https://github.com/user-attachments/assets/8de49662-43ca-42c9-90e1-745e5bd847d9" width="230" alt="추억 사진과 일지가 담긴 폴라로이드 공유 카드" /> |

- 친구와 추억을 폴라로이드 카드 이미지로 만들어, 공유 시트로 메시지나 SNS에 바로 보낼 수 있어요.
> 🛠 `ImageRenderer`로 SwiftUI 뷰를 이미지로 만들고, `Transferable` + `ShareLink`로 공유

### 홈 화면 위젯
| 최근 만난 친구 | 이달의 TOP 친구 |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/b2e2c0c6-d2fa-42e1-9a06-7bc40218978f" width="200" alt="가장 최근에 만난 친구 사진이 표시된 위젯" /> | <img src="https://github.com/user-attachments/assets/029df8f6-6735-4c09-aa26-19ba4a5d99b9" width="200" alt="왕관과 함께 이번 달 가장 자주 만난 친구가 표시된 위젯" /> |

- 평소에는 가장 최근에 만난 친구를 보여 주고, 매달 마지막 7일에는 그달 가장 자주 만난 친구를 왕관과 함께 보여 줘요.
> 🛠 `WidgetKit` · `App Group`으로 앱과 같은 SwiftData 저장소를 읽고, "이달의 TOP 친구" 계산 로직을 앱과 공유해 결과를 일치시킴

### 첫 만남 기념일 알림
| 기념일 알림 | 알림을 탭하면 |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/15414e18-2c43-4d99-97f7-119b5d100ac8" width="200" alt="친구를 만난 지 1년이 되었다는 알림" /> | <img src="https://github.com/user-attachments/assets/19682334-4dbc-4692-9168-bad83668a8ec" width="200" alt="알림을 탭해 친구 상세 화면으로 이동하는 화면" /> |

- 친구를 처음 만난 날마다 오전 10시에 알림을 보내요.
- 알림을 탭하면 그 친구의 상세 화면으로 바로 이동해요.
> 🛠 `UserNotifications`로 기념일을 예약하고, 알림의 친구 정보로 상세 화면까지 딥링크 이동

<br>

## ♿ 접근성
모든 사용자가 길거리 친구들을 쓸 수 있도록, 접근성을 기능 개발과 같은 비중으로 다뤘어요.

| 항목 | 내용 |
| --- | --- |
| **VoiceOver** | 아이콘 버튼 라벨, 카드 묶어 읽기, 모달 처리, 토스트·오류 음성 안내, 로터 머리말 이동 |
| **Dynamic Type** | 텍스트 스타일 기준 크기 조절, 큰 글자에서 잘림·겹침 방지, 내비게이션 바 큰 콘텐츠 뷰어 |
| **색상 대비** | Apple HIG 대비 기준으로 점검, 기준에 못 미치는 일부 보조 요소는 대비 증가(Increase Contrast) 설정에서 보완 |
| **터치 영역** | 아이콘 버튼 최소 44×44pt |

### 이렇게 해결했어요
- **카드를 한 번에 읽기**: 친구 카드의 사진, 이름, 즐겨찾기 상태를 하나로 묶어 "찐빵이, 즐겨찾는 친구"처럼 한 번에 읽어요. 작은 하트 버튼은 초점이 여러 번 멈추지 않도록 숨기고, 즐겨찾기는 친구 상세 화면에서 바꿀 수 있어요.
- **잠깐 떴다 사라지는 안내도 들리게**: 토스트와 중복 이름 안내는 VoiceOver 사용자가 놓치기 쉬워 같은 문구를 음성으로 따로 읽어 주고, 화면 전환이 끝난 뒤 읽도록 해 안내가 끊기지 않게 했어요.
- **알림창에 초점 가두기**: 알림창이 뜨면 VoiceOver 초점이 뒤 화면으로 빠져나가지 않게 하고, 두 손가락 문지르기로 닫을 수 있게 했어요.
- **큰 글자에서도 정보가 잘리지 않게**: 글자 크기에 따라 레이아웃을 바꾸고, 공간이 좁은 내비게이션 바는 크기를 제한하는 대신 길게 누르면 크게 보여 주는 큰 콘텐츠 뷰어를 지원했어요.
- **디자인과 대비 사이 균형 맞추기**: 주요 텍스트는 Apple HIG 대비 기준에 맞추고, 기준대로 바꾸면 디자인이 크게 흐트러지는 일부 보조 요소는 기본 색을 유지했어요. 대신 대비 증가 설정을 켠 사용자에게는 더 진한 색으로 바꿔 보여 줘요.

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

MVVM을 직접 적용하며 화면과 로직의 역할을 나누는 것이 목표였어요.
SwiftData의 `@Query`는 View 안에서만 쓸 수 있어 ViewModel이 데이터를 다루는 MVVM 구조와 맞지 않았고, 그래서 데이터 저장과 조회를 `CatRepository`로 감쌌어요.

<img src="https://github.com/user-attachments/assets/ad76a28d-52c5-423a-a16b-d75fac1d4149" width="700" alt="View, ViewModel, CatRepository, SwiftDataCatRepository를 거쳐 App Group 공유 저장소로 이어지고, 위젯이 같은 저장소를 읽는 계층 구조" />

| 계층 | 역할 | 예시 |
| --- | --- | --- |
| **View** | 화면 그리기, 사용자 입력 전달 | `HomeView`, `EncounterInputView` |
| **ViewModel** | 화면 상태 관리, 입력 검증, Repository 호출 | `HomeViewModel`, `CatDetailEditViewModel` |
| **Repository** | 데이터 생성·조회·수정·삭제, 이름 중복 검사 | `CatRepository`, `SwiftDataCatRepository` |
| **Model** | SwiftData 모델 | `Cat`, `Encounter` |

데이터를 저장하고 불러오는 방법(`ModelContext`)은 `CatRepository` 프로토콜 뒤에 숨겨서, ViewModel은 저장 방식을 몰라도 돼요.

### 데이터 흐름 예시

<img src="https://github.com/user-attachments/assets/b2b81417-ceb9-42e4-b38f-5244e8ea878f" width="700" alt="추억 날짜를 수정하면 View, ViewModel, Repository를 거쳐 공유 저장소에 저장되고, 위젯 갱신을 요청해 위젯이 같은 저장소를 다시 읽는 흐름" />

### 주요 설계

**1. Repository를 Environment로 주입**
- `CatRepository`를 SwiftUI `Environment`로 주입해, 실제 앱에서는 `SwiftDataCatRepository`, Preview에서는 `PreviewCatRepository`를 사용해요.
- 주입을 빠뜨리면 기본값인 `DevNullCatRepository`가 바로 오류를 내서, 실수를 빨리 발견할 수 있어요.

**2. 앱과 위젯이 같은 데이터를 사용**
- `SharedModelContainer`가 App Group 폴더에 SwiftData 저장소를 만들고, 앱과 위젯이 같은 저장소를 사용해요.
- 모델(`Cat`, `Encounter`)과 "이번 달 가장 자주 만난 친구" 계산(`MonthlyTopCat`)을 두 타깃이 함께 써서, 홈 화면과 위젯의 결과가 항상 같아요.
- 위젯은 스스로 데이터 변경을 알 수 없어서, Repository가 저장할 때마다 `WidgetCenter`로 갱신을 요청해요.

**3. Router로 화면 이동 관리**
- `NavigationStack`의 경로를 `Router`가 관리해, 어느 화면에서든 `push` / `popToRoot`로 이동해요.
- 기념일 알림을 탭하면 `DeepLinkStore` → `Router`를 거쳐 해당 친구의 상세 화면으로 바로 이동해요.

**4. 공통 UI는 컴포넌트로 분리**
- 내비게이션 바, 입력 필드, 알림창, 토스트 등을 컴포넌트로 만들어 화면 간 디자인과 접근성 처리를 통일했어요.

**5. 비슷한 화면은 ViewModel 하나를 함께 사용**
- 모든 친구, 즐겨찾는 친구, 추억쌓기(친구 선택) 화면은 구성과 기능이 거의 같아, `CatsBrowserViewModel` 하나를 `scope`(`.all` / `.favorites` / `.both`)로 구분해 함께 써요.
- 홈의 ViewModel을 재사용하면 화면별 분기가 늘어 비대해지고, 화면마다 따로 만들면 같은 로직이 반복돼서 그 사이의 방법을 골랐어요.

**6. 추억 화면 사이에는 모델 대신 ID를 전달**
- 추억 상세와 수정 화면은 `Encounter` 모델 대신 `encounterID`를 받아, 각 화면이 Repository에서 직접 불러와요.
- 화면이 바뀌어도 항상 저장소의 최신 데이터를 기준으로 보여 주고 저장하기 위해서예요.

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
├── Utils                # Router, 토스트, 알림 스케줄러, Extension
└── Resources            # 폰트(Pretendard), 이미지 에셋

StreetFriendsWidget      # 홈 화면 위젯
```

<br>

## 💡 고민과 해결

### 1. 써 본 적 없는 VoiceOver, 직접 듣고 판단하기
VoiceOver는 써 본 적이 없어 테스트하는 방법부터 익혀야 했어요. 작업 전에 실기기에서 주요 흐름을 직접 들어 보고 문제를 정리한 뒤 시작했고, 당사자가 아닌 입장에서 그 입장을 생각하는 것이 가장 어려웠어요.

- 친구 셀에 즐겨찾기 상태를 붙였더니 "즐겨찾기"가 세 번 읽힘 → 컨테이너에 값을 붙이면 자식마다 적용된다는 걸 알고, 먼저 하나로 묶은 뒤 값을 지정
- 저장 후 화면이 바뀌면 토스트 안내가 새 화면 제목에 묻힘 → 우선순위를 높이면 현재 음성을 끊어서, 화면 전환 뒤에 낮은 우선순위로 안내
- 직접 만든 알림창은 iOS가 모달인지 몰라 뒤 화면까지 탐색됨 → 모달로 지정하고, 닫기 제스처는 삭제가 아닌 취소 쪽 동작만 실행하도록 함
- "화면을 왼쪽으로 당겨" 안내는 VoiceOver로 할 수 없는 동작 → VoiceOver에는 버튼으로 안내하는 문구를 따로 제공

→ [PR #41](https://github.com/71myo/StreetFriends/pull/41) · [PR #59](https://github.com/71myo/StreetFriends/pull/59)

### 2. 큰 글자와 색상 대비, 기준을 세우고 예외를 판단하기
"기본 크기와 같은 모양"이 아니라 "**어떤 크기에서도 모든 내용을 읽을 수 있는가**"를 기준으로 삼았어요. 큰 글자 사용자에게 크기 제한은 곧 읽기 어려움이라, 본문은 끝까지 커지게 두고 공간이 고정된 곳만 처음 깨지는 단계의 바로 전에서 제한했어요.

색상 대비는 Apple HIG 기준(4.5 : 1, 큰 글자 3 : 1)을 따르되, 자동 검사 결과를 그대로 따르지도 무시하지도 않고 원인을 확인한 뒤 판단했어요.
- 공통 원인이던 흰 배경 위 연한 회색 글자는 보조 글자 색을 통일해 해결
- 디자인상 유지해야 하는 곳은 **대비 증가 설정을 켠 사용자에게만** 기준을 충족하도록 대응
- 예외로 둔 곳은 미리보기라 상세 화면에서 진하게 볼 수 있는지, VoiceOver로 들을 수 있는지 확인한 뒤 결정

→ [PR #43](https://github.com/71myo/StreetFriends/pull/43) · [PR #46](https://github.com/71myo/StreetFriends/pull/46)

### 3. 서버 없이 매년 오는 기념일 알림
"만난 지 n년"은 해마다 문구가 달라서, 반복 알림 대신 **다음 기념일 하나만 예약하고 다시 예약**하는 방식을 택했어요.

처음에는 데이터가 바뀔 때만 다시 예약하면 충분하고, 앱을 열 때마다 하는 건 부담이라고 생각했어요. 하지만 **시간이 흘러서** 다시 예약해야 하는 경우가 있었어요.
- 알림이 울리고 나면 다음 해 예약이 비어 있음
- iOS의 예약 알림 64개 제한으로 밀려 있던 친구는 앞의 알림이 울려 자리가 비었을 때 채워야 함
- 처음에 거절한 알림 권한을 나중에 켠 경우, 앱으로 돌아올 때 예약해야 함

다시 예약하는 비용을 따져 보니 가볍고 여러 번 실행해도 결과가 같아서, **데이터 변경 시에는 데이터의 변화를, 앱 활성화 시에는 시간의 흐름을** 따라가도록 역할을 나눠 둘 다 유지했어요.

→ [PR #31](https://github.com/71myo/StreetFriends/pull/31)

### 4. 홈과 위젯이 같은 결과를 보여 주도록
"가장 자주 만난 친구"가 홈에서는 전체 기간으로, 위젯에서는 이번 달로 계산되고 있었어요. 게다가 위젯은 순서가 없는 딕셔너리에서 `max`로 골라 **동점일 때 결과가 정해지지 않았어요.**

같은 의미의 계산을 두 곳이 각자 하고 있던 게 근본 원인이라, 앱과 위젯이 함께 쓰는 `MonthlyTopCat`으로 분리하고 동점 기준(횟수 → 최근 만난 날 → 등록일)을 끝까지 정했어요.

위젯을 처음 만들 때도 고민이 있었어요.
- 함수 안에서 `.now`를 여러 번 부르면 시각이 조금씩 달라져, 현재 시각을 한 번만 저장해 계산
- 마지막 7일 동안 자정마다 갱신할지 고민했지만, 데이터가 바뀔 때 이미 즉시 갱신하고 있어 경계 시각(마지막 7일 시작, 매월 1일)에만 갱신

→ [PR #25](https://github.com/71myo/StreetFriends/pull/25) · [PR #50](https://github.com/71myo/StreetFriends/pull/50)

### 5. 데이터는 바뀌었는데 화면이 그대로인 문제
추억 날짜를 수정하고 홈으로 돌아와도 "가장 자주 만난 친구"가 바뀌지 않았어요. 앱을 다시 켜면 정상이라 저장은 된 상태였어요.

처음에는 홈으로 돌아올 때 `load()`가 불리지 않는다고 보고, 저장 시 알림을 보내 다시 불러오게 했지만 그대로였어요. 다시 확인해 보니 `load()`는 불리고 있었고, **`@Observable`은 이전과 같은 값을 넣으면 변경을 알리지 않는다**는 것이 원인이었어요. 날짜만 바뀐 경우 다시 가져온 친구 배열이 이전과 같아서 화면이 다시 그려지지 않았던 거예요.

화면이 그려질 때만 계산되던 값을 `load()` 시점에 계산해 저장하도록 바꿔 해결했고, 원인이 아니었던 알림 코드는 빼서 필요한 수정만 남겼어요.

→ [PR #54](https://github.com/71myo/StreetFriends/pull/54)

<br>

## 🌱 배운 점

### 작고 간단한 기능은 없다
"같은 이름의 친구는 등록하지 못하게 하자"는 간단한 기능이라 생각하고 금방 끝날 줄 알았어요. 하지만 막상 만들어 보니 공백과 대소문자를 같은 이름으로 볼지, 수정할 때 자기 이름은 어떻게 할지, 중복 안내 문구가 나타날 때 화면이 밀리지 않는지, VoiceOver와 큰 글자에서는 어떻게 보이는지까지 하나하나 경우의 수를 다 따져 봐야 했어요. 그래서 작고 간단한 기능이란 없다는 걸 알게 됐어요.
이제는 기능을 시작하기 전에 **일어날 수 있는 경우를 먼저 적어 보고**, PR에 테스트 목록으로 남겨요.

### 최신 기술은 쓰는 법보다 동작 원리를 알아야 한다
SwiftUI와 잘 어울리는 `@Observable`과 SwiftData를 직접 써 보고 싶어 선택했어요. 그런데 `@Observable`이 같은 값을 다시 넣으면 변경을 알리지 않는다는 걸 몰라 화면이 갱신되지 않는 문제를 겪었고, SwiftData의 `@Query`는 View에서만 쓸 수 있어 MVVM과 맞추기 위해 Repository로 감싸야 했어요.
새 기술을 쓸 때는 **어떻게 동작하는지, 내 구조와 어디서 부딪히는지**를 함께 확인해야 한다는 걸 배웠어요.

### 앱 밖에서 동작하는 기능은 앱이 챙겨 줘야 한다
위젯을 공부해 보고 싶어 만들면서, 위젯은 앱과 다른 곳에서 실행되고 데이터가 바뀐 걸 스스로 알지 못한다는 걸 알게 됐어요. 기념일 알림도 시간이 흐르면 예약이 비어, 앱이 열릴 때 다시 채워 줘야 했어요.
앱 화면만이 아니라 **앱이 꺼져 있을 때 무슨 일이 일어나는지**까지 생각하게 됐어요.

### 아쉬운 점과 다음 계획
- 일부 화면은 View에서 데이터를 직접 불러와 역할 나누기가 일관되지 않아, ViewModel로 옮겨 정리할 예정이에요.
- 추억 화면은 ID를 전달하지만 친구 상세는 모델을 그대로 전달해, 같은 방식으로 맞출 예정이에요.
- iCloud 동기화를 붙여 휴대폰을 바꿔도 기록을 이어 갈 수 있게 할 예정이에요.

<br>

## 🤝 협업 방식
- **Git 전략**: `main` + 이슈 단위 브랜치(`feat/#번호-이름`, `fix/`, `style/`, `refactor/`, `chore/`) → PR로 머지
- **커밋 컨벤션**: `✨ feat`, `🐛 fix`, `🎨 style`, `♻️ refactor`, `♿️ 접근성`, `➕ add`, `🔧 chore`, `📄 docs`
- **이슈 · PR 템플릿**: 이슈는 기능 / 버그로 나누고, PR은 기능이면 작업 내용, 버그면 문제 · 원인 · 해결로 쓰고 고민한 부분과 테스트 항목을 함께 남겨요.
- **용어 사전**: 디자이너와 앱 용어(친구, 추억, 첫만남 등)를 정리하고 화면 문구를 통일했어요.
- **디자인과 접근성 조율**: 색상 대비처럼 디자인과 접근성이 부딪히는 부분은 디자이너와 함께 확인하고 결정했어요.

<br>

## 👥 만든 사람

| iOS | Design |
| :---: | :---: |
| <a href="https://github.com/71myo">김효정</a> | 황윤정 |
| 기획, iOS 개발 | 기획, UI/UX 디자인 |
