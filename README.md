# 7.3_Terraform_Aleksandr_Molokov

## Задача 1. Создадим бэкэнд в S3 (необязательно, но крайне желательно).

Если в рамках предыдущего задания у вас уже есть аккаунт AWS, то давайте продолжим знакомство со взаимодействием
терраформа и aws. 

1. Создайте s3 бакет, iam роль и пользователя от которого будет работать терраформ. Можно создать отдельного пользователя,
а можно использовать созданного в рамках предыдущего задания, просто добавьте ему необходимы права, как описано 
[здесь](https://www.terraform.io/docs/backends/types/s3.html).
1. Зарегистрируйте бэкэнд в терраформ проекте как описано по ссылке выше. 


## ОТВЕТ

Создание в yandex-cloud через terraform

main.tf

![main tf](https://user-images.githubusercontent.com/109212419/210434234-832f942b-2a5a-451f-99d0-9c3add3de70c.jpg)

terraform apply

![1 задание](https://user-images.githubusercontent.com/109212419/210434281-6621858c-1245-42e6-9f81-5a10aaf651c1.jpg)


## Задача 2. Инициализируем проект и создаем воркспейсы. 

1. Выполните `terraform init`:
    * если был создан бэкэнд в S3, то терраформ создат файл стейтов в S3 и запись в таблице 
dynamodb.
    * иначе будет создан локальный файл со стейтами.  
1. Создайте два воркспейса `stage` и `prod`.
1. В уже созданный `aws_instance` добавьте зависимость типа инстанса от вокспейса, что бы в разных ворскспейсах 
использовались разные `instance_type`.
1. Добавим `count`. Для `stage` должен создаться один экземпляр `ec2`, а для `prod` два. 
1. Создайте рядом еще один `aws_instance`, но теперь определите их количество при помощи `for_each`, а не `count`.
1. Что бы при изменении типа инстанса не возникло ситуации, когда не будет ни одного инстанса добавьте параметр
жизненного цикла `create_before_destroy = true` в один из рессурсов `aws_instance`.
1. При желании поэкспериментируйте с другими параметрами и рессурсами.

В виде результата работы пришлите:
* Вывод команды `terraform workspace list`.
* Вывод команды `terraform plan` для воркспейса `prod`.  


## ОТВЕТ

 # 1. Создайте два воркспейса `stage` и `prod`.

sudo terraform workspace new prod
sudo terraform workspace new stage
sudo terraform workspace list

![Задание 2 1 создание workspace](https://user-images.githubusercontent.com/109212419/210753005-7d1958d3-3042-4221-ba07-3e7bb7a8e207.jpg)

 # Добавление зависимостей и count

 # S3.tf

![s3 tf count](https://user-images.githubusercontent.com/109212419/210761465-491843aa-7123-444a-89ea-cf44a503957d.jpg)

 terraform plan (workspace prod)

![terraform plan после создания инстанса](https://user-images.githubusercontent.com/109212419/210761669-3084ec0f-f149-47df-abf8-a0eeb07fc89b.jpg)

 S3.tf после добавлен еще один instance с for_each, а также добавлен параметр create_before_destroy = true в первый instance

https://github.com/ALEMOLOKOV/7.3_Terraform_Aleksandr_Molokov/blob/965e658592a848a835d7c8e1c6c998cf3e5ef2ce/s3.tf

# terraform plan (workspace prod)

![2 terraform plan final 1](https://user-images.githubusercontent.com/109212419/210767364-91550b5d-cbf4-456a-ae06-328fd470c0e6.jpg)

![2 terraform plan final 2](https://user-images.githubusercontent.com/109212419/210767407-5ba632ab-3f8f-4492-8290-f60d12a4981b.jpg)




