package com.sisol.sys_citas.entities;

import java.time.LocalDate;
import java.time.LocalTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "disponibilidad")
@Getter
@Setter
public class Disponibilidad {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    // relacion unidireccional 
    @ManyToOne
    @JoinColumn(name = "medico_id")
    private Medico medico;
    
    @Column(name="fecha_disponibilidad")
    private LocalDate fechaDisponible;
    @Column(name = "hora_inicio")
    private LocalTime horaInicio;
    @Column(name = "hora_fin" )
    private LocalTime horaFin;
    @Column(columnDefinition = "TINYINT(1)")
    private Boolean disponible;

    
    public Disponibilidad(){

    }

    public Boolean isDisponible(){
        return this.disponible;
    }


    




    
}
