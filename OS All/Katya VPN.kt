package com.katyavpn

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            KatyaVpnApp()
        }
    }
}

@Composable
fun KatyaVpnApp() {
    // Состояния интерфейса
    var isRussian by remember { mutableStateOf(true) }
    var isVpnActive by remember { mutableStateOf(false) }
    var aiLog by remember { mutableStateOf("") }
    var aiQuestion by remember { mutableStateOf("") }
    var meteorDistance by remember { mutableStateOf("") }
    var meteorStatus by remember { mutableStateOf("") }
    var meteorColor by remember { mutableStateOf(Color.Gray) }

    // Локализация текстов
    val tTitle = if (isRussian) "ПАНЕЛЬ KATYA VPN" else "KATYA VPN PANEL"
    val tStart = if (isRussian) "Запустить VPN" else "Start VPN"
    val tStop = if (isRussian) "Остановить VPN" else "Stop VPN"
    val tStatus = if (isRussian) "Статус: VLESS-Reality (Активен)" else "Status: VLESS-Reality (Active)"
    val tSupport = if (isRussian) "ТГ Поддержка: @KatyaVPN_Support" else "TG Support: @KatyaVPN_Support"
    val tMeteorBtn = if (isRussian) "Проверить метеорит" else "Check Meteor"

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        // Переключатель языка
        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.End) {
            Button(onClick = { isRussian = !isRussian }) {
                Text(if (isRussian) "English" else "Русский")
            }
        }

        Text(text = tTitle, fontSize = 24.sp, modifier = Modifier.padding(vertical = 16.dp))

        // Кнопка Управления VPN
        Button(
            onClick = { isVpnActive = !isVpnActive },
            colors = ButtonDefaults.buttonColors(containerColor = if (isVpnActive) Color.Red else Color.Green),
            modifier = Modifier.fillMaxWidth().height(50.dp)
        ) {
            Text(if (isVpnActive) tStop else tStart, color = Color.White)
        }

        if (isVpnActive) {
            Text(text = tStatus, color = Color.Green, modifier = Modifier.padding(8.dp))
        }

        Spacer(modifier = Modifier.height(16.dp))
        Divider()

        // Блок ИИ Corpilot
        Text("🤖 Corpilot AI", fontSize = 18.sp, modifier = Modifier.padding(vertical = 8.dp))
        OutlinedTextField(
            value = aiQuestion,
            onValueChange = { aiQuestion = it },
            label = { Text(if (isRussian) "Задать вопрос ИИ" else "Ask AI") },
            modifier = Modifier.fillMaxWidth()
        )
        Button(
            onClick = {
                aiLog = when {
                    aiQuestion.contains("скорость", ignoreCase = true) || aiQuestion.contains("speed", ignoreCase = true) ->
                        if (isRussian) "Corpilot: Проверьте пинг до сервера." else "Corpilot: Check server ping."
                    aiQuestion.contains("безопасность", ignoreCase = true) || aiQuestion.contains("secure", ignoreCase = true) ->
                        if (isRussian) "Corpilot: Трафик зашифрован через Reality." else "Corpilot: Traffic is encrypted via Reality."
                    else -> if (isRussian) "Corpilot: Рекомендую протокол VLESS." else "Corpilot: VLESS protocol recommended."
                }
            },
            modifier = Modifier.padding(top = 8.dp)
        ) {
            Text(if (isRussian) "Спросить" else "Ask")
        }
        if (aiLog.isNotEmpty()) {
            Text(aiLog, modifier = Modifier.padding(8.dp), color = Color.Blue)
        }

        Spacer(modifier = Modifier.height(16.dp))
        Divider()

        // Мониторинг метеоритов (Конец света)
        Text("☄️ Мониторинг угроз", fontSize = 18.sp, modifier = Modifier.padding(vertical = 8.dp))
        OutlinedTextField(
            value = meteorDistance,
            onValueChange = { meteorDistance = it },
            label = { Text(if (isRussian) "Дистанция (км)" else "Distance (km)") },
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
            modifier = Modifier.fillMaxWidth()
        )
        Button(
            onClick = {
                val dist = meteorDistance.toLongOrNull() ?: 0L
                if (dist > 10000) {
                    meteorStatus = if (isRussian) "ЗЕЛЕНЫЙ (ХОРОШО)" else "GREEN (GOOD)"
                    meteorColor = Color.Green
                } else if (dist in 2000..10000) {
                    meteorStatus = if (isRussian) "ЖЕЛТЫЙ (ПЛОХО)" else "YELLOW (BAD)"
                    meteorColor = Color.Yellow
                } else {
                    meteorStatus = if (isRussian) "КРАСНЫЙ (ОЧЕНЬ ПЛОХО)" else "RED (VERY BAD)"
                    meteorColor = Color.Red
                }
            },
            modifier = Modifier.padding(top = 8.dp)
        ) {
            Text(tMeteorBtn)
        }
        if (meteorStatus.isNotEmpty()) {
            Text(meteorStatus, color = meteorColor, fontSize = 16.sp, modifier = Modifier.padding(8.dp))
        }

        Spacer(modifier = Modifier.weight(1f))

        // Блок Техподдержки в самом низу
        Text(tSupport, color = Color.Gray, fontSize = 14.sp)
    }
}
