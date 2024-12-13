# ops-terragrunt

Este repositorio está diseñado para ser gestionado por los operadores del proyecto (**Telefonica**) y permite crear recursos de AWS mediante infraestructura como código (IaC) utilizando **Terragrunt**.

## Descripción de carpetas principales

- **`accounts`**: Contiene las configuraciones específicas por cuenta y usuario:
  - **`ops`**: Configuraciones relacionadas con operaciones generales.
  - **`telefonica`**: Configuraciones específicas para usuarios de Telefónica.
  - **`uma`**: Configuraciones específicas para usuarios de UMA, organizadas por persona.

- **`globals`**: Contiene configuraciones globales reutilizables para todos los proyectos, como:
  - **`provider.tf`**: Configuración del proveedor de AWS.
  - **`variables.tf`**: Definición de variables globales.
  - **`versions.tf`**: Especificaciones de versiones de Terraform.

- **`terragrunt.hcl`**: Archivo principal de configuración global de Terragrunt.


## Cómo usar el repositorio

Sigue estos pasos para trabajar con los archivos de configuración:

1. Ve a la carpeta correspondiente al usuario o recurso que deseas gestionar. Por ejemplo:
   ```bash
   $ cd accounts/uma/francisco-zafra/iam-user
   ```
2. Configura las variables de entorno necesarias:
   ```bash
   $ export ACCOUNT=uma
   $ export OWNER=francisco-zafra
   $ export AWS_REGION=eu-west-3
   ```
3. Ejecuta Terragrunt para realizar un plan de los cambios:
   ```bash
   $ terragrunt run-all plan --terragrunt-source-update
   ```
4. Si el plan es correcto, aplica los cambios (opcional, según permisos):
   ```bash
   $ terragrunt run-all apply --terragrunt-source-update
   ```

## Licencia

Este projecto es licenciado bajo [Apache](LICENSE)