# 导入Flask库
from flask import Flask

# 创建Web应用
app = Flask(__name__)

# 定义首页路由（访问根目录显示内容）
@app.route('/')
def hello():
    return "?? 我的第一个极简Web项目！"

# 启动服务（本地访问 0.0.0.0:5000）
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)