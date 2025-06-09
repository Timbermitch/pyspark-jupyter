# Use official Python 3.9 slim image
FROM python:3.9-slim

# Install Java 17 (required by PySpark) and system utilities
RUN apt-get update && apt-get install -y \
    openjdk-17-jre-headless \
    curl \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set Java environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Install PySpark, Jupyter, and kernel dependencies
RUN pip install --no-cache-dir pyspark jupyter ipykernel ipywidgets

RUN pip install --no-cache-dir ipykernel

# Install pip explicitly (required for slim images sometimes)
RUN apt-get update && apt-get install -y python3-pip

# Install Numpy
RUN pip install numpy


# Expose Jupyter Notebook port
EXPOSE 8888

# Set working directory inside container
WORKDIR /app

#COPY app.py /app/

# Start Jupyter Notebook on container launch
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

# Default command: run app.py
# CMD ["python", "app.py"]
