import SwiftUI

struct NewHabitView: View {
    @EnvironmentObject private var store: HabitStore
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var selectedEmoji = "✨"
    @State private var selectedColor: Color = .teal
    @State private var remindMe = true

    private let emojis = ["✨", "💪", "🥗", "💊", "🚶", "🎸", "🧹", "💰"]
    private let colors: [Color] = [.teal, .blue, .purple, .pink, .orange, .green]

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

