package com.sisol.sys_citas.entities;
import java.time.LocalDate;
import java.time.LocalDateTime;
import com.sisol.sys_citas.enums.EstadoCivil;
import com.sisol.sys_citas.enums.Rol;
import com.sisol.sys_citas.enums.Sexo;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "paciente")
@Getter
@Setter
public class Paciente extends Usuario {

    private String dni;
    private String telefono;
    @Enumerated(EnumType.STRING)
    @Column(name = "sexo")
    private Sexo sexo;
    @Column(name = "fecha_nacimiento")
    private LocalDate fechaNacimiento;

    @Enumerated(EnumType.STRING)
    @Column(name = "estado_civil")
    private EstadoCivil estadoCivil;

    private String direccion;

    @Column(name = "contacto_emergencia_nombre")
    private String contadoEmergenciaNombre;

    @Column(name = "contacto_emergencia_telefono")
    private String contactoEmergenciaTelefono;

    public Paciente() {
    }

    public Paciente(Long id, String nombres, String apellidoParterno, String apellidoMaterno, Rol rol,
            LocalDateTime fecha_registro, LocalDateTime fecha_actualizacion, Boolean activo, String correo,
            String password, String dni, String telefono, Sexo sexo, LocalDate fechaNacimiento, EstadoCivil estadoCivil,
            String direccion, String contadoEmergenciaNombre, String contactoEmergenciaTelefono) {
        super(id, nombres, apellidoParterno, apellidoMaterno, rol, fecha_registro, fecha_actualizacion, activo, correo,
                password);

        this.dni = dni;
        this.telefono = telefono;
        this.sexo = sexo;
        this.fechaNacimiento = fechaNacimiento;
        this.estadoCivil = estadoCivil;
        this.direccion = direccion;
        this.contadoEmergenciaNombre = contadoEmergenciaNombre;
        this.contactoEmergenciaTelefono = contactoEmergenciaTelefono;
    }

}
