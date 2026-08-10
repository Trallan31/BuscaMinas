# BuscaMinas

> Implementación del clásico juego **Buscaminas** desarrollada en Godot como proyecto educativo universitario.

---

## Descripción

**BuscaMinas** es una implementación del clásico juego de lógica **Minesweeper**, desarrollada utilizando **Godot Engine** y GDScript.

El objetivo del juego es descubrir todas las casillas que no contienen minas sin hacer clic sobre una de ellas.

Cada casilla puede contener una mina o estar asociada a un número que indica cuántas minas existen en las casillas vecinas.

El proyecto fue desarrollado como una instancia de aprendizaje para aplicar conceptos fundamentales de desarrollo de videojuegos en Godot, incluyendo escenas, scripts, señales, interfaces gráficas, generación dinámica de elementos y manejo de eventos.

---

## Características

* Generación aleatoria de minas.
* Cálculo automático de minas vecinas.
* Generación dinámica del tablero.
* Tableros con cantidad de filas y columnas configurable.
* Sistema de banderas mediante clic derecho.
* Detección de minas.
* Revelado automático de zonas vacías.
* Detección de victoria.
* Detección de derrota.
* Revelado de minas al perder.
* Reinicio de partida.
* Menú de pausa.
* Regreso al menú principal.
* Salida del juego.
* Efectos de sonido.
* Tema visual personalizado.
* Pantalla de créditos.

---

## Cómo jugar

El objetivo es descubrir todas las casillas que **no contienen minas**.

Cada número mostrado en una casilla representa la cantidad de minas existentes en las casillas que la rodean.

Por ejemplo:

```text
┌───┬───┬───┐
│ 1 │ 1 │ 0 │
├───┼───┼───┤
│ 1 │ 💣│ 1 │
├───┼───┼───┤
│ 1 │ 1 │ 1 │
└───┴───┴───┘
```

Una casilla con `1` indica que existe **una mina** entre sus casillas vecinas.

### Objetivo

Para ganar:

1. Descubre las casillas del tablero.
2. Utiliza los números para deducir dónde están las minas.
3. Marca las posibles minas con banderas.
4. Evita descubrir una casilla que contenga una mina.
5. Descubre todas las casillas seguras.

---

## Controles

| Acción                 | Control                       |
| ---------------------- | ----------------------------- |
| Descubrir casilla      | Clic izquierdo            |
| Colocar/quitar bandera | Clic derecho              |
| Abrir/cerrar pausa     | Tecla configurada como `menu` |
| Reiniciar              | Botón `Restart`               |
| Volver al menú         | Botón `Back to Menu`          |
| Salir                  | Botón `Exit`                  |

El clic derecho alterna el estado de una casilla entre marcada y no marcada.

---

## Sistema de minas

Las minas se generan automáticamente cada vez que se crea o reinicia el tablero.

El tablero comienza con una cantidad configurable de minas:

```text
mine_counts = 6
```

Al utilizar el botón de reinicio después de modificar el tamaño del tablero, la cantidad de minas se calcula como aproximadamente el **25 % del número total de casillas**.

Por ejemplo:

| Tablero | Casillas | Minas |
| ------- | -------: | ----: |
| 4 × 6   |       24 |     6 |
| 5 × 8   |       40 |    10 |
| 8 × 8   |       64 |    16 |
| 10 × 10 |      100 |    25 |

---

## Cálculo de números

Después de colocar las minas, el juego analiza las ocho posiciones que rodean cada casilla.

Para cada casilla segura se calcula:

```text
┌───┬───┬───┐
│ ↖ │ ↑  │ ↗ │
├───┼───┼───┤
│ ← │ X  │ → │
├───┼───┼───┤
│ ↙ │ ↓  │ ↘ │
└───┴───┴───┘
```

Las posiciones que contienen minas se cuentan y el resultado se almacena en la casilla como `neighbor_mines`.

De esta forma, cada número representa cuántas minas existen alrededor de esa posición.

---

## Revelado automático

Una de las funcionalidades implementadas es el descubrimiento automático de zonas vacías.

Cuando el jugador descubre una casilla que no tiene minas vecinas:

```text
neighbor_mines == 0
```

el juego procede a revelar las casillas vecinas de manera recursiva.

Esto permite descubrir automáticamente grandes áreas del tablero sin tener que seleccionar cada casilla individualmente.

---

## Sistema de banderas

Las casillas pueden marcarse como posibles ubicaciones de minas utilizando el **clic derecho**.

Una casilla puede encontrarse en estados como:

```text
Normal
  ↓
🚩 Marcada
  ↓
Normal
```

La bandera también cuenta con un efecto de sonido y una variación visual propia del tema del juego.

---

## Sistema de victoria

El jugador gana cuando todas las casillas que **no contienen minas** han sido descubiertas.

El sistema recorre las casillas y comprueba cuántas casillas seguras permanecen ocultas.

Cuando el número llega a cero:

```text
safe_tiles_hidden == 0
```

se muestra el mensaje de victoria y se habilita el menú correspondiente.

---

## Sistema de derrota

Si el jugador descubre una casilla que contiene una mina:

1. Se reproduce un efecto de sonido.
2. La casilla seleccionada cambia su apariencia.
3. Se revelan las minas del tablero.
4. Se muestra el mensaje de derrota.
5. Se habilita el menú de pausa/reinicio.

Esto permite al jugador visualizar el estado final del tablero y comenzar una nueva partida.

---

## Tamaño del tablero

Una de las características del proyecto es que el usuario puede modificar el tamaño del tablero.

El sistema dispone de controles para seleccionar:

* Número de filas.
* Número de columnas.

Al presionar el botón de reinicio, el tablero anterior se elimina y se genera uno nuevo utilizando las dimensiones seleccionadas.

### Ejemplo

```text
Filas:    8
Columnas: 10

        ↓

Nuevo tablero 8 × 10
        ↓
Generación de casillas
        ↓
Generación de minas
        ↓
Cálculo de números
```

---

## Menú de pausa

El juego incluye un menú de pausa con diferentes opciones:

* Continuar.
* Reiniciar.
* Volver al menú principal.
* Salir.

El menú utiliza el sistema de pausa de Godot mediante:

```text
get_tree().paused
```

y permite detener y reanudar la partida.

---

## Tecnologías utilizadas

### Motor

* **Godot Engine 4.6**
* Renderizador **Forward Plus**

### Lenguaje

* **GDScript**

### Sistemas utilizados

* Godot Control Nodes.
* Signals.
* GridContainer.
* Escenas reutilizables.
* Eventos de mouse.
* Sistema de pausa de Godot.
* Sistema de audio.
* Temas personalizados.
* Generación procedural del tablero.

La configuración del proyecto establece Godot 4.6, una resolución de viewport de **1280 × 720** y el modo de escalado `canvas_items`.

---

## Resolución

La resolución base utilizada por el proyecto es:

```text
1280 × 720
```

El proyecto utiliza:

```text
canvas_items
```

para el modo de escalado de la ventana.

---

## Estructura del proyecto

```text
BuscaMinas/
│
├── assets/
│   └── Recursos gráficos del juego
│
├── autoloads/
│   └── debug.gd
│
├── fonts/
│   └── Fuentes utilizadas por la interfaz
│
├── resources/
│   └── theme.tres
│
├── scenes/
│   ├── board.gd
│   ├── board.tscn
│   │
│   ├── tile.gd
│   ├── tile.tscn
│   │
│   ├── main_menu.gd
│   ├── main_menu.tscn
│   │
│   ├── pause_menu.tscn
│   │
│   ├── credits.gd
│   ├── credits.tscn
│   │
│   └── rich_text_label.gd
│
├── sounds/
│   └── Efectos de sonido
│
├── .editorconfig
├── .gitattributes
├── .gitignore
├── default_bus_layout.tres
├── export_presets.cfg
├── icon.svg
├── pause_menu.gd
├── project.godot
└── README.md
```

La separación principal del proyecto distingue recursos, escenas, scripts, sonidos, fuentes y sistemas globales.

---

## Arquitectura

El proyecto está organizado principalmente alrededor de dos componentes:

### `Board`

`board.gd` es el controlador principal del juego.

Sus responsabilidades incluyen:

* Crear el tablero.
* Crear las casillas.
* Posicionar las casillas.
* Generar las minas.
* Calcular las minas vecinas.
* Procesar los clics.
* Revelar zonas vacías.
* Revelar las minas al perder.
* Comprobar la victoria.
* Reiniciar el tablero.

### `Tile`

`tile.gd` representa una casilla individual.

Cada casilla mantiene información sobre:

```text
has_mine
revealed
flagged
neighbor_mines
grid_position
```

Además, emite una señal cuando el jugador interactúa con ella.

Esta separación permite que el tablero administre la partida mientras cada casilla mantiene su propio estado.

---

## Comunicación mediante señales

El proyecto utiliza **Signals** de Godot para comunicar las casillas con el tablero.

Cuando una casilla recibe un clic:

```text
Tile
 ↓
tile_clicked
 ↓
Board
 ↓
on_tile_clicked()
```

De esta manera, `tile.gd` no necesita controlar directamente toda la lógica del juego.

---

## Audio

El juego incluye diferentes efectos de sonido para mejorar la interacción:

* Clics de botones.
* Colocación de banderas.
* Descubrimiento de casillas.
* Explosión al descubrir una mina.

Estos efectos se reproducen desde los distintos nodos correspondientes durante las acciones del jugador.

---

## Instalación y ejecución

### Requisitos

Para abrir el proyecto se recomienda:

* **Godot Engine 4.6**
* Git, si se desea clonar el repositorio.

### Clonar el repositorio

```bash
git clone https://github.com/Trallan31/BuscaMinas.git
```

Entrar al directorio:

```bash
cd BuscaMinas
```

### Abrir en Godot

1. Abrir Godot Engine.
2. Seleccionar **Import**.
3. Seleccionar la carpeta del repositorio.
4. Abrir el archivo:

```text
project.godot
```

5. Importar el proyecto.
6. Ejecutarlo con **Play**.

---

## Autor

**Allan Rabanales**

GitHub: **[@Trallan31](https://github.com/Trallan31)**

Proyecto desarrollado individualmente como parte de una actividad académica universitaria.

---

## Sobre el proyecto

**BuscaMinas** representa una implementación sencilla pero completa de uno de los juegos de lógica más conocidos.

El proyecto combina una interfaz gráfica con generación dinámica de contenido y algoritmos para gestionar minas, números, vecinos, banderas y condiciones de victoria o derrota.

Además de recrear la mecánica clásica, el proyecto sirve como ejercicio práctico para comprender cómo estructurar un pequeño videojuego utilizando **Godot y GDScript**.
