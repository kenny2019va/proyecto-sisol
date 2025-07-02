package com.sisol.sys_citas.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/inicio")
public class InicioController {
    
    @GetMapping()
    public String mostrarInicio(Model model, HttpSession session){
        model.addAttribute("usuario", session.getAttribute("usuario"));
        return "inicio";
    }
}
