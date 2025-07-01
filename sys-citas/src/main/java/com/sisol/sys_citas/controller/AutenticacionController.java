package com.sisol.sys_citas.controller;

import java.sql.SQLDataException;
import java.sql.SQLException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sisol.sys_citas.exceptions.AutenticacionException;
import com.sisol.sys_citas.forms.LoginForm;
import com.sisol.sys_citas.security.AutenticacionService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/auth")
public class AutenticacionController {

    private final AutenticacionService autenticacionService;

    public AutenticacionController(AutenticacionService autenticacionService) {
        this.autenticacionService = autenticacionService;
    }

    @GetMapping("/login")
    public String mostrarLogin(Model model) {
        model.addAttribute("loginForm", new LoginForm());
        return "/login";
    }

    @PostMapping("/login")
    public String procesarLogin(@ModelAttribute("loginForm") LoginForm form, HttpSession session,
            RedirectAttributes ra) {

        try {
            session.setAttribute("usuario", autenticacionService.login(form));
            return "redirect:/inicio";

        } catch (AutenticacionException ex) {
            ra.addFlashAttribute("error", ex.getMessage());
            return "redirect:/auth/login";
        }
        catch(Exception ex){
             ra.addFlashAttribute("error", "error en el sistema");
            return "redirect:/auth/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/auth/login";
    }

}
