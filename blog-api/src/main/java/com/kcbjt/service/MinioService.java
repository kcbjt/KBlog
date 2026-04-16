package com.kcbjt.service;

import org.springframework.web.multipart.MultipartFile;

public interface MinioService {

    public String uploadFile(MultipartFile file) throws Exception;

}
