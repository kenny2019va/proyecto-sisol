package com.sisol.sys_citas;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.sisol.sys_citas.enums.Rol;
import com.sisol.sys_citas.viewmodels.UsuarioSesion;



@SpringBootApplication
public class SysCitasApplication {

	public static void main(String[] args) {
		SpringApplication.run(SysCitasApplication.class, args);

		
		UsuarioSesion usuarioSesion = new UsuarioSesion();

		usuarioSesion.setRol(Rol.ROLE_PACIENTE);
		
	}

}
