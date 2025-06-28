package com.sisol.sys_citas.entities;


import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import com.sisol.sys_citas.enums.TurnoMedico;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "medico")
@Getter
@Setter
public class Medico extends Usuario {
    @Column(name = "numero_colegiado")
    private String numeroColegiado;

    @Enumerated(EnumType.STRING)
    @Column(name = "turno")
    TurnoMedico turno;

    @Column(name = "hora_inicio_turno")
    private LocalTime horaInicioTurno;

    @Column(name = "hora_fin_turno")
    private LocalTime horaFinTurno;

    @Column(name = "codigo_interno")
    private String codigoInterno;

    // relacion many to one unidireccional
    @ManyToOne
    @JoinColumn(name = "especialidad_id")
    private Especialidad especialidad;

    // relacion many to many
    @ManyToMany
    @JoinTable(name = "medico_servicio", 
    joinColumns = @JoinColumn(name = "medico_id", referencedColumnName = "id"), 
    inverseJoinColumns = @JoinColumn(name = "servicio_id", referencedColumnName = "id"), 
    uniqueConstraints = {
            @UniqueConstraint(columnNames = { "medico_id", "servicio_id" }) })
    private List<ServicioMedico> servicios = new ArrayList<>();

    // constructor
    
    public Medico() {
    }

    //helpers- sincronizacion bidireccional
    public void addServicio(ServicioMedico servicioMedico){
        servicios.add(servicioMedico);
        servicioMedico.getMedicos().add(this);
    }
    public void removeServicio(ServicioMedico servicioMedico){
        servicios.remove(servicioMedico);
        servicioMedico.getMedicos().remove(this);
    }

    // getter and setters con lombook

}
