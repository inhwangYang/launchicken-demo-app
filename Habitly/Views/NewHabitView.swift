import SwiftUI

struct NewHabitView: View {
    @EnvironmentObject private var store: HabitStore
    @Environment(\.dismiss) private var dismiss

    @State private var name: String
    @State private var selectedEmoji: String
    @State private var selectedColor: Color
    @State private var remindMe = true

    private let emojis = ["✨", "💪", "🥗", "💊", "🚶", "🎸", "🧹", "💰"]
    private let colors: [Color] = [.teal, .blue, .purple, .pink, .orange, .green]

    init() {
        // Launchicken 스크린샷 모드에서는 이모지/색상을 고르는 중인 것처럼 보이도록
        // 예시 습관 이름과 선택된 이모지/색상을 미리 채워둡니다. 일반 실행에서는 빈 값 그대로입니다.
        if Launchicken.isScreenshotMode {
            _name = State(initialValue: "저녁 8시 이후 금식하기")
            _selectedEmoji = State(initialValue: "🥗")
            _selectedColor = State(initialValue: .green)
        } else {
            _name = State(initialValue: "")
            _selectedEmoji = State(initialValue: "✨")
            _selectedColor = State(initialValue: .teal)
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("습관 이름") {
                    TextField("예: 아침에 이불 정리하기", text: $name)
                }
                Section("아이콘") {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 8)) {
                        ForEach(emojis, id: \.self) { emoji in
                            Text(emoji)
                                .font(.title2)
                                .frame(width: 36, height: 36)
                                .background(
                                    selectedEmoji == emoji ? selectedColor.opacity(0.2) : .clear,
                                    in: RoundedRectangle(cornerRadius: 10)
                                )
                                .onTapGesture { selectedEmoji = emoji }
                        }
                    }
                }
                Section("색상") {
                    HStack(spacing: 14) {
                        ForEach(Array(colors.enumerated()), id: \.offset) { _, color in
                            Circle()
                                .fill(color)
                                .frame(width: 32, height: 32)
                                .overlay {
                                    if color == selectedColor {
                                        Image(systemName: "checkmark")
                                            .font(.caption.bold())
                                            .foregroundStyle(.white)
                                    }
                                }
                                .onTapGesture { selectedColor = color }
                        }
                    }
                    .padding(.vertical, 4)
                }
                Section {
                    Toggle("매일 알림 받기", isOn: $remindMe)
                }
            }
            .navigationTitle("새 습관 만들기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("취소") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("추가") {
                        store.add(emoji: selectedEmoji, name: name, color: selectedColor)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}
