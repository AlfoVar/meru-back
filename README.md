# API MERU

Prueba Tecnica MERU

## Requisitos previos

Antes de comenzar, asegúrate de tener los siguientes elementos instalados en tu sistema:

- **Ruby**: versión `3.0.6`
- **Rails**: versión `~> 6.1.7', '>= 6.1.7.8'`
- **Base de datos**: (SQLite 3)

## Instalación

Sigue estos pasos para configurar y ejecutar la aplicación en tu entorno local.

1. **Clona el repositorio:**

   ```bash
   git clone https://github.com/AlfoVar/meru-back.git

   ```

2. **Instala las dependencias:**

   Ejecuta el siguiente comando para instalar las gemas necesarias:

   ```bash
   bundle install

   ```

3. **Configura la base de datos:**

   Crea y migra la base de datos:

   ```bash
   rails db:create
   rails db:migrate
   ```

## Ejecutar la aplicación

    Para levantar la aplicación localmente, sigue estos pasos:

1. **Iniciar el servidor Rails:**

   ```bash

   rails server

   ```

2. **Pruebas**

   Si deseas ejecutar las pruebas, puedes hacerlo con el siguiente comando:

   ```bash

   rspec
   ```

## Endpoints

    Aquí estan listados los endpoints para el CRUD de Productos

- 
- **POST /users/sing_in:**
    : Logueo de usuario para generacion de token
- **DELETE /Logout**
: eliminación del token de autenticación.
  Es necesario un token previamente generado.


  Aquí están listados los endpoints para el CRUD de Productos.

- **GET /api/products: Obtiene una lista de productos.**
- **POST /api/products: Crea un nuevo producto.**
- **GET /api/products/id**
  : Obtiene los detalles de un producto específico.
- **GET /api/products/**
  : Obtiene los detalles de todos los productos.
- **PUT /api/products/id**
  : Actualiza un producto existente.
- **DELETE /api/products/id**
  : Elimina un producto.

**Tener presente que en las peticiones deben tener el token de autorización**

