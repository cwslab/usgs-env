# 1. Start from the pre-built Jupyter stack
FROM jupyter/scipy-notebook:latest

# 2. Install system-level spatial dependencies
USER root
RUN apt-get update && apt-get install -y \
    libgdal-dev \
    libproj-dev \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 3. Back to notebook user
USER ${NB_USER}

# 4. Install packages
# nbgitpuller handles its own registration in modern Jupyter versions
RUN pip install --no-cache-dir \
    geopandas \
    shapely \
    folium \
    dataretrieval \
    hydroeval \
    pynhd \
    nbgitpuller

# 5. Optional: Verify nbgitpuller is recognized (non-blocking)
RUN jupyter server extension list
