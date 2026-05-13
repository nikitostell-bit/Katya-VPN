import SwiftUI

struct ContentView: View {
    // Состояния приложения
    @State private var isRussian: Bool = true
    @State private var isVpnActive: Bool = false
    @State private var aiQuestion: String = ""
    @State private var aiResponse: String = ""
    @State private var meteorDistance: String = ""
    @State private var meteorStatus: String = ""
    @State private var meteorColor: Color = .gray

    // Словари локализации (RU / EN)
    private var tTitle: String { isRussian ? "ПАНЕЛЬ KATYA VPN" : "KATYA VPN PANEL" }
    private var tStart: String { isRussian ? "Запустить VPN" : "Start VPN" }
    private var tStop: String { isRussian ? "Остановить VPN" : "Stop VPN" }
    private var tStatusActive: String { isRussian ? "Статус: VLESS-Reality (Активен)" : "Status: VLESS-Reality (Active)" }
    private var tStatusInactive: String { isRussian ? "Статус: Отключен" : "Status: Disconnected" }
    private var tSupport: String { isRussian ? "ТГ Поддержка: @KatyaVPN_Support" : "TG Support: @KatyaVPN_Support" }
    private var tMeteorBtn: String { isRussian ? "Проверить метеорит" : "Check Meteor" }
    private var tAiPlaceholder: String { isRussian ? "Задать вопрос ИИ Corpilot..." : "Ask Corpilot AI..." }
    private var tMeteorPlaceholder: String { isRussian ? "Дистанция до Земли (км)" : "Distance to Earth (km)" }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 1. Выбор языка (Вверху экрана)
                HStack {
                    Spacer()
                    Button(action: { isRussian.toggle() }) {
                        Text(isRussian ? "English" : "Русский")
                            .font(.system(size: 14, weight: .bold))
                            .padding(8)
                            .background(Color.secondary.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)

                Text(tTitle)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)

                // 2. Блок управления VPN
                VStack(spacing: 10) {
                    Button(action: { isVpnActive.toggle() }) {
                        Text(isVpnActive ? tStop : tStart)
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(isVpnActive ? Color.red : Color.green)
                            .cornerRadius(10)
                    }
                    
                    Text(isVpnActive ? tStatusActive : tStatusInactive)
                        .font(.subheadline)
                        .foregroundColor(isVpnActive ? .green : .secondary)
                }
                .padding(.horizontal)

                Divider()

                // 3. Интеграция ИИ Corpilot
                VStack(alignment: .leading, spacing: 10) {
                    Text("🤖 Corpilot AI")
                        .font(.headline)
                    
                    TextField(tAiPlaceholder, text: $aiQuestion)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        let query = aiQuestion.lowercased()
                        if query.contains("скорость") || query.contains("speed") {
                            aiResponse = isRussian ? "Corpilot: Проверьте пинг до сервера." : "Corpilot: Check server ping."
                        } else if query.contains("безопасность") || query.contains("secure") {
                            aiResponse = isRussian ? "Corpilot: Трафик зашифрован через Reality." : "Corpilot: Traffic is encrypted via Reality."
                        } else {
                            aiResponse = isRussian ? "Corpilot: Рекомендую использовать протокол VLESS." : "Corpilot: VLESS protocol recommended."
                        }
                    }) {
                        Text(isRussian ? "Спросить" : "Ask")
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    
                    if !aiResponse.isEmpty {
                        Text(aiResponse)
                            .font(.callout)
                            .foregroundColor(.blue)
                            .padding(8)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(6)
                    }
                }
                .padding(.horizontal)

                Divider()

                // 4. Трэкер метеоритов (Конец света)
                VStack(alignment: .leading, spacing: 10) {
                    Text("☄️ Мониторинг угроз (Апокалипсис)")
                        .font(.headline)
                    
                    TextField(tMeteorPlaceholder, text: $meteorDistance)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        guard let dist = Int64(meteorDistance) else { return }
                        if dist > 10000 {
                            meteorStatus = isRussian ? "ЗЕЛЕНЫЙ (ВСЕ ХОРОШО)" : "GREEN (GOOD)"
                            meteorColor = .green
                        } else if dist >= 2000 {
                            meteorStatus = isRussian ? "ЖЕЛТЫЙ (УЖЕ ПЛОХО)" : "YELLOW (BAD)"
                            meteorColor = .orange
                        } else {
                            meteorStatus = isRussian ? "КРАСНЫЙ (ОЧЕНЬ ПЛОХО / БУНКЕР)" : "RED (CRITICAL)"
                            meteorColor = .red
                        }
                    }) {
                        Text(tMeteorBtn)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color.purple)
                            .cornerRadius(8)
                    }
                    
                    if !meteorStatus.isEmpty {
                        Text(meteorStatus)
                            .font(.headline)
                            .foregroundColor(meteorColor)
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .background(meteorColor.opacity(0.1))
                            .cornerRadius(6)
                    }
                }
                .padding(.horizontal)

                Spacer()

                // 5. Модуль поддержки (Внизу экрана)
                Text(tSupport)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
            }
        }
    }
}

// Конструктор превью для отладки в Xcode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
