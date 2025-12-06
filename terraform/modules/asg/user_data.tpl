#!/bin/bash
set -e
yum update -y
amazon-linux-extras install -y python3.8 || true
yum install -y python3 git
python3 -m pip install --upgrade pip
python3 -m pip install flask

cat > /opt/${project}_app.py <<'PY'
from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
    return 'hello from ${project}\n'

@app.route('/health')
def health():
    return 'ok'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=${port})
PY

cat > /etc/systemd/system/${project}_app.service <<'SRV'
[Unit]
Description=${project} flask app
After=network.target

[Service]
WorkingDirectory=/opt
ExecStart=/usr/bin/python3 /opt/${project}_app.py
Restart=always
User=root

[Install]
WantedBy=multi-user.target
SRV

systemctl daemon-reload
systemctl enable ${project}_app
systemctl start ${project}_app
