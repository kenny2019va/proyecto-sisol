package com.sisol.sys_citas.entities;

import java.time.LocalDateTime;

import com.sisol.sys_citas.enums.GrupoSanguineo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "historia_clinica")
@Getter
@Setter
public class HistoriaClinica {
    @Id
    private Long id;
    //relacion con paciente, llave compartida
    @OneToOne
    @MapsId
    @JoinColumn(name = "id")
    private Paciente paciente;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "grupo_sanguineo")
    private GrupoSanguineo grupoSanguineo;
    @Column(name = "alergias")
    private String alergias;
    @Column(name = "enfermedades_cronicas")
    private String enfermedadesCronicas;
    @Column(name = "antecedentes_personales")
    private String antecendentesPersonales;
    @Column(name = "antecedentes_familiares")
    private String antecedentesFamiliares;
    @Column(name = "medicacion_actual")
    private String medicacionActual;
    @Column(name = "discapacidad")
    private String discapacidad;
    @Column(name = "vacunacion")
    private String vacunacion;
    @Column(name = "fecha_creacion")
    private LocalDateTime fechaCreacion;
    @Column(name = "fecha_actualizacion")
    private LocalDateTime fechaActualizacion;
    
    //constructor
    public HistoriaClinica() {
    }

    //getter and setters con lombook


    


}
