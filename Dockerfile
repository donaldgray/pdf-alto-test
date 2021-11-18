FROM cchacua/pdfalto:latest

RUN apt-get update && apt-get install -y python3 python3-pip python-dev libmupdf-dev
COPY requirements.txt /opt/app/requirements.txt
COPY main.py /opt/app/main.py

RUN pip3 install --no-cache-dir -r /opt/app/requirements.txt

ENTRYPOINT ["python3", "/opt/app/main.py"]