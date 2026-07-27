# SOC3070 Análisis de Datos Categóricos

Este repositorio contiene el material del curso SOC3070 Análisis de Datos Categóricos, dictado el segundo semestre 2026 a estudiantes de postgrado del Departamento de Sociología de la Universidad Católica de Chile. Para mayores detalles ver el [`[programa]`](files/syllabus_soc3070.pdf) y [`[calendario]`](#Calendario) del curso.


## Class of 2025

![class](files/class_2025.png)


### Nivelación Matemática

- Funciones y bases de cálculo: [`[Pres]`](slides/class_1/class_1.html) [`[Code]`](slides/class_1/class_1.qmd)
- Fundamentos de teoría de probabilidad: [`[Pres]`](slides/class_2/class_2.html) [`[Code]`](slides/class_2/class_2.qmd)

Material de apoyo adicional (pre-cálculo): [`[texto]`](files/pre_calculo.pdf) · [`[derivadas]`](https://www.mathsisfun.com/calculus/derivatives-introduction.html) · [`[integrales, "Calculus Made Easy", 1910]`](files/calculus_easy.jpg)

---

## Calendario

Clases los días Lunes, bloques 12:20-13:30 y 14:50-16:00.

| Día   | Mes       | Contenido                  | Material                                                                                                                     |
|-------|-----------|----------------------------|------------------------------------------------------------------------------------------------------------------------------|
| 10    | Agosto    | Presentación del curso     | [`[Pres]`](https://mebucca.github.io/cda_soc3070/slides/class_3/class_3#1) [`[Code]`](slides/class_3/class_3.qmd)            |
| 17    | Agosto    | Variables Aleatorias y Distribuciones Discretas   | [`[Pres]`](https://mebucca.github.io/cda_soc3070/slides/class_4/class_4#1) [`[Code]`](slides/class_4/class_4.qmd)            |
| 24    | Agosto    | Momentos & MLE (12:20) · Tablas de Contingencia (14:50) | [`[Pres]`](https://mebucca.github.io/cda_soc3070/slides/class_5/class_5#1) [`[Code]`](slides/class_5/class_5.qmd) [`[Pres MLE]`](https://mebucca.github.io/cda_soc3070/slides/class_6/class_6#1) [`[Code MLE]`](slides/class_6/class_6.qmd) · [`[Pres Tablas]`](https://mebucca.github.io/cda_soc3070/slides/bonus_tablas_contingencia/bonus_tablas_contingencia#1) [`[Code Tablas]`](slides/bonus_tablas_contingencia/bonus_tablas_contingencia.qmd) |
| 31    | Agosto    | Modelo Lineal & LPM (12:20) · Modelos Lineales Generalizados (14:50) | [`[Pres]`](https://mebucca.github.io/cda_soc3070/slides/class_7/class_7#1) [`[Code]`](slides/class_7/class_7.qmd) [`[Notebook]`](https://mebucca.github.io/cda_soc3070/slides/class_7/notebook_7#1) · [`[Pres]`](https://mebucca.github.io/cda_soc3070/slides/class_8/class_8#1) [`[Code]`](slides/class_8/class_8.qmd) |
| 7     | Septiembre| GLM & Regresión logística  | [`[Pres]`](https://mebucca.github.io/cda_soc3070/slides/class_9/class_9#1) [`[Code]`](slides/class_9/class_9.qmd)                                                                                                                             |
| 14    | Septiembre| NO HAY CLASES (Receso de docencia UC) |                                                                                                                   |
| 21    | Septiembre| Efectos en Regresión logística | [`[Pres]`](https://mebucca.github.io/cda_soc3070/slides/class_10/class_10#1) [`[Code]`](slides/class_10/class_10.qmd) [`[Notebook]`](https://mebucca.github.io/cda_soc3070/slides/class_10/notebook_10#1)                                                                                                                             |
| 28    | Septiembre| Inferencia en Regresión logística | [`[Pres]`](https://mebucca.github.io/cda_soc3070/slides/class_11/class_11#1) [`[Code]`](slides/class_11/class_11.qmd) [`[Notebook]`](https://mebucca.github.io/cda_soc3070/slides/class_11/nb_11#1) |
| 5     | Octubre   | Regresión Logística Multinomial  | [`[Pres]`](https://mebucca.github.io/cda_soc3070/slides/class_12/class_12#1) [`[Code]`](slides/class_12/class_12.qmd) |
| 12    | Octubre   | NO HAY CLASES (Feriado: Encuentro de Dos Mundos) |                                                                                                     |
| 19    | Octubre   | Regresión Poisson  |[`[Pres]`](https://mebucca.github.io/cda_soc3070/slides/class_14/class_14#1) [`[Code]`](slides/class_14/class_14.qmd) |
| 26    | Octubre   | Causalidad  | [`[Pres]`](https://mebucca.github.io/cda_soc3070/slides/class_16/class_16#1) [`[Code]`](slides/class_16/class_16.qmd) |
| 2     | Noviembre | Clasificación y Cross-Validation con Regresión logística  | [`[Pres]`](https://mebucca.github.io/cda_soc3070/slides/class_17/class_17#1) [`[Code]`](slides/class_17/class_17.qmd) [`[Notebook]`](https://mebucca.github.io/cda_soc3070/slides/class_17/nb_17#1) · [`[Pres]`](https://mebucca.github.io/cda_soc3070/slides/class_18/class_18#1) [`[Code]`](slides/class_18/class_18.qmd) |
| 16    | Noviembre | Repaso y trabajo en proyecto final   |                                                                                                                              |
| 23    | Noviembre | Sesión Posters (trabajo final)       |                                                                                                                              |

### Módulo predictivo

La continuación metodológica del curso utiliza el mismo problema sustantivo —demanda horaria de Capital Bikeshare— para comparar modelos modernos:

| Clase | Contenido | Material |
|-------|-----------|----------|
| 19 | Regularización: Ridge, LASSO y Elastic Net | [`[Pres]`](slides/class_19/class_19.html) [`[Code]`](slides/class_19/class_19.qmd) |
| 20 | Árboles, Random Forest y Gradient Boosting | [`[Pres]`](slides/class_20/class_20.html) [`[Code]`](slides/class_20/class_20.qmd) |
| 21 | Introducción a Redes Neuronales | [`[Pres]`](slides/class_21/class_21.html) [`[Code]`](slides/class_21/class_21.qmd) |
| 22 | Un "Flavor" de LLMs (usando Regresión Logística) | [`[Pres]`](slides/class_22/class_22.html) [`[Code]`](slides/class_22/class_22.qmd) |

### Infraestructura compartida

- `slides/_shared/bikeshare.R` prepara los outcomes binario, ordinal y de conteo a partir de `ISLR2::Bikeshare`, define las paletas por equipo/tema y aplica el tema común de `ggplot2` (`use_course_style()`, `use_course_data()`).
- `slides/_shared/course.css` controla el diseño RevealJS, los chunks de R, las tablas, las ecuaciones y los layouts de todas las presentaciones. Las paletas de color (una por equipo de fútbol) viven ahí como variables CSS y son leídas también desde R.
- `slides/_shared/course.lua` es un filtro Pandoc compartido: convierte las pausas `. . .` en fragmentos de RevealJS y asigna el color de fondo de portada/cierre/secciones según el tema activo.
- Las clases predictivas requieren, además de `tidyverse` e `ISLR2`, los paquetes `glmnet`, `rpart`, `randomForest`, `gbm` y `nnet`.


**IMPORTANTE:** Este curso permite el uso ético y transparente de herramientas de inteligencia artificial generativa, únicamente como herramienta de estudio o apoyo en la escritura de código. El estudiantado deberá declarar explícitamente en los anexos de cada trabajo qué herramientas fueron utilizadas, con qué propósito y, si se solicita, compartir los comandos o prompts empleados. El uso de IA no exime a los y las estudiantes de dominar plenamente el contenido de sus trabajos. Para verificar esto, en la clase posterior a la entrega de cualquier tarea o trabajo, un estudiante serán seleccionado al azar para explicar oralmente frente a la clase el procedimiento seguido en alguna de sus respuestas. En base a esta exposición, su nota podrá ser reconsiderada. El uso no autorizado o no declarado será considerado una falta a la integridad académica.


## Horario de Consulta

- Reuniones individuales de aproximadamente 15 minutos cada día Lunes entre 14:30 y 15:30pm. [`[Agendar]`](https://calendar.app.google/Cyu1NRh6Bn2vRHEx9)

## Ayudantía

|Día              | Mes              | Contenido       |
|-----------------|------------------|-----------------|
| 27              | Agosto           | Introducción a funciones de Tidyverse |



## Evaluaciones


| Tarea           | Asignación       | Entrega         |
|-----------------|------------------|-----------------|
| Tarea corta 1   | 4 de Agosto      | 11 de Agosto    |
| Tarea corta 2   | 21 de Agosto     | 27 de Agosto    |
| Trabajo 1       | 11 de Septiembre | 6 de Octubre    |
| Tarea corta 3   | 6 de Octubre     | 13 de Octubre   |
| Tarea corta 4   | 13 de Octubre    | 20 de Octubre   |
| Trabajo 2       | 27 de Octubre    | 10 de Noviembre |
| Trabajo final   | 29 de Septiembte | 24 de Noviembre  |


Notas Finales: [`[Notas]`](https://mebucca.github.io/cda_soc3070/grades/notas_final#1)


## Desarrollo y mantención del repositorio

Esta sección es para quien edite el material del curso (no es necesaria para seguir la clase).

### Estructura

```
repo/
├── README.md
├── BIKESHARE_MIGRATION_SPEC.md   # spec de la migración affairsdata → ISLR2::Bikeshare
├── files/                        # material de nivelación y plantillas (no ligado a una clase)
├── grades/                       # notas_final.qmd (lee planilla de Google Sheets)
├── slides/
│   ├── _shared/                  # bikeshare.R, course.css, course.lua — usados por TODAS las clases
│   ├── render_all.zsh            # renderiza todas las clases y notebooks del curso
│   ├── class_1/, class_2/, ...   # una carpeta por clase: `.qmd` (fuente), `.html` (salida),
│   │                             #   `_files/` (figuras y librerías generadas por Quarto), e imágenes propias
│   └── bonus_tablas_contingencia/, bonus_ordinal/   # material fuera de la secuencia numerada
```

- La numeración de clases (`class_1` a `class_22`) sigue el orden pedagógico exacto del programa vigente, sin saltos: nivelación matemática (1–2), teoría de la probabilidad y fundamentos del curso (3–6), modelos para datos categóricos con uso explicativo (7–16) y con uso predictivo/clasificatorio (17–22).
- "Tablas de Contingencia" y "Regresión Logística (Multinomial) Ordenada" quedaron fuera de la secuencia numerada vigente; se conservan como material `bonus_*` (ver `slides/index.qmd`).
- Cada carpeta de clase es autocontenida: sus imágenes (`.png`, `.jpg`, `.gif`) son insumos del `.qmd`, mientras que `_files/` es enteramente generado por `quarto render` y puede borrarse y regenerarse en cualquier momento.
- `homework/` y `ayudantia/` no se versionan en este repositorio.

### Dependencias de R

Además de `tidyverse`, las presentaciones usan (según la clase): `ISLR2`, `MASS`, `carData`, `DescTools`, `nnet`, `caret`, `glmnet`, `rpart`, `randomForest`, `gbm`, `rsample`, `modelr`, `broom`, `marginaleffects`, `margins`, `arm`, `sandwich`, `lmtest`, `sjPlot`, `sjmisc`, `sjlabelled`, `stargazer`, `pROC`, `viridis`, `RColorBrewer`, `ggrepel`, `ggridges`, `ggfortify`, `ggExtra`, `gridExtra`, `cowplot`, `reshape2`, `pacman` (usado para cargar paquetes en varias clases), `ragg` y `systemfonts` (fuente DejaVu Sans para los gráficos). `grades/notas_final.qmd` además requiere `googlesheets4` y `kableExtra` (y autenticación de Google la primera vez que se renderiza).

### Cómo renderizar

```bash
# una sola presentación
cd slides/class_7 && quarto render class_7.qmd --to revealjs

# el curso completo (decks a revealjs, notebooks a html)
cd slides && ./render_all.zsh
```

`render_all.zsh` recorre `slides/` renderizando todo `class_*.qmd` y `bonus_*.qmd` como RevealJS, y todo `notebook_*.qmd`/`nb_*.qmd`/`nb_*.Rmd`/`index.qmd` como HTML simple (son prácticas o el índice, no diapositivas). Al final imprime qué presentaciones fallaron, si alguna.

### Notas de implementación

- Las clases usan indistintamente `.qmd` (Quarto nativo) y `.Rmd` con YAML de Quarto (`format: html:`) o de R Markdown clásico (`output: html_document`); Quarto renderiza ambos casos sin problema.
- `slides/_shared/bikeshare.R` lee las paletas de color directamente desde `slides/_shared/course.css` (busca el bloque `body.theme-<equipo> { ... }`), por lo que agregar un tema nuevo solo requiere un bloque CSS, no tocar el R.
- El curso migró su ejemplo central de un dataset de infidelidad conyugal (`Ecdat::Fair`) a `ISLR2::Bikeshare`; `BIKESHARE_MIGRATION_SPEC.md` documenta las convenciones de nombres y fórmulas usadas en esa migración. `class_12`/`class_13` (datos de plebiscito chileno, `carData::Chile`) y la sección Covid-19 de `class_14` (`covid_data.csv`) quedaron deliberadamente fuera de esa migración y conservan sus datasets originales.

## Recursos computacionales

### Para usuarios de `R`

  - En el repositorio de mi curso de *procesamiento avanzado de datos en `R`* puedes encontrar todo el material necesario para aprender `R` desde cero [`[aquí]`](https://mebucca.github.io/dar_soc4001/).
  - Acá pueden encontrar un template para escribir en `RMarkdown` ([`[PDF]`](files/template_rmarkdown.pdf) y [`[.Rmd]`](files/template_rmarkdown.Rmd) ). El uso de `RMarkdown` no es obligatorio, pero es altamente recomendado para escribir sus tareas y trabajos. Hoja de ayuda [`[aquí]`](https://rstudio-pubs-static.s3.amazonaws.com/330387_5a40ca72c3b14824acedceb7d34618d1.html).
  - [`[StalkOverflow]`](https://stackoverflow.com/) tiene las respuestas a casi todas las preguntas.
 

 ### Para usuarios de `Stata`

 - Es este [`[link]`](https://stats.idre.ucla.edu/other/examples/icda/) pueden encontrar la implementación en `Stata` de los ejemplos usandos en (casi) todos los capítulos del libro de Alan Agresti, [`[Introduction to Categorical Data Analysis]`](https://www.amazon.com/Introduction-Categorical-Data-Analysis/dp/0471226181). 

---
