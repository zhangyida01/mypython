python
from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from Flask! Jenkins Pipeline + Harbor is working."

@app.route('/health')
def health():
    return "OK", 200

if __name__ == '__main__':
    # 监听所有网络接口，容器内部需要
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)