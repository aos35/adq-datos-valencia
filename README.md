# Proyecto de Análisis de Datos Ambientales y Grafo de Conocimiento de Valencia

Este repositorio contiene los recursos y el código desarrollado para un proyecto de integración y análisis de datos sobre contaminación acústica y atmosférica en la ciudad de Valencia. El proyecto aborda dos vertientes principales: la construcción de un Data Warehouse mediante procesos ETL y la generación de un Grafo de Conocimiento enriquecido con datos de Wikidata.

## Descripción del Proyecto

El objetivo principal es procesar datos abiertos de la ciudad de Valencia para facilitar su análisis. El trabajo se divide en dos partes:

1.  **Data Warehouse (ETL)**: Se ha diseñado e implementado un proceso de Extracción, Transformación y Carga (ETL) utilizando **Pentaho Data Integration (Kettle)**. Este proceso integra datos de contaminación atmosférica, ruido, distritos y estaciones de medición en un modelo en estrella (Star Schema) para su posterior análisis.
2.  **Grafo de Conocimiento (RDF)**: Se ha desarrollado un script en **Python** para transformar los datos de los distritos de Valencia al formato RDF (Turtle), enriqueciéndolos con enlaces a **Wikidata**. Esto permite realizar consultas semánticas y visualizar los datos en mapas interactivos.

## Estructura del Repositorio

El repositorio está organizado de la siguiente manera siguiendo las mejores prácticas:

```
.
├── data/               # Datos fuente (CSV, Excel) y datos procesados
│   ├── rdf/            # Archivos RDF generados (.ttl)
│   └── ...             # Archivos CSV originales (distritos, contaminación, ruido, etc.)
├── etl/                # Transformaciones (.ktr) y trabajos (.kjb) de Pentaho
├── models/             # Modelos de datos (MySQL Workbench)
├── notebooks/          # Jupyter Notebooks con el código Python para RDF
├── docs/               # Documentación adicional del proyecto
├── LICENSE             # Licencia de uso
└── README.md           # Este archivo
```

## Requisitos

Para ejecutar los diferentes componentes del proyecto necesitarás:

*   **Pentaho Data Integration (PDI/Kettle)**: Para ejecutar los archivos `.ktr` y `.kjb` ubicados en la carpeta `etl/`.
*   **Python 3.x**: Para ejecutar el notebook en `notebooks/`.
    *   Librerías necesarias: `pandas`, `rdflib`.
*   **MySQL Workbench**: Para visualizar el modelo lógico en `models/`.

## Uso

### 1. Proceso ETL (Pentaho)
1.  Abre Pentaho Data Integration (Spoon).
2.  Carga el trabajo principal `etl/Trabajo.kjb`.
3.  Asegúrate de configurar las conexiones a la base de datos si es necesario.
4.  Ejecuta el trabajo para poblar el Data Warehouse.

### 2. Generación del Grafo de Conocimiento (Python)
1.  Navega a la carpeta `notebooks/`.
2.  Abre el archivo `codigo.ipynb` en Jupyter Notebook o VS Code.
3.  Ejecuta las celdas para procesar el archivo `districtes-distritos.csv` (ubicado en `data/`).
4.  El resultado se generará en `data/rdf/valencia_districts_places_enriched.ttl`.

## Visualizaciones

El proyecto permite generar visualizaciones geográficas mediante consultas SPARQL sobre el grafo generado. El notebook incluye una consulta de ejemplo para visualizar los distritos en el [Servicio de Consultas de Wikidata](https://query.wikidata.org/).

Ejemplo de consulta SPARQL para visualizar distritos:
```sparql
#defaultView:Map
SELECT ?item ?itemLabel ?coords WHERE {
  VALUES ?item { wd:Q3392733 wd:Q3392745 ... } # IDs de distritos
  ?item wdt:P625 ?coords .
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],es". }
}
```

## Referencias

*   **Ayuntamiento de Valencia - Datos Abiertos**: Fuente original de los archivos CSV (contaminación, ruido, distritos).
*   **Wikidata**: Utilizado para el enriquecimiento semántico de los distritos.
*   **Schema.org**: Vocabulario utilizado para la descripción de los datos en RDF.

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo `LICENSE` para más detalles.
