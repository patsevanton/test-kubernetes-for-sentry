# Пользовательская конфигурация для Sentry
user:
  password: "${sentry_admin_password}"  # Пароль администратора Sentry
  email: "${user_email}"                # Email администратора

# Системная информация
system:
  url: "${system_url}"  # URL-адрес системы

# Настройка NGINX
nginx:
  enabled: ${nginx_enabled}  # Включен ли встроенный NGINX

# Настройка ingress-контроллера
ingress:
  enabled: ${ingress_enabled}                     # Включение ingress
  hostname: "${ingress_hostname}"                 # Хостнейм для доступа
  ingressClassName: "${ingress_class_name}"       # Класс ingress-контроллера
  regexPathStyle: "${ingress_regex_path_style}"   # Использование регулярных выражений в путях
  annotations:
    nginx.ingress.kubernetes.io/proxy-body-size: "${ingress_annotations.proxy_body_size}"  # Максимальный размер тела запроса
    nginx.ingress.kubernetes.io/proxy-buffers-number: "${ingress_annotations.proxy_buffers_number}"  # Количество буферов
    nginx.ingress.kubernetes.io/proxy-buffer-size: "${ingress_annotations.proxy_buffer_size}"        # Размер буфера
