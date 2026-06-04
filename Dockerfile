FROM python:3.10-slim
ENV PYTHONUNBUFFERED=1
ENV PIP_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple
WORKDIR /app

# 安装flask依赖
RUN pip install flask --no-cache-dir

# 拷贝项目所有代码
COPY . .

# 暴露5000端口
EXPOSE 5000

# 启动程序（你的主文件mypython.py）
CMD ["python","mypython.py"]