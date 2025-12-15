# Proyecto de Análisis de Datos Ambientales y Grafo de Conocimiento de Valencia

Este repositorio contiene los recursos y el código desarrollado para un proyecto de integración y análisis de datos sobre contaminación acústica y atmosférica en la ciudad de Valencia. El proyecto aborda tres vertientes principales: la construcción de un Data Warehouse mediante procesos ETL, la generación de un Grafo de Conocimiento enriquecido con datos de Wikidata y la visualización avanzada de datos.

## Descripción del Proyecto

El objetivo principal es procesar datos abiertos de la ciudad de Valencia para facilitar su análisis. El trabajo se divide en:

1.  **Data Warehouse (ETL)**: Se ha diseñado e implementado un proceso de Extracción, Transformación y Carga (ETL) utilizando **Pentaho Data Integration (Kettle)**. Este proceso integra datos de contaminación atmosférica, ruido, distritos y estaciones de medición en un modelo en estrella (Star Schema).
2.  **Grafo de Conocimiento (RDF)**: Se ha desarrollado un script en **Python** para transformar los datos de los distritos de Valencia al formato RDF (Turtle), enriqueciéndolos con enlaces a **Wikidata** y corrigiendo geometrías corruptas.
3.  **Visualización de Datos**: Generación de mapas interactivos y análisis estadísticos para comprender la distribución de la contaminación y el ruido en la ciudad.

## Estructura del Repositorio

El repositorio está organizado de la siguiente manera:

```
.
├── data/               # Datos fuente (CSV)
├── docs/               # Documentación adicional
├── etl/                # Transformaciones (.ktr) y trabajos (.kjb) de Pentaho
├── models/             # Modelos de datos (MySQL Workbench)
├── notebooks/          # Jupyter Notebooks (Python)
│   ├── T07_Transformacion_RDF.ipynb  # Generación de RDF
│   └── T08_Visualizacion_Datos.ipynb       # Generación de visualizaciones
├── rdf/                # Archivos RDF generados (.ttl)
├── visualizations/     # Mapas HTML y gráficos generados
├── LICENSE             # Licencia de uso
└── README.md           # Este archivo
```

## Requisitos

Para ejecutar los diferentes componentes del proyecto necesitarás:

*   **Pentaho Data Integration (PDI/Kettle)**: Para ejecutar los archivos `.ktr` y `.kjb` ubicados en la carpeta `etl/`.
*   **Python 3.x**: Para ejecutar los notebooks.
    *   Librerías principales: `pandas`, `rdflib`, `folium`, `seaborn`, `matplotlib`, `SPARQLWrapper`.
*   **MySQL Workbench**: Para visualizar el modelo lógico en `models/`.

## Uso

### 1. Proceso ETL (Pentaho)
1.  Abre Pentaho Data Integration (Spoon).
2.  Carga el trabajo principal `etl/Trabajo.kjb`.
3.  Ejecuta el trabajo para poblar el Data Warehouse.

### 2. Generación del Grafo de Conocimiento (RDF)
1.  Navega a la carpeta `notebooks/`.
2.  Abre `transformacion_rdf_distritos.ipynb`.
3.  Ejecuta las celdas. Este script:
    *   Carga los datos de distritos.
    *   Enlaza con Wikidata.
    *   **Aplica correcciones manuales** a geometrías corruptas (Poblats Marítims y Poblats del Sud).
    *   Genera el archivo `rdf/valencia_districts_places_enriched.ttl`.

### 3. Visualización de Datos
1.  Abre `notebooks/T08_Visualizacion_Datos.ipynb`.
2.  Ejecuta el notebook para generar:
    *   **Mapa de Contaminación (NO2)**: `visualizations/mapa_contaminacion_distritos.html`.
    *   **Mapa de Calor de Ruido**: `visualizations/mapa_calor_ruido.html`.
    *   **Gráficos Estadísticos**: Comparativas de contaminación semanal.

## Resultados Destacados

*   **Integración Semántica**: Los distritos ahora cuentan con enlaces `owl:sameAs` a Wikidata y geometrías GeoJSON corregidas.
*   **Análisis de Contaminación**: Se ha observado una reducción significativa del NO2 durante los fines de semana (efecto del tráfico).
*   **Mapa de Ruido**: Identificación de "puntos calientes" acústicos en el centro y zona portuaria.

## Referencias

*   **Ayuntamiento de Valencia - Datos Abiertos**: Fuente original de los archivos CSV.
*   **Wikidata**: Utilizado para el enriquecimiento semántico.
*   **Schema.org**: Vocabulario utilizado para la descripción de los datos en RDF.

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo `LICENSE` para más detalles.
