FROM cchacua/pdfalto:latest

# USER root
# RUN apt-get update && apt-get install -y wget cmake clang git
# RUN mkdir /home/pdfalto && cd /home/pdfalto && git clone https://github.com/kermitt2/pdfalto.git && cd pdfalto && ./install_deps.sh && git submodule update --init --recursive && cmake ./ && make
# RUN cd /home && git clone https://github.com/kermitt2/pdfalto.git && cd pdfalto && ./install_deps.sh && git submodule update --init --recursive && cmake ./ && make

RUN apt-get update && apt-get install -y python3 python3-pip python-dev libmupdf-dev
RUN apt-get install -y mupdf
RUN apt-get install -y libfreetype6 libfreetype6-dev
COPY requirements.txt /opt/app/requirements.txt
COPY main.py /opt/app/main.py

RUN pip3 install --no-cache-dir -r /opt/app/requirements.txt

ENTRYPOINT ["python3", "/opt/app/main.py"]