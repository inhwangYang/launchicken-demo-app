import SwiftUI

struct StatsView: View {
    @EnvironmentObject private var store: HabitStore

    private let weekdayLabels = ["월", "화", "수", "목", "금", "토", "일"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    HStack(spacing: 12) {
                        StatCard(title: "오늘 달성률",
                                 value: "\(Int(store.completionRate * 100))%",
                                 icon: "target", color: .teal)
                        StatCard(title: "최고 연속",
                                 value: "\(store.bestStreak)일",
                                 icon: "flame.fill", color: .orange)
                    }
                    weeklyChart
                    habitBreakdown
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("통계")
        }
    }

    private var dailyCounts: [Int] {
        (0..<7).map { day in store.habits.filter { $0.week[day] }.count }
    }

    private var weeklyChart: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("최근 7일")
                .font(.headline)
            HStack(alignment: .bottom, spacing: 12) {
                ForEach(Array(dailyCounts.enumerated()), id: \.offset) { index, count in
                    VStack(spacing: 8) {
                        Capsule()
                            .fill(index == 6 ? Color.teal : Color.teal.opacity(0.35))
                            .frame(height: max(CGFloat(count) / CGFloat(max(store.habits.count, 1)) * 120, 8))
                        Text(weekdayLabels[index])
                            .font(.caption2.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 150, alignment: .bottom)
        }
        .padding(18)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 20))
    }

    private var habitBreakdown: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("습관별 달성")
                .font(.headline)
            ForEach(store.habits) { habit in
                HStack(spacing: 12) {
                    Text(habit.emoji)
                    Text(habit.name)
                        .font(.subheadline.weight(.medium))
                        .lineLimit(1)
                    Spacer()
                    HStack(spacing: 4) {
                        ForEach(Array(habit.week.enumerated()), id: \.offset) { _, done in
                            Circle()
                                .fill(done ? habit.color : Color(.systemGray5))
                                .frame(width: 10, height: 10)
                        }
                    }
                }
            }
        }
        .padding(18)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 20))
    }
}

private struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(title, systemImage: icon)
                .font(.caption.weight(.semibold))
                .foregroundStyle(color)
            Text(value)
                .font(.system(size: 32, weight: .heavy, design: .rounded))
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 20))
    }
}

