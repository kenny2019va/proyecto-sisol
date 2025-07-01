package com.sisol.sys_citas.security;

import java.util.Optional;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.sisol.sys_citas.dto.UsuarioSesionDTO;
import com.sisol.sys_citas.enums.Rol;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class AutorizacionInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        // obtenemos la url de la solicitud
        String uri = request.getRequestURI();
        // si interceptas una de estas rutas no realizar una validacion
        // if (uri.startsWith("/auth") || uri.startsWith("/css") || uri.startsWith("/js")) {
        //     return true;
        // }

        // obtenemos la sesion vigente
        Optional<HttpSession> optional = Optional.ofNullable(request.getSession(false));

        // evaluar si existe una session vigente
        if (optional.isEmpty()) {
            response.sendRedirect("/auth/login");
            return false;
        }

        // obtener el objeto usuario de la sesion vigente
        UsuarioSesionDTO usuario = (UsuarioSesionDTO) optional.get().getAttribute("usuario");
       
        //ruta comun para los 3
        if (uri.startsWith("/inicio") && (usuario.getRol()
        .equals(Rol.ROLE_PACIENTE) ||usuario.getRol().equals(Rol.ROLE_MEDICO) || usuario.getRol().equals(Rol.ROLE_PERSONAL_ADMINISTRATIVO) ) ){
            return true;
        }

        // evaluamos el rol para denegar los accesos si no corresponde a su rol
        if (uri.startsWith("/paciente") && usuario.getRol() != Rol.ROLE_PACIENTE) {
            response.sendRedirect("/auth/login");
            return false;
        }

        if (uri.startsWith("/medico") && usuario.getRol()!= Rol.ROLE_MEDICO ) {
            response.sendRedirect("/auth/login");
            return false;
        }

        if (uri.startsWith("/administrativo") && usuario.getRol() != Rol.ROLE_PERSONAL_ADMINISTRATIVO) {
            response.sendRedirect("/auth/login");
            return false;
        }
        
        //
        return true;
    }

}
