# =======================
# 阶段 1: 构建前台 (blog-view)
# =======================
FROM node:18-alpine AS frontend-view
WORKDIR /app/view
COPY blog-view/package.json ./
RUN npm install --registry=https://registry.npmmirror.com
COPY blog-view .
RUN npm run build

# =======================
# 阶段 2: 构建后台 (blog-cms)
# =======================
FROM node:18-alpine AS frontend-cms
WORKDIR /app/cms
COPY blog-cms/package.json ./
RUN npm install --registry=https://registry.npmmirror.com
COPY blog-cms .
RUN npm run build

# =======================
# 阶段 3: 构建后端 (Spring Boot + JDK 21)
# =======================
# 使用 Maven 镜像进行编译
FROM maven:3.9-eclipse-temurin-21 AS builder
WORKDIR /app
COPY blog-api/pom.xml .
RUN mvn dependency:go-offline
COPY blog-api/src ./src

# 【关键步骤】将构建好的前端静态资源复制到后端资源目录
# 假设你的 Vue 打包后生成在 dist 目录，这里复制到 static/view 和 static/cms
COPY --from=frontend-view /app/view/dist ./src/main/resources/static/view
COPY --from=frontend-cms /app/cms/dist ./src/main/resources/static/cms

# 打包 Spring Boot (跳过测试)
RUN mvn clean package -DskipTests

# =======================
# 阶段 4: 运行环境 (JRE 21 - 轻量级)
# =======================
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
# 复制构建好的 jar 包
COPY --from=builder /app/target/blog-api-*.jar app.jar

# 暴露端口
EXPOSE 8080

# 启动命令 (适配容器内存限制)
# -XX:MaxRAMPercentage=75.0 表示 JVM 最大使用容器内存的 75%
ENTRYPOINT ["java", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]