package com.example.websitebanquanao.configs;

import com.example.websitebanquanao.infrastructures.filters.UserFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.boot.web.servlet.FilterRegistrationBean;

public class AppConfig {
    @Bean
    public FilterRegistrationBean<UserFilter> userSessionFilter() {
        FilterRegistrationBean<UserFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new UserFilter());
        registrationBean.addUrlPatterns("/gio-hang/*");
        registrationBean.addUrlPatterns("/hoa-don/*");
        return registrationBean;
    }
}
