import SwiftUI

struct Habit: Identifiable {
    let id = UUID()
    var emoji: String
    var name: String
    var color: Color
    var streak: Int
    var doneToday: Bool
    /// 최근 7일 달성 여부 (오래된 날 -> 오늘)
    var week: [Bool]
}

final class HabitStore: ObservableObject {
    @Published var habits: [Habit] = [
        Habit(emoji: "💧", name: "물 2L 마시기", color: .blue, streak: 12, doneToday: true,
              week: [true, true, false, true, true, true, true]),
        Habit(emoji: "🧘", name: "아침 스트레칭 10분", color: .orange, streak: 5, doneToday: true,
              week: [false, true, true, true, false, true, true]),
        Habit(emoji: "📚", name: "책 20쪽 읽기", color: .purple, streak: 21, doneToday: false,
              week: [true, true, true, true, true, true, false]),
        Habit(emoji: "🏃", name: "5km 러닝", color: .green, streak: 3, doneToday: true,
              week: [false, false, true, false, true, true, true]),
        Habit(emoji: "🌙", name: "12시 전에 잠들기", color: .indigo, streak: 8, doneToday: false,
              week: [true, true, true, false, true, true, false]),
    ]

    var completedToday: Int { habits.filter(\.doneToday).count }
    var completionRate: Double {
        habits.isEmpty ? 0 : Double(completedToday) / Double(habits.count)
    }
    var bestStreak: Int { habits.map(\.streak).max() ?? 0 }

    func toggle(_ habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        habits[index].doneToday.toggle()
        habits[index].week[6] = habits[index].doneToday
        habits[index].streak += habits[index].doneToday ? 1 : -1
    }

    func add(emoji: String, name: String, color: Color) {
        habits.append(Habit(emoji: emoji, name: name, color: color, streak: 0, doneToday: false,
                            week: [false, false, false, false, false, false, false]))
    }
}
