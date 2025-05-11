# Ресурс null_resource используется для выполнения локальной команды,
# генерирующей файл конфигурации Sentry на основе шаблона
resource "null_resource" "write_sentry_config" {
  provisioner "local-exec" {
    # Команда записывает сгенерированную строку (YAML) в файл values_sentry.yaml
    command = "echo '${local.sentry_config}' > values_sentry.yaml"
  }

  triggers = {
    # Триггер перезапуска ресурса при изменении содержимого values_sentry.yaml.tpl
    sentry_config = local.sentry_config
  }
}

locals {
  # Локальная переменная с конфигурацией Sentry, генерируемая из шаблона values_sentry.yaml.tpl
  sentry_config = templatefile("values_sentry.yaml.tpl", {
    # Пароль администратора Sentry
    sentry_admin_password  = local.sentry_admin_password

    # Email пользователя-администратора
    user_email     = "admin@sentry.apatsev.org.ru"

    # URL системы Sentry
    # В этом коде не стал делать переменные чтобы не усложнять код
    system_url     = "http://sentry.apatsev.org.ru" # TODO в след посте использовать переменную

    # Включение/отключение Nginx
    nginx_enabled  = false

    # Использование Ingress для доступа к Sentry
    ingress_enabled = true

    # Имя хоста, используемого Ingress
    # В этом коде не стал делать переменные чтобы не усложнять код
    ingress_hostname = "sentry.apatsev.org.ru" # TODO в след посте использовать переменную

    # Имя класса Ingress-контроллера
    ingress_class_name = "nginx"

    # Стиль регулярных путей в Ingress
    ingress_regex_path_style = "nginx"

    # Аннотации Ingress для настройки nginx
    ingress_annotations = {
      proxy_body_size = "200m"          # Максимальный размер тела запроса
      proxy_buffers_number = "16"       # Количество буферов
      proxy_buffer_size = "32k"         # Размер каждого буфера
    }
  })
}
