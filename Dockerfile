FROM jupyter/scipy-notebook:python-3.10

USER root
RUN apt-get update && apt-get install -y \
    libgdal-dev \
    libproj-dev \
    g++ \
    && rm -rf /var/lib/apt/lists/*

USER ${NB_USER}

RUN mamba install -y -c conda-forge \
    "numpy<2" \
    "pandas<2.3" \
    matplotlib \
    shapely \
    geopandas \
    folium \
    dataretrieval \
    hydroeval \
    pynhd \
    pyarrow \
    bottleneck \
    numexpr \
    && mamba clean -afy

RUN pip install --no-cache-dir nbgitpuller

RUN jupyter server extension list
