package com.sisol.sys_citas.controller;


import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sisol.sys_citas.clients.reciec.service.ClientReniecApiService;

//se eliminará
@RestController
@RequestMapping("/clientes")
public class ClientReniecController {
    private final ClientReniecApiService clientReniecApiService;


    public ClientReniecController(ClientReniecApiService clientReniecApiService){
        this.clientReniecApiService = clientReniecApiService;

    }

    @GetMapping("/reniec/{dni}")
    public ResponseEntity<?> buscarPorDni(@PathVariable String dni){
        try {
            return ResponseEntity.ok().body(clientReniecApiService.identificarPersonaPorDni(dni));   
        } 
        catch(RuntimeException ex){
            return ResponseEntity.badRequest().body(ex.getMessage());
            
        }
        
    }

}
