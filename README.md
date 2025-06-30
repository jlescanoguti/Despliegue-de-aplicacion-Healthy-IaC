**Integrantes**

- Lescano Gutierrez, Jaime Rafael.
- Alcalde Lavado, Matias Felipe
- Carranza Jacinto, Juan Diego
- Rodriguez Ruiz, Rider Pier
- Aguilar Idrogo, Clever Josue

**Descripción del proyecto**

Healthy es una aplicación web de bienestar físico y emocional que permite a los usuarios personalizar hábitos saludables, establecer metas y visualizar su progreso dentro de planes integrales. La arquitectura serverless en AWS garantiza escalabilidad, seguridad y bajo mantenimiento. Utiliza autenticación con Cognito, almacenamiento en S3, procesamiento con Lambda y una base de datos relacional en PostgreSQL.


**Herramientas IaC**

- Amazon S3: Definición de buckets para almacenamiento de archivos estáticos y recursos de la aplicación.
- Amazon Cognito: Configuración de User Pools para autenticación y gestión de usuarios.
- AWS Lambda: Despliegue de funciones para lógica de negocio y acceso a base de datos.
- API Gateway: Creación y configuración de endpoints para exponer la API de la aplicación.
- Amazon RDS (PostgreSQL): Provisión de la base de datos relacional para almacenamiento persistente.
- CloudWatch: Configuración de logs y métricas para monitoreo del sistema.

## Objetivos

## Tecnologías y Herramientas

* **Terraform** (IaC)
* **AWS** (VPC, EKS, Aurora, S3, ALB, IAM)
* **Spring Boot** (Backend)
* **Docker & Amazon ECR** (Contenedores)
* **GitHub Actions** (CI/CD)
* **Git & GitHub** (Control de versiones)

## Requisitos Previos

* Cuenta AWS con **Access Key ID** y **Secret Access Key** configurados.
* Terraform ≥ 1.0 instalado.
* Docker instalado.
* Repositorio GitHub con permisos para configurar Actions y Secrets.

---

## Instalación y Configuración

1. Clona el repositorio:

   ```bash
link
   https://github.com/jlescanoguti/Despliegue-de-aplicacion-Healthy-IaC.git
   ```


## Despliegue

### 1. Terraform

```bash
terraform init
terraform plan 
terraform apply
terraform destroy
```



## Buenas Prácticas

* Revisa siempre el plan de Terraform antes de aplicar (`terraform plan`).
* Guarda credenciales y tokens en GitHub Secrets.
* Aplica principios de mínimo privilegio en IAM.
* Versiona cada cambio en Terraform y Docker.

---


## Contribuciones

1. Haz fork del repositorio.
2. Crea una rama de feature: `git checkout -b feature/mi-cambio`.
3. Realiza tus cambios y haz commit: `git commit -m "feat: descripción"`.
4. Sube la rama: `git push origin feature/mi-cambio`.
5. Abre un Pull Request describiendo los cambios.

---