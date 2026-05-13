#include <stdio.h>
#include <stdlib.h>

// Функции для управления VPN
void start_vpn() {
    printf("\n[+] Запуск Katya VPN...\n");
    // Здесь будет вызов системной команды, например: system("systemctl start xray");
    printf("[ОК] VPN успешно запущен.\n");
}

void stop_vpn() {
    printf("\n[-] Остановка Katya VPN...\n");
    // Здесь будет вызов системной команды, например: system("systemctl stop xray");
    printf("[ОК] VPN остановлен.\n");
}

void show_status() {
    printf("\n[i] Статус Katya VPN:\n");
    printf("---------------------------\n");
    printf("Протокол: VLESS-XTLS\n");
    printf("Сервер:  Активен (127.0.0.1)\n");
    printf("Пинг:    42 мс\n");
    printf("---------------------------\n");
}

void show_menu() {
    printf("\n=== KATYA VPN MENU ===\n");
    printf("1. Запустить VPN\n");
    printf("2. Остановить VPN\n");
    printf("3. Проверить статус\n");
    printf("4. Выйти\n");
    printf("======================\n");
    printf("Выберите действие: ");
}

int main() {
    int choice;

    // Бесконечный цикл меню, пока пользователь не выберет выход
    while(1) {
        show_menu();
        
        // Валидация ввода пользователя
        if (scanf("%d", &choice) != 1) {
            printf("\n[Ошибка] Пожалуйста, введите число.\n");
            while(getchar() != '\n'); // Очистка буфера ввода
            continue;
        }

        switch(choice) {
            case 1:
                start_vpn();
                break;
            case 2:
                stop_vpn();
                break;
            case 3:
                show_status();
                break;
            case 4:
                printf("\nВыход из Katya VPN. До свидания!\n");
                return 0;
            default:
                printf("\n[Ошибка] Неверный пункт меню. Попробуйте снова.\n");
        }
    }
    return 0;
}
