package com.sisol.sys_citas.entities;

import com.sisol.sys_citas.enums.AreaAdministrativa;
import com.sisol.sys_citas.enums.CargoAdministrativo;
import com.sisol.sys_citas.enums.TipoContrato;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "personal_administrativo")
@Getter
@Setter
public class PersonalAdministrativo extends Usuario {
    
    @Enumerated(EnumType.STRING)
    @Column(name = "cargo")
    private CargoAdministrativo cargo;
    
    @Enumerated(EnumType.STRING)
    @Column(name ="tipo_contrato")
    private TipoContrato contrato;

    @Enumerated(EnumType.STRING)
    @Column(name ="area")
    private AreaAdministrativa area;

    public PersonalAdministrativo() {
    }

    //getter and setters con lombook

    

}
