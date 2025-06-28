package com.sisol.sys_citas.security;

import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sisol.sys_citas.entities.Usuario;
import com.sisol.sys_citas.exceptions.AutenticacionException;
import com.sisol.sys_citas.forms.LoginForm;
import com.sisol.sys_citas.repositories.UsuarioRepository;

import com.sisol.sys_citas.viewmodels.UsuarioSesion;

@Service
public class AutenticacionService {

    // inyectar las dependencias
    private final UsuarioRepository usuarioRepository;
    public AutenticacionService(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }


    @Transactional
    public UsuarioSesion login(LoginForm loginForm) {

        Optional<Usuario> optional = usuarioRepository.findByCorreo(loginForm.getCorreo());

        // si el usuario no existe o la contraseña ingresada no coincide con la del
        // usuario de la bd
        // if (optional.isEmpty()
        //         || !PasswordHashUtils.checkPassword(loginForm.getPassword(), optional.get().getPassword())) {
        //     throw new AutenticacionException("Correo y/o contraseña incorrecto");
        // }
        // capturar el usuario de la bd
        
        if (optional.isEmpty() || !optional.get().getPassword().equals(loginForm.getPassword())) {
            throw new AutenticacionException("Correo y/o contraseña incorrecto");   
        }
        
        Usuario usuario = optional.get();


        // si  la cuenta del usuario esta inactivo
        if (!usuario.isActivo()) {
            throw new AutenticacionException("Su cuenta se encuentra inactiva");    
        }
        // crear un objeto con datos necesario para la sesion
        UsuarioSesion usuarioSesion = new UsuarioSesion();
        usuarioSesion.setId(usuario.getId());
        usuarioSesion.setNombres(usuario.getNombres());
        usuarioSesion.setRol(usuario.getRol());
        return usuarioSesion;

    }

}
