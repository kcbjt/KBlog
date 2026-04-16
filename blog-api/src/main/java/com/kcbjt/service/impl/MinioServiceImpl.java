package com.kcbjt.service.impl;

import com.kcbjt.config.properties.MinioProperties;
import com.kcbjt.service.MinioService;
import io.minio.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@Service
public class MinioServiceImpl implements MinioService {

    @Autowired
    private MinioClient minioClient;

    @Autowired
    private MinioProperties minioProps;

    /**
     * 上传文件到 MinIO，返回可访问的 URL
     * @param file 上传的文件
     * @return 文件访问 URL
     */
    public String uploadFile(MultipartFile file) throws Exception {
        // 1. 确保桶存在，不存在则创建
        boolean bucketExists = minioClient.bucketExists(BucketExistsArgs.builder()
                .bucket(minioProps.getBucket()).build());
        if (!bucketExists) {
            minioClient.makeBucket(MakeBucketArgs.builder()
                    .bucket(minioProps.getBucket()).build());
            // 创建桶后，设置为公开读取（仅在 usePresignedUrl = false 时执行）
            if (!minioProps.isUsePresignedUrl()) {
                String policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":[\"s3:GetObject\"],\"Resource\":[\"arn:aws:s3:::" + minioProps.getBucket() + "\"/*\"]}]}";
                minioClient.setBucketPolicy(SetBucketPolicyArgs.builder()
                        .bucket(minioProps.getBucket())
                        .config(policy)
                        .build());
            }
        }

        // 2. 构建对象名称：目录/日期/UUID_原始文件名
        String dateDir = LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE);
        String originalFilename = file.getOriginalFilename();
        String extension = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String objectName = String.format("%s/%s/%s%s",
                minioProps.getUploadDir(),
                dateDir,
                UUID.randomUUID().toString().replace("-", ""),
                extension);

        // 3. 上传文件
        try (InputStream inputStream = file.getInputStream()) {
            minioClient.putObject(PutObjectArgs.builder()
                    .bucket(minioProps.getBucket())
                    .object(objectName)
                    .stream(inputStream, file.getSize(), -1L)
                    .contentType(file.getContentType())
                    .build());
        } catch (IOException e) {
            throw new RuntimeException("文件读取失败", e);
        }

        // 返回直链
        String endpoint = minioProps.getEndpoint().endsWith("/") ?
                minioProps.getEndpoint() : minioProps.getEndpoint() + "/";
        return endpoint + minioProps.getBucket() + "/" + objectName;
    }
}
