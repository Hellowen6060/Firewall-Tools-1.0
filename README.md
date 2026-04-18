# Gestión de Firewall desde PowerShell 1.0

![Menú del script](Captura de pantalla 2026-04-17 222245)


Este proyecto contiene un script en PowerShell que permite gestionar reglas de bloqueo de programas (`.exe`) en el Firewall de Windows de forma sencilla y automatizada.

## ✨ Características principales
- Autoelevación: el script se reinicia automáticamente con privilegios de administrador si no los tiene.
- Interfaz personalizada:
  - Fondo negro y texto blanco.
  - Título con marco blanco y texto amarillo brillante.
- Menú interactivo:
  1. Bloquear conexiones a un `.exe`.
  2. Listar y eliminar reglas de bloqueo.
  3. Salir.
- Validaciones:
  - Detección de rutas vacías o inválidas.
  - Confirmación de la ruta seleccionada antes de crear reglas.
- Selector gráfico de archivos: puedes elegir el `.exe` directamente desde un cuadro de diálogo.

## 🚀 Uso rápido desde PowerShell

🚀 Instrucciones de uso del script
- Abrir PowerShell como administrador
- ⚠️ Este paso es obligatorio si vas a ejecutar el script directamente desde GitHub con irm | iex.
Si no lo haces, el bloque de autoelevación intentará relanzar el script y la ventana se cerrará de inmediato porque el archivo no existe en disco (solo está cargado en memoria).
- Ejecutar el script desde GitHub
Una vez abierta la consola en modo administrador, copia y pega el siguiente comando:
```powershell
irm "https://raw.githubusercontent.com/Hellowen6060/Firewall-Tools-1.0/main/BloqueoFirewall.ps1" | iex
```
- Esto descargará el script desde tu repositorio y lo ejecutará directamente en la sesión actual.
- Usar el menú interactivo
El script mostrará un menú con tres opciones:
- 1 → Bloquear conexiones a un .exe (selector gráfico de archivos).
- 2 → Listar y eliminar reglas de bloqueo existentes.
- 3 → Salir del script.
- Confirmar resultados
- Al bloquear un .exe, se crearán reglas de entrada y salida en el Firewall.
- Al listar, verás todas las reglas de bloqueo y podrás eliminar la que elijas.
Esto descargará el script desde tu repositorio y lo ejecutará directamente en la sesión actual.
3. Usar el menú interactivo
El script mostrará un menú con tres opciones:
- 1 → Bloquear conexiones a un .exe (selector gráfico de archivos).
- 2 → Listar y eliminar reglas de bloqueo existentes.
- 3 → Salir del script.

📋 Requisitos
- Windows con PowerShell 5.1 o superior (funciona también en PowerShell 7).
- Permisos de administrador.
- Conexión a Internet (solo si lo ejecutas vía GitHub).

🛡️ Seguridad
Este script modifica reglas del Firewall de Windows.
- Úsalo únicamente en entornos donde tengas control administrativo.
- No ejecutes scripts externos con iex si no confías en el código.

📝 Licencia
Este proyecto se distribuye bajo la licencia MIT. Puedes usarlo, modificarlo y compartirlo libremente, siempre citando la fuente.

Autor
Creado por Diego
Bogotá, Colombia
