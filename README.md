# Diplom
В качестве backend использовали Terraform. 
https://app.terraform.io/app/Bobr/workspaces/stage/runs/run-2Srv22KGf6ipwhgc

1. Образ тестового приложения на docker.hub: https://hub.docker.com/repository/docker/acdcb/diploma
2. Конфигурационные файлы Terraform для установки EKS кластера на EC2: https://github.com/BobrACDC/Diplom/tree/main/EC2%2BEKS
3. Конфигурационные файлы для приложения: https://github.com/BobrACDC/Diplom/tree/main/kub_config
4. Конфигурационные файлы Jenkins: https://github.com/BobrACDC/Diplom/tree/main/Jenkins

Установка EKS: https://www.youtube.com/watch?v=QThadS3Soig
Установка мониторинга: https://www.eksworkshop.com/intermediate/240_monitoring/
Установка Jenkins: https://www.youtube.com/watch?v=eqOCdNO2Nmk, https://otokarev.com/2016/07/16/avtosborka-docker-obrazov-na-kolenke-git-jenkins-docker-registry/#Post-build_Actions


Terraform:
![terraform](https://user-images.githubusercontent.com/54946404/141133644-ed619640-39e2-4c58-b4f3-8bba7dc50111.png)


Запущенное приложение:

![Test_app](https://user-images.githubusercontent.com/54946404/141132760-0abb5503-642c-451c-93b6-f9fa6807ea6d.png)


Мониторинг kubernetes кластера: 
![Prometheus](https://user-images.githubusercontent.com/54946404/141132844-0de9d860-bdba-4bb2-b22a-d5f123e2ea5d.png)


Jenkins:
![Jenkins](https://user-images.githubusercontent.com/54946404/141132876-36628a03-b7d4-43d0-a6c6-2e96b032c046.png)

