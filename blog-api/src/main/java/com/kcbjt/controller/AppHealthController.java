package com.kcbjt.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AppHealthController {

    @RequestMapping("/actuator/health")
    public String health() {
        return "OK";
    }
}
