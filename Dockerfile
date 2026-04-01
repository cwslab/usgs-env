FROM jupyter/scipy-notebook:python-3.10

USER root
RUN apt-get update && apt-get install -y \
    libgdal-dev \
    libproj-dev \
    g++ \
    && rm -rf /var/lib/apt/lists/*

USER ${NB_USER}

RUN mamba install -y -c conda-forge \
    numpy=1.26.* \
    pandas=2.2.* \
    matplotlib=3.8.* \
    shapely=2.0.* \
    geopandas=0.14.* \
    folium=0.16.* \
    dataretrieval \
    hydroeval \
    pynhd \
    pyarrow \
    bottleneck \
    numexpr \
    && mamba clean -afy

RUN pip install --no-cache-dir nbgitpuller

RUN python -c "import numpy, pandas, shapely, geopandas; print(numpy.__version__, pandas.__version__)"
RUN jupyter server extension list
