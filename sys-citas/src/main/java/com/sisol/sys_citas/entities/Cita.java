package com.sisol.sys_citas.entities;

import java.time.LocalDateTime;



import com.sisol.sys_citas.enums.EstadoCita;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "cita")
@Getter
@Setter
public class Cita {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // unidireccional
    @ManyToOne
    @JoinColumn(name = "paciente_id")
    private Paciente paciente;
    
    // unidireccional
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval=true)
    @JoinColumn(name = "disponibilidad_id")
    private Disponibilidad disponibilidad;

    // unidireccional
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval=true)
    @JoinColumn(name = "pago_id")
    private Pago pago;

    @Column(name = "fecha_creacion")
    private LocalDateTime fechaCreacion;
    @Column(name = "fecha_actualizacion")
    private LocalDateTime fechaActualiacion;    
    
    @Enumerated(EnumType.STRING)
    @Column(name = "estado")
    private EstadoCita estadoCita;


    public Cita(){


    }

    




    

    
}
