#!/bin/bash

# ================= 配置区 =================
APP_NAME="my-blog"
# 容器对外暴露的端口，用于健康检查
HOST_PORT="18080"
# 健康检查接口，根据你的后端接口调整，通常是 /actuator/health 或自定义的 /health
HEALTH_URL="http://127.0.0.1:${HOST_PORT}/actuator/health"
# 代码仓库地址
GIT_REPO_URL="https://github.com/kcbjt/KBlog.git"
# Dockerfile 路径 (如果 Dockerfile 在项目根目录则改为 ./Dockerfile)
DOCKERFILE_PATH="./Dockerfile"
# ===========================================

# 1. 生成版本号 (时间戳+短哈希)
VERSION=$(date +%Y%m%d%H%M%S)-$(git rev-parse --short HEAD 2>/dev/null || echo "local")
IMAGE_NAME="${APP_NAME}:${VERSION}"
LATEST_IMAGE="${APP_NAME}:latest"

echo "🚀 开始部署: ${APP_NAME}"
echo "🏷️  版本: ${VERSION}"

# 2. 获取代码 (如果是第一次运行则 clone，否则 pull)
if [ ! -d ".git" ]; then
    echo "📥 首次运行，正在克隆代码..."
    git clone ${GIT_REPO_URL} .
else
    echo "📥 正在更新代码..."
    git pull
fi

# 3. 构建新镜像
echo "🔨 正在构建镜像..."
# 这里的 . 代表构建上下文是当前目录
docker build -t ${IMAGE_NAME} -t ${LATEST_IMAGE} -f ${DOCKERFILE_PATH} .

if [ $? -ne 0 ]; then
    echo "❌ 镜像构建失败！"
    exit 1
fi

# 4. 记录旧容器 ID (用于后续删除)
OLD_CONTAINER_ID=$(docker ps -q -f name=${APP_NAME})

# 5. 启动新容器
echo "🆕 正在启动新容器..."
docker run -d \
    --name ${APP_NAME} \
    -p ${HOST_PORT}:8080 \
    --restart=always \
    ${IMAGE_NAME}

# 6. 滚动更新核心：健康检查
echo "🏥 正在进行健康检查..."
MAX_RETRIES=30
RETRY_COUNT=0

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    # 尝试访问健康检查接口
    # 使用 curl -f 模式，如果返回非200状态码会报错
    if curl -f -s ${HEALTH_URL} > /dev/null 2>&1; then
        echo "✅ 健康检查通过！新服务运行正常。"

        # 7. 清理旧容器
        if [ -n "${OLD_CONTAINER_ID}" ]; then
            echo "🧹 正在停止并删除旧容器: ${OLD_CONTAINER_ID}"
            docker stop ${OLD_CONTAINER_ID}
            docker rm ${OLD_CONTAINER_ID}
            # (可选) 删除旧镜像以节省空间
            # docker rmi $(docker images | grep ${APP_NAME} | grep none | awk '{print $3}')
        fi
        echo "🎉 部署成功！"
        exit 0
    else
        echo "⏳ 等待服务启动... (${RETRY_COUNT}/${MAX_RETRIES})"
        sleep 2
        RETRY_COUNT=$((RETRY_COUNT + 1))
    fi
done

# 8. 部署失败处理 (回滚/报警)
echo "❌ 健康检查超时！新容器启动失败。"
echo "⚠️ 保留旧容器（如果存在），请检查日志。"
# 如果新容器起不来，我们把它删了，让旧容器继续跑（如果旧容器还在的话）
docker stop ${APP_NAME}
docker rm ${APP_NAME}

# 如果旧容器ID存在且处于停止状态，尝试重启它（简单的回滚逻辑）
if [ -n "${OLD_CONTAINER_ID}" ] && [ "$(docker inspect -f '{{.State.Status}}' ${OLD_CONTAINER_ID})" == "exited" ]; then
     echo "🔄 尝试恢复旧版本..."
     docker start ${OLD_CONTAINER_ID}
fi

exit 1