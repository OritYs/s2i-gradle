package com.example;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class HelloController {

    @Value("${hello.world.msg}")
    private String helloMsg;

    @RequestMapping("/")
    public String index() {
        return helloMsg;
    }

}