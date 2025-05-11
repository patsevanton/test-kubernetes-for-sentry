# **Запускаем Sentry в Kubernetes в Яндекс облаке**

Запускаем инфраструктуру:

```shell
export YC_FOLDER_ID='ваш folder'
terraform init
terraform apply
```

Формируем kubeconfig для кластера k8s с указанным ID (идентификатор_кластера) в Yandex Cloud, используя внешний IP (--external)
```shell
yc managed-kubernetes cluster get-credentials --id идентификатор_кластера --external --force
```

Проверяем сгенерированный конфиг values_sentry.yaml из шаблона

## Деплоим Sentry в кластер через Helm
```shell
kubectl create namespace test
helm repo add sentry https://sentry-kubernetes.github.io/charts
helm repo update
helm upgrade --install sentry -n test sentry/sentry --version 26.17.0 --wait --timeout=1000s -f values_sentry.yaml
```

## Пароли
Пароли генерируются динамически, но вы можете указать свои пароль в local.tf
Их можно получить посмотрев values_sentry.yaml или используя terraform output

## Установка victoria-metrics-k8s-stack

Добавим Helm репозиторий и установим VictoriaMetrics stack:

```bash
helm repo add vm https://victoriametrics.github.io/helm-charts/
helm repo update

helm upgrade --install vmks vm/victoria-metrics-k8s-stack \
  --namespace vmks --create-namespace \
  --values vmks-values.yaml
```

## Простой пример отправки exception
- Создаем проект в Sentry, выбираем python, копируем DSN
- Заходим в директорию `example-python`
- Меняем dsn в main.py (Сам DSN лучше хранить в секретах (либо брать из env))
- Запускаем python код
```shell
cd example-python
python3 -m venv venv
source venv/bin/activate
pip install --upgrade sentry-sdk
python3 main.py
```
