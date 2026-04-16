#!/bin/bash

# 定义颜色，方便输出
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== 开始一键部署 Blog 系统 ===${NC}"

# 1. 检查 Docker 是否安装
if ! command -v docker &> /dev/null; then
    echo -e "${RED}错误: Docker 未安装，请先安装 Docker${NC}"
    exit 1
fi

# 2. 停止并删除现有容器及网络
echo -e "${GREEN}[1/4] 清理旧容器...${NC}"
docker-compose down

# 3. (可选) 删除旧镜像，强制重新构建
# 如果不希望删除旧镜像（为了利用缓存），可以注释掉下面这行
echo -e "${GREEN}[2/4] 删除旧镜像...${NC}"
docker rmi $(docker images | grep "blog-" | awk '{print $3}') 2>/dev/null || true

# 4. 重新构建所有服务
# --no-cache: 不使用缓存，确保构建的是最新代码（如果需要增量构建请去掉此参数）
echo -e "${GREEN}[3/4] 构建新镜像 (这可能需要几分钟)...${NC}"
docker-compose build --no-cache

# 5. 启动服务
echo -e "${GREEN}[4/4] 启动服务...${NC}"
docker-compose up -d

# 6. 检查状态
echo -e "${GREEN}=== 部署完成！正在检查服务状态... ===${NC}"
docker-compose ps

echo -e "${GREEN}提示: 如果是首次部署，数据库正在初始化，请稍等片刻查看日志。${NC}"