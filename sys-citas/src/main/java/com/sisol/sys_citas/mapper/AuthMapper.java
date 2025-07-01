package com.sisol.sys_citas.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sisol.sys_citas.dto.UsuarioSesionDTO;






@Mapper
public interface AuthMapper {
    UsuarioSesionDTO verificarCorreo(@Param("correo")String correo);
}
