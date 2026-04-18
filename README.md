# Gestión de Firewall desde PowerShell 1.0

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
Puedes ejecutar el script directamente desde GitHub sin necesidad de descargarlo manualmente, usando:

```powershell
irm "https://raw.githubusercontent.com/Hellowen6060/Firewall-Tools-1.0/refs/heads/main/BloqueoFirewall.ps1" | iex
