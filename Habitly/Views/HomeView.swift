import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: HabitStore
    @State private var showingNewHabit = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    summaryCard
                    VStack(spacing: 12) {
                        ForEach(store.habits) { habit in
                            HabitRow(habit: habit) { store.toggle(habit) }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("오늘의 습관")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingNewHabit = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingNewHabit) {
                NewHabitView()
            }
        }
    }

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(Date.now.formatted(.dateTime.locale(.init(identifier: "ko_KR")).month(.wide).day().weekday(.wide)))
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.85))
            HStack(alignment: .lastTextBaseline, spacing: 6) {
                Text("\(store.completedToday)")
                    .font(.system(size: 44, weight: .heavy, design: .rounded))
                Text("/ \(store.habits.count)개 완료")
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.85))
            }
            .foregroundStyle(.white)
            ProgressView(value: store.completionRate)
                .tint(.white)
                .scaleEffect(y: 1.6)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(colors: [.teal, .blue], startPoint: .topLeading, endPoint: .bottomTrailing),
            in: RoundedRectangle(cornerRadius: 24, style: .continuous)
        )
    }
}

private struct HabitRow: View {
    let habit: Habit
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            Text(habit.emoji)
                .font(.title2)
                .frame(width: 48, height: 48)
                .background(habit.color.opacity(0.15), in: RoundedRectangle(cornerRadius: 14))
            VStack(alignment: .leading, spacing: 4) {
                Text(habit.name)
                    .font(.body.weight(.semibold))
                Label("\(habit.streak)일 연속", systemImage: "flame.fill")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(habit.color)
            }
            Spacer()
            Button(action: onToggle) {
                Image(systemName: habit.doneToday ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 30))
                    .foregroundStyle(habit.doneToday ? habit.color : Color(.systemGray4))
            }
            .buttonStyle(.plain)
        }
        .padding(14)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 18))
    }
}

