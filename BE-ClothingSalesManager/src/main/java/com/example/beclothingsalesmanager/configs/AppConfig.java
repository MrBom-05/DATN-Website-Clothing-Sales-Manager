package com.example.beclothingsalesmanager.configs;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class AppConfig {
    // Cấu hình với react js
    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**") // Áp dụng cấu hình cho tất cả các endpoint
                        .allowedOrigins("http://localhost:3000") // Tên miền của ứng dụng React
                        .allowedMethods("GET", "POST", "PUT", "DELETE") // Cho phép tất cả các phương thức
                        .allowCredentials(true);
            }
        };
    }
}
