package com.sisol.sys_citas.controller;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
@RequestMapping("/inicio")
public class InicioController {
    
    @GetMapping()
    public String mostrarInicio(){
        return "inicio";
    }
}
