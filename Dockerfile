FROM tiangolo/uvicorn-gunicorn-fastapi:python3.7

RUN apt-get update
RUN apt-get install -y vim
RUN apt-get -y install cron
RUN rm /app/main.py

#Conda
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-py38_4.11.0-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-py38_4.11.0-Linux-x86_64.sh -b \
    && rm -f Miniconda3-py38_4.11.0-Linux-x86_64.sh  
RUN conda create --name dockerEnv --clone base

#Do this for /bin/sh commands
#RUN echo "conda activate dockerEnv" > ~/.profile
#RUN export ENV=~/.profile

#RUN conda init bash
# Make all future RUN commands use the new environment:
SHELL ["conda", "run", "-n", "dockerEnv", "/bin/bash", "-c"]

#RUN conda activate dockerEnv
#RUN conda --version
RUN conda config --append channels conda-forge
#RUN conda install --file requirements.txt 


RUN pip install fastapi==0.68.0
COPY ./app /app
