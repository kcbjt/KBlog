#!/bin/bash

# 定义颜色
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 默认目标
TARGET="all"

# 解析命令行参数
# 允许使用 ./update.sh api 或 ./update.sh --target=api
if [ $# -gt 0 ]; then
    case "$1" in
        api)
            TARGET="blog-api"
            ;;
        view)
            TARGET="blog-view"
            ;;
        cms)
            TARGET="blog-cms"
            ;;
        all)
            TARGET="all"
            ;;
        help|-h|--help)
            echo -e "${GREEN}用法: $0 [选项]${NC}"
            echo "  all   - 更新所有服务 (默认)"
            echo "  api   - 仅更新后端服务 (跳过数据库重启)"
            echo "  view  - 仅更新前台前端"
            echo "  cms   - 仅更新后台前端"
            echo "  help  - 显示此帮助信息"
            exit 0
            ;;
        *)
            echo -e "${RED}错误: 未知参数 '$1'${NC}"
            echo -e "${YELLOW}提示: 运行 './update.sh help' 查看可用选项${NC}"
            exit 1
            ;;
    esac
fi

echo -e "${GREEN}=== 开始更新服务: ${TARGET} ===${NC}"

# 执行更新
# 如果 TARGET 是 "all"，则不指定服务名，默认更新所有
# 如果 TARGET 是具体服务名，则只更新该服务
if [ "$TARGET" == "all" ]; then
    echo -e "${GREEN}[1/3] 正在构建并重启所有容器...${NC}"
    docker-compose up -d --build
else
    echo -e "${GREEN}[1/3] 正在构建并重启 ${TARGET}...${NC}"
    docker-compose up -d --build "$TARGET"
fi

# 清理悬空镜像
echo -e "${GREEN}[2/3] 清理无用镜像...${NC}"
docker image prune -f

# 显示日志
echo -e "${GREEN}[3/3] 更新完成！显示最新日志 (Ctrl+C 退出)...${NC}"

if [ "$TARGET" == "all" ]; then
    docker-compose logs -f --tail=50
else
    docker-compose logs -f --tail=50 "$TARGET"
fi