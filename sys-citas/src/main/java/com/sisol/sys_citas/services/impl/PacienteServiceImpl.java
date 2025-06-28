package com.sisol.sys_citas.services.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sisol.sys_citas.clients.reciec.dto.ResponseClientReniecDTO;
import com.sisol.sys_citas.clients.reciec.service.ClientReniecApiService;
import com.sisol.sys_citas.exceptions.PacienteException;
import com.sisol.sys_citas.repositories.PacienteRepository;
import com.sisol.sys_citas.services.PacienteService;



@Service
public class PacienteServiceImpl implements PacienteService {

    private final ClientReniecApiService clientReniecApiService;
    private final PacienteRepository pacienteRepository;

    public PacienteServiceImpl(PacienteRepository pacienteRepository, ClientReniecApiService clientReniecApiService){
        this.pacienteRepository = pacienteRepository;
        this.clientReniecApiService = clientReniecApiService;
    }
    

    @Override
    @Transactional(readOnly = true)
    public ResponseClientReniecDTO validarDni(String dni) {

        if (pacienteRepository.existsByDni(dni)) {
            throw new PacienteException("El DNI ya se encuentra registrado");
        }
        return clientReniecApiService.identificarPersonaPorDni(dni);
    }

    






    
}
