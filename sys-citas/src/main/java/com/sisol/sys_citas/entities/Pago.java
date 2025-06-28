package com.sisol.sys_citas.entities;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.sisol.sys_citas.enums.Comprobante;
import com.sisol.sys_citas.enums.EstadoPago;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "pago")
@Getter
@Setter
public class Pago {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private BigDecimal monto;
    @Column(name = "fecha_pago")
    private LocalDateTime fechaPago;
    @Column(name = "codigo_transaccion")
    private Long codigoTransaccion;
    
    //estados
    @Enumerated(EnumType.STRING)
    @Column(name="estado")
    private EstadoPago estadoPago;
    
    @Enumerated(EnumType.STRING)
    @Column(name="comprobante")
    private Comprobante comprobante;

    public Pago (){

    }
    // pendiente asociar a cita 


}
