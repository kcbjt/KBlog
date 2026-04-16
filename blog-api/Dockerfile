# =======================================================
# 第一阶段：构建阶段（使用 Maven 编译 Spring Boot）
# =======================================================
FROM maven:3.9-eclipse-temurin-21 AS builder
WORKDIR /app

# 1. 利用 Docker 缓存层，先复制 pom.xml 下载依赖
COPY pom.xml .
RUN mvn dependency:go-offline

# 2. 复制源码并打包
COPY src ./src
# 打包时跳过测试，加快速度
RUN mvn clean package -DskipTests

# =======================================================
# 第二阶段：运行阶段（轻量级 JRE）
# =======================================================
FROM eclipse-temurin:21-jre-alpine

# 1. 维护者信息
LABEL maintainer="kcbjt"

# 2. 设置环境变量
# 设置时区为上海（避免日志时间差 8 小时）
ENV TZ=Asia/Shanghai
# 定义日志目录变量，方便后续维护
ENV LOG_PATH=/app/log

# 3. 创建非 root 用户（安全最佳实践）
RUN addgroup -S zpaas && adduser -S zpaas -G zpaas

# 4. 设置工作目录
WORKDIR /app

# 5. 从构建阶段复制 jar 包
COPY --from=builder /app/target/*.jar app.jar

# 6. 创建日志目录并授权给 spring 用户
RUN mkdir -p ${LOG_PATH} && chown -R zpaas:zpaas ${LOG_PATH}

# 7. 暴露端口
EXPOSE 8080

# 8. 切换用户
USER zpaas

# 9. 启动命令
# -Xms512m -Xmx512m: 设置堆内存初始值和最大值（防止动态扩容消耗性能）
# -XX:+UseG1GC: 启用 G1 垃圾回收器
# -Duser.timezone: 强制指定时区
# -Dlogging.file.path: Spring Boot 参数，指定日志输出路径
ENTRYPOINT ["java", \
            "-Xms512m", \
            "-Xmx512m", \
            "-XX:+UseG1GC", \
            "-Duser.timezone=Asia/Shanghai", \
            "-Dlogging.file.path=/app/log", \
            "-jar", "app.jar"]