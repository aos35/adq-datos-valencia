
# Proyecto: Análisis y Visualización de Datos Ambientales de Valencia

Este repositorio integra todo el ciclo de procesamiento, modelado y visualización de datos ambientales (contaminación y ruido) de la ciudad de Valencia, combinando técnicas de ETL, modelado semántico (RDF) y análisis visual avanzado.

## Descripción General

El proyecto abarca:

1. **ETL y Data Warehouse**: Integración de datos abiertos (contaminación, ruido, distritos, estaciones) mediante procesos ETL en Pentaho, modelados en esquema estrella.
2. **Grafo de Conocimiento (RDF + Wikidata)**: Generación de un grafo RDF enriquecido con enlaces a Wikidata y geometrías corregidas, facilitando interoperabilidad y análisis semántico.
3. **Visualización Avanzada**: Mapas interactivos, análisis temporal y correlaciones para responder preguntas clave sobre la calidad ambiental y el ruido en Valencia.

## Estructura del Repositorio

```
├── data/               # Datos fuente (CSV: contaminación, ruido, distritos, estaciones) y Datos de salida de transformaciones en Pentaho
├── etl/                # Transformaciones y trabajos ETL (Pentaho: .ktr, .kjb)
├── models/             # Modelos de datos (físico y lógico: SQL, MWB)
├── notebooks/          # Jupyter Notebooks (procesos Python)
│   ├── T07_Transformacion_RDF.ipynb      # Generación y enriquecimiento RDF
│   └── T08_Visualizacion_Datos.ipynb     # Visualizaciones y análisis exploratorio
├── rdf/                # Grafo RDF generado (.ttl)
├── visualizations/     # Mapas HTML y gráficos PNG generados automáticamente
├── LICENSE             # Licencia MIT
└── README.md           # Este archivo
```

## Dependencias y Requisitos

- **Pentaho Data Integration (Kettle/Spoon)**: Para ejecutar los procesos ETL (`etl/`).
- **Python 3.x** y librerías:
    - `pandas`, `rdflib`, `folium`, `seaborn`, `matplotlib`, `SPARQLWrapper`, `shapely`, `IPython.display`
- **MySQL Workbench**: Para visualizar el modelo lógico (`models/`).

## Uso del Proyecto

### 1. ETL y Data Warehouse
1. Abre Pentaho Data Integration (Spoon).
2. Carga y ejecuta el trabajo principal: `etl/Trabajo.kjb`.
3. Se poblará el Data Warehouse con los datos integrados y transformados.

### 2. Generación del Grafo RDF
1. Abre el notebook `notebooks/T07_Transformacion_RDF.ipynb` en Jupyter.
2. Ejecuta las celdas para:
    - Cargar y normalizar los datos de distritos.
    - Enlazar con Wikidata (`owl:sameAs`).
    - Corregir geometrías corruptas (ej. Poblats Marítims).
    - Exportar el grafo enriquecido a `rdf/valencia_districts_places_enriched.ttl`.

### 3. Visualización y Análisis de Datos
1. Abre el notebook `notebooks/T08_Visualizacion_Datos.ipynb`.
2. Ejecuta las celdas para generar automáticamente:
    - **Mapa interactivo de contaminación (NO2) por distrito**: `visualizations/mapa_contaminacion_distritos.html`
    - **Mapa de calor de ruido**: `visualizations/mapa_calor_ruido.html`
    - **Gráficos temporales y comparativos**:
        - Evolución diaria y mensual de NO2 (`evolucion_diaria_no2.png`, `evolucion_calidad_ambiental_lineas.png`)
        - Comparativa semanal NO2/PM10 (`comparativa_semanal_contaminacion.png`, `barras_diarias_contaminacion.png`)

## Visualizaciones y Resultados

- **Mapa de Distritos (NO2 + Wikidata)**: Visualización interactiva con imágenes de Wikidata y geometrías corregidas.
- **Mapa de Calor de Ruido**: Identificación de zonas acústicamente críticas.
- **Análisis Temporal**: Gráficos de evolución diaria/mensual y comparativas entre días laborables y fines de semana.
- **Correlaciones y Reflexiones**: Análisis de la relación entre tráfico, contaminación y ruido.

Todos los resultados se guardan automáticamente en la carpeta `visualizations/`.

## Referencias y Fuentes

- **Ayuntamiento de Valencia - Datos Abiertos**: Fuente principal de los datos CSV.
- **Wikidata**: Enriquecimiento semántico y visual.
- **Schema.org**: Vocabulario RDF.

## Licencia

Este proyecto se distribuye bajo la Licencia MIT. Consulta el archivo `LICENSE` para más detalles.
