# Configurar salida en UTF-8 para mostrar tildes y caracteres especiales
#[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Verificar si el script corre como administrador
$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Reiniciando el script con privilegios de administrador..." -ForegroundColor Yellow
    Start-Process powershell -ArgumentList "-File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Configurar colores globales
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"
Clear-Host

function Mostrar-Titulo {
    Clear-Host
    $titulo = "Gestión de Firewall desde Powershell 1.0"
    $marco = ("=" * ($titulo.Length + 4))
    Write-Host $marco -ForegroundColor White
    Write-Host "= " -NoNewline -ForegroundColor White
    Write-Host $titulo -ForegroundColor Yellow -NoNewline
    Write-Host " =" -ForegroundColor White
    Write-Host $marco -ForegroundColor White
    Write-Host ""
}

do {
    Mostrar-Titulo
    Write-Host "Selecciona la tarea a realizar:" -ForegroundColor White
    Write-Host ""
    Write-Host "1 - Bloquear conexiones a un .exe"
    Write-Host "2 - Listar y eliminar reglas de bloqueo"
    Write-Host "3 - Salir"
    Write-Host ""

    $opcion = Read-Host "Selecciona la tarea a realizar"
    Write-Host ""

    switch ($opcion) {
        "1" {
            Add-Type -AssemblyName System.Windows.Forms
            $dialog = New-Object System.Windows.Forms.OpenFileDialog
            $dialog.Filter = "Ejecutables (*.exe)|*.exe"
            $dialog.Title = "Selecciona el archivo .exe a bloquear"

            if ($dialog.ShowDialog() -eq "OK") {
                $exeblock = $dialog.FileName
                Write-Host ""  # línea vacía después de seleccionar opción
                Write-Host "Ruta detectada: $exeblock" -ForegroundColor Cyan

                $ruleNameIn = "Bloqueo Entrada $([System.IO.Path]::GetFileName($exeblock))"
                $ruleNameOut = "Bloqueo Salida $([System.IO.Path]::GetFileName($exeblock))"

                if (-not (Get-NetFirewallRule -DisplayName $ruleNameIn -ErrorAction SilentlyContinue)) {
                    New-NetFirewallRule -DisplayName $ruleNameIn -Direction Inbound -Program "$exeblock" -Action Block
                    Write-Host "Se ha realizado el bloqueo entrante para $exeblock" -ForegroundColor Green
                } else {
                    Write-Host "La regla de entrada ya existe para $exeblock" -ForegroundColor Yellow
                }

                if (-not (Get-NetFirewallRule -DisplayName $ruleNameOut -ErrorAction SilentlyContinue)) {
                    New-NetFirewallRule -DisplayName $ruleNameOut -Direction Outbound -Program "$exeblock" -Action Block
                    Write-Host "Se ha realizado el bloqueo saliente para $exeblock" -ForegroundColor Green
                } else {
                    Write-Host "La regla de salida ya existe para $exeblock" -ForegroundColor Yellow
                }
            } else {
                Write-Host ""  # línea vacía
                Write-Host "No seleccionaste ningún archivo .exe." -ForegroundColor Red
            }

            Pause
            Mostrar-Titulo
        }

        "2" {
            $rules = Get-NetFirewallRule | Where-Object { $_.Action -eq "Block" } | Get-NetFirewallApplicationFilter | Where-Object { $_.Program -like "*.exe" }

            if ($rules) {
                Write-Host "Cargado información solicitada." -ForegroundColor Cyan
                Write-Host "Listado de reglas de bloqueo de .exe:" -ForegroundColor Cyan

                $i = 1
                foreach ($rule in $rules) {
                    $parentRule = Get-NetFirewallRule -Name $rule.InstanceID
                    Write-Host "$i - $($parentRule.DisplayName) | Dirección: $($parentRule.Direction) | Programa: $($rule.Program)" -ForegroundColor White
                    $i++
                }

                $choice = Read-Host "Ingresa el número de la regla que deseas eliminar"
                if ($choice -match '^\d+$') {
                    $selectedRule = ($rules | Select-Object -Index ($choice - 1))
                    if ($selectedRule) {
                        $parentRule = Get-NetFirewallRule -Name $selectedRule.InstanceID
                        try {
                            Remove-NetFirewallRule -Name $parentRule.Name -ErrorAction Stop
                            Write-Host "Se ha eliminado la regla: $($parentRule.DisplayName)" -ForegroundColor Green
                        } catch {
                            Write-Host "No se pudo eliminar la regla: $($parentRule.DisplayName). Error: $($_.Exception.Message)" -ForegroundColor Red
                        }
                    } else {
                        Write-Host "Número inválido, no existe esa regla." -ForegroundColor Red
                    }
                } else {
                    Write-Host "Entrada inválida, debes ingresar un número." -ForegroundColor Red
                }
            } else {
                Write-Host "No existen reglas de bloqueo de .exe" -ForegroundColor Yellow
            }
            Pause
            Mostrar-Titulo
        }

        "3" {
            Mostrar-Titulo
            Write-Host "Saliendo del script..." -ForegroundColor Yellow
        }

        Default {
            Write-Host "Opción inválida. Intenta nuevamente." -ForegroundColor Red
            Pause
            Mostrar-Titulo
        }
    }
} while ($opcion -ne "3")
