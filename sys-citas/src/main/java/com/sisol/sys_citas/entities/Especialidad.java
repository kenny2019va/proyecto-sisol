package com.sisol.sys_citas.entities;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="especialidad")
@Getter
@Setter
public class Especialidad {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nombre;
    private String descripcion;
    @Column(name = "fecha_creacion")
    private LocalDateTime fechaCreacion;



    // realacion one to many unidireccional
    @OneToMany(cascade = CascadeType.ALL  ,orphanRemoval = true)
    @JoinColumn(name = "especialidad_id")
    private List<ServicioMedico> servicios;

    //constructor
    public Especialidad() {
    }

    //helpers
    public void addServicio(ServicioMedico servicioMedico){
        this.servicios.add(servicioMedico);
    }
    public void removeServicio(ServicioMedico servicioMedico){
        this.servicios.remove(servicioMedico);
    }



    

    
}
