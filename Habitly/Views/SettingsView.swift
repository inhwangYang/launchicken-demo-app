import SwiftUI

struct SettingsView: View {
    @State private var notificationsOn = true
    @State private var reminderTime = Calendar.current.date(from: DateComponents(hour: 21, minute: 0)) ?? .now
    @State private var weekStartsMonday = true
    @State private var iCloudSync = true

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 14) {
                        Text("🐥")
                            .font(.largeTitle)
                            .frame(width: 56, height: 56)
                            .background(Color.teal.opacity(0.15), in: Circle())
                        VStack(alignment: .leading, spacing: 2) {
                            Text("습관 만드는 중")
                                .font(.headline)
                            Text("21일째 함께하고 있어요")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
                Section("알림") {
                    Toggle("매일 리마인더", isOn: $notificationsOn)
                    DatePicker("알림 시간", selection: $reminderTime, displayedComponents: .hourAndMinute)
                        .disabled(!notificationsOn)
                }
                Section("일반") {
                    Toggle("월요일부터 시작", isOn: $weekStartsMonday)
                    Toggle("iCloud 동기화", isOn: $iCloudSync)
                }
                Section("정보") {
                    LabeledContent("버전", value: "1.0.0")
                    Link("피드백 보내기", destination: URL(string: "https://example.com")!)
                }
            }
            .navigationTitle("설정")
        }
    }
}

