package com.sisol.sys_citas.entities;



import java.time.LocalDateTime;

import com.sisol.sys_citas.enums.EstadoAtencion;

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
@Table(name="atencion_medica")
@Getter
@Setter 
public class AtencionMedica {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    //unidireccional
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval=true)
    @JoinColumn(name = "cita_id")
    private Cita cita;

    //unidireccional
    @ManyToOne
    @JoinColumn(name = "medico_id")
    private Medico medico;

    @Column(name = "motivo_consulta")
    private String motivoConsulta;

    private String diagnostico;
    private String tratamiento;
    private String recomendaciones;
    @Column(name = "fecha_atencion")
    private LocalDateTime fechaAtencion;
    @Enumerated(EnumType.STRING)                                                    
    @Column(name = "estado")
    private EstadoAtencion estadoAtencion;

    public AtencionMedica(){
        
    }


    
}
