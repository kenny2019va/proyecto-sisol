package com.sisol.sys_citas.viewmodels;

import com.sisol.sys_citas.enums.Rol;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@NoArgsConstructor
@Getter
@Setter


public class UsuarioSesion {
    private Long id;
    private String nombres;
    private Rol rol;
}
