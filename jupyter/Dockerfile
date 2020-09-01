FROM python:3.7

RUN apt-get update

# Copy file of required Python packages
COPY requirements.txt .

# Install Python packages
RUN pip install --upgrade pip==20.2.2

RUN pip install -r ./requirements.txt

# Create directory for image data and copy data
WORKDIR /data

COPY ./image-data .

# make an output folder
WORKDIR /output

# Switch to directory of jupyter notebooks
WORKDIR /jupyter_notebooks

# Copy example notebook
COPY ./notebooks .

# Start jupyter-notebook server
CMD jupyter-notebook --no-browser --ip="*" --allow-root --NotebookApp.allow_remote_access=True --NotebookApp.iopub_data_rate_limit=100000000
