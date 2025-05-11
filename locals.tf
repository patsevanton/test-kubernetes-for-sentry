# Получаем информацию о конфигурации клиента Yandex
data "yandex_client_config" "client" {}

# Генерация случайного пароля для администратора Sentry
resource "random_password" "sentry_admin_password" {
  length      = 20            # Длина пароля 20 символов
  special     = false          # Без специальных символов
  min_numeric = 4             # Минимум 4 цифры в пароле
  min_upper   = 4             # Минимум 4 заглавные буквы в пароле
}

# Локальные переменные для настройки инфраструктуры
locals {
  folder_id           = data.yandex_client_config.client.folder_id  # ID папки в Yandex Cloud
  sentry_admin_password = random_password.sentry_admin_password.result # Сгенерированный пароль администратора Sentry
}
