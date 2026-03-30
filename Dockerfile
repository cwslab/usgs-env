# 1. Start from a pre-built Jupyter stack to save 10 minutes of build time
FROM jupyter/scipy-notebook:latest

# 2. Switch to root to install system-level spatial dependencies (GDAL/PROJ)
USER root
RUN apt-get update && apt-get install -y \
    libgdal-dev \
    libproj-dev \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 3. Switch back to the Jupyter user
USER ${NB_USER}

# 4. Install your specific Hydrology and Geospatial packages
# We use --no-cache-dir to keep the image slim and fast to pull
RUN pip install --no-cache-dir \
    geopandas \
    shapely \
    folium \
    dataretrieval \
    hydroeval \
    pynhd \
    nbgitpuller

# 5. Important: nbgitpuller needs to be enabled to handle the "Magic Links"
RUN jupyter serverextension enable --py nbgitpuller --sys-prefix
