package com.cykt.app.controller;

import com.cykt.app.persistence.ChefRepository;
import com.cykt.dto.Chef;
import com.cykt.mapper.ChefMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequestMapping("/chef")
@RequiredArgsConstructor
public class ChefController {
    private final ChefRepository chefRepository;

    @GetMapping("{chefName}")
    public Chef getByname(@PathVariable String chefName) {
        return new Chef(chefRepository.findByName(chefName).orElseThrow().getName());
    }
}
