package com.sisol.sys_citas.security.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.sisol.sys_citas.security.AutorizacionInterceptor;


@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    private final AutorizacionInterceptor autorizacionInterceptor;

    public WebMvcConfig(AutorizacionInterceptor autorizacionInterceptor){
        this.autorizacionInterceptor = autorizacionInterceptor;
    }

    // registar el interceptor
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(autorizacionInterceptor)
        
        .addPathPatterns("/**")
        //no aplicar el  interceptor en estas rutas
        .excludePathPatterns("/auth/**","/css/**","/js/**","/paciente/registrar","/paciente/consultar/*");
    }
    
}
