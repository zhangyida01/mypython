# 使用多阶段构建减小最终镜像体积
FROM python:3.10-slim AS builder

WORKDIR /app

# 仅复制依赖清单，利用 Docker 缓存
COPY requirements.txt .

# 安装依赖到指定目录
RUN pip install --user -r requirements.txt --no-cache-dir \
    -i https://mirrors.aliyun.com/pypi/simple/ \
    --trusted-host mirrors.aliyun.com

# ---------- 运行阶段 ----------
FROM python:3.10-slim

# 设置环境变量（禁用 Python 缓冲 + 时区）
ENV PYTHONUNBUFFERED=1 \
    TZ=Asia/Shanghai

WORKDIR /app

# 从 builder 复制已安装的依赖
COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH

# 复制应用代码
COPY . .

# 声明运行时端口
EXPOSE 5000

# 健康检查（可选，用于容器编排）
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1

# 运行应用
CMD ["python", "mypython.py"]