
# Task Manager

### Descripción
**Task Manager** es una aplicación desarrollada en Flutter que permite a los usuarios gestionar sus tareas de manera sencilla. Con esta app, puedes agregar tareas a una lista, eliminarlas, marcarlas como completadas y filtrarlas según su estado. Es una herramienta perfecta para organizar actividades y mejorar la productividad.

### Características
- **Agregar Tareas**: Permite al usuario crear nuevas tareas con una descripción o título.
- **Eliminar Tareas**: Elimina las tareas de la lista de manera sencilla.
- **Marcar como Completada**: Cambia el estado de las tareas a completadas para distinguirlas de las pendientes.
- **Filtrar Tareas**: Filtra la lista de tareas por estado (completadas o pendientes).

### Tecnologías Utilizadas
- **Flutter**: v3.24.4
- **Dart**: v3.5.4
- **BloC**: Usado como manejador de estado para gestionar la lógica de la app.
- **SQFLite**: Base de datos local para almacenar las tareas de manera persistente en el dispositivo.

### Requisitos Previos
Asegúrate de tener instaladas las siguientes dependencias para ejecutar **Task Manager**:

- **Flutter**: v3.24.4
- **Dart**: v3.5.4
- **Dispositivo o emulador compatible con Flutter** para probar la aplicación.

### Instalación
Sigue estos pasos para clonar, instalar y ejecutar la aplicación en tu entorno local.

1. Clona el repositorio:
   ```bash
   git clone https://github.com/Francisperalta05/Task_Manager.git
   cd Task_Manager
   ```

2. Instala las dependencias de Flutter:
   ```bash
   flutter pub get
   ```
   
3. Configura un dispositivo emulador o conecta un dispositivo físico compatible con Flutter.

### Uso
Para ejecutar el proyecto en tu dispositivo o emulador, usa el siguiente comando:

```bash
flutter run
```

Una vez que la aplicación esté en funcionamiento, podrás:
1. **Agregar Tareas**: Escribe el nombre de una tarea y presiona "Agregar" para incluirla en la lista.
2. **Marcar como Completada**: Haz clic en la tarea para marcarla como completada y hacer un seguimiento.
3. **Eliminar Tareas**: Selecciona el ícono de eliminación junto a la tarea que quieres borrar.
4. **Filtrar Tareas**: Usa los filtros disponibles para ver solo tareas completadas o pendientes.

### Configuración Opcional
Si deseas modificar la configuración de la base de datos local (SQFLite) o la lógica de estado (BloC), puedes personalizar la configuración en los archivos correspondientes dentro de la estructura de proyecto.

### Contribuciones
Si deseas contribuir al desarrollo de **Task Manager**, sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una nueva rama con la funcionalidad o mejora que quieras aportar:
   ```bash
   git checkout -b nombre-de-tu-rama
   ```
3. Realiza los cambios necesarios y haz commit de tus modificaciones:
   ```bash
   git commit -m "Descripción de la mejora"
   ```
4. Sube tus cambios a tu fork:
   ```bash
   git push origin nombre-de-tu-rama
   ```
5. Abre un Pull Request en el repositorio original y describe tus cambios.

### Contacto
Para dudas, sugerencias o reportar problemas, puedes contactar a:
- **Nombre**: Angel Peralta
- **Correo electrónico**: francisperalta05@gmail.com
- **LinkedIn**: [https://www.linkedin.com/in/angelperalt4/](https://www.linkedin.com/in/angelperalt4/)