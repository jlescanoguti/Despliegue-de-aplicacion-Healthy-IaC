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

**Estructura del Proyecto**
'''markdown

raíz del proyecto/
└── HealthyIAC/
    ├── apigateway.tf
    ├── cloudfront.tf
    ├── cloudwatch.tf
    ├── cognito.tf
    ├── database.tf
    ├── ec2.txt
    ├── iam.tf
    ├── index.js
    ├── lambda.tf
    ├── lambda_function_payload.zip
    ├── main.tf
    ├── outputs.tf
    ├── s3.tf
    ├── terraform.tfstate
    ├── variables.tf
    ├── vpc.tf
    ├── .gitignore
    ├── FlujoInicioSesión-Simulación.txt
    └── README.md 
└── Frontend/
└── Backend/