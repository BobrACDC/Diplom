## Мониторинг

Установка Prometheus+Grafana производилась с помощью helm. 

#### добавление репозиториев Prometheus и Grafana
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo add grafana https://grafana.github.io/helm-charts


#### создание namespace и установка Prometheus

kubectl create namespace prometheus

helm install prometheus prometheus-community/prometheus \
    --namespace prometheus


#### создание namespace и установка Grafana

kubectl create namespace grafana

helm install grafana grafana/grafana \
    --namespace grafana \
    --values grafana.yaml \
    --set service.type=LoadBalancer


#### проверка созданных сущностей

kubectl get all -n prometheus
kubectl get all -n grafana


#### внешний адрес grafana 

export ELB=$(kubectl get svc -n grafana grafana -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "http://$ELB"

#### пароль (логин по умолчанию admin)

kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

    


#### alertmanager
Конфигурация alertmanager для отправки email представлена в файле alertmanager.yaml

