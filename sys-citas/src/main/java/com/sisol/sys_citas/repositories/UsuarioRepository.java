package com.sisol.sys_citas.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sisol.sys_citas.entities.Usuario;

import java.util.Optional;


public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

    Optional<Usuario> findByCorreo(String correo);
    
}
