package com.sisol.sys_citas.entities;

import java.time.LocalDateTime;
import com.sisol.sys_citas.enums.Rol;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Inheritance;
import jakarta.persistence.InheritanceType;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "usuario")
@Getter
@Setter
public class Usuario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nombres;
    @Column(name = "apellido_paterno")
    private String apellidoParterno;
    @Column(name = "apellido_materno")
    private String apellidoMaterno;
    @Enumerated(EnumType.STRING)
    @Column(name = "rol")
    private Rol rol;
    @Column(name = "fecha_registro")
    private LocalDateTime fecha_registro;
    @Column(name = "fecha_actualizacion")
    private LocalDateTime fecha_actualizacion;
    @Column(columnDefinition = "TINYINT(1)")
    private Boolean activo;
    
    // credenciales
    private String correo;
    @Column(name = "password")
    private String password;

    public Usuario() {
    }

    public Usuario(Long id, String nombres, String apellidoParterno, String apellidoMaterno, Rol rol,
            LocalDateTime fecha_registro, LocalDateTime fecha_actualizacion, Boolean activo, String correo,
            String password) {
        this.id = id;
        this.nombres = nombres;
        this.apellidoParterno = apellidoParterno;
        this.apellidoMaterno = apellidoMaterno;
        this.rol = rol;
        this.fecha_registro = fecha_registro;
        this.fecha_actualizacion = fecha_actualizacion;
        this.activo = activo;
        this.correo = correo;
        this.password = password;
    }

    public Boolean isActivo() {
        return activo;
    }

}
