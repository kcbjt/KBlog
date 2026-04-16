package com.kcbjt.config.properties;

import io.minio.MinioClient;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "minio")
public class MinioProperties {
    private String endpoint;
    private String accessKey;
    private String secretKey;
    private String bucket;
    private String uploadDir;
    private boolean usePresignedUrl = true;
    private int presignedExpiry = 300;

    // getters and setters (省略，请自行生成)

    public String getEndpoint() {
        return endpoint;
    }

    public void setEndpoint(String endpoint) {
        this.endpoint = endpoint;
    }

    public String getAccessKey() {
        return accessKey;
    }

    public void setAccessKey(String accessKey) {
        this.accessKey = accessKey;
    }

    public String getSecretKey() {
        return secretKey;
    }

    public void setSecretKey(String secretKey) {
        this.secretKey = secretKey;
    }

    public String getBucket() {
        return bucket;
    }

    public void setBucket(String bucket) {
        this.bucket = bucket;
    }

    public String getUploadDir() {
        return uploadDir;
    }

    public void setUploadDir(String uploadDir) {
        this.uploadDir = uploadDir;
    }

    public boolean isUsePresignedUrl() {
        return usePresignedUrl;
    }

    public void setUsePresignedUrl(boolean usePresignedUrl) {
        this.usePresignedUrl = usePresignedUrl;
    }

    public int getPresignedExpiry() {
        return presignedExpiry;
    }

    public void setPresignedExpiry(int presignedExpiry) {
        this.presignedExpiry = presignedExpiry;
    }
}
