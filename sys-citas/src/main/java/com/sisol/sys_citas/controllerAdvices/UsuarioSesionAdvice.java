package com.sisol.sys_citas.controllerAdvices;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.sisol.sys_citas.viewmodels.UsuarioSesion;

import jakarta.servlet.http.HttpSession;

@ControllerAdvice
public class UsuarioSesionAdvice {


    @ModelAttribute
    public void mantenerSesionUsuario(Model model, HttpSession session){
        
        //obtener la session del usuario
        UsuarioSesion usuarioSesion =(UsuarioSesion) session.getAttribute("usuario");
        
        if (usuarioSesion != null) {
            model.addAttribute("usuarioSesion", usuarioSesion);    
        }
    }
    
}
