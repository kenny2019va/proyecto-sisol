package com.sisol.sys_citas.entities;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "servicio")
@Getter
@Setter
public class ServicioMedico {  
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String descripcion;
    @Column(name = "precio_servicio")
    private BigDecimal precioServicio;

    @Column(name = "fecha_actualizacion")
    private LocalDateTime  fechaCreacion;
    
    @Column(name = "fecha_creacion")
    private LocalDateTime fechaActualizacion;

    
    @ManyToMany(mappedBy = "servicios")
    private List<Medico> medicos = new ArrayList<>();


    public ServicioMedico() {
    }


    //helpers

    



    

    
}
