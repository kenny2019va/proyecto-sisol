package com.sisol.sys_citas.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sisol.sys_citas.entities.Paciente;



public interface PacienteRepository  extends JpaRepository<Paciente, Long>{
    boolean existsByDni(String dni);
}
