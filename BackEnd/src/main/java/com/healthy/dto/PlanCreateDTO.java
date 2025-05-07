package com.healthy.dto;

import com.healthy.model.enums.PlanStatus;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class PlanCreateDTO {
    private String planName;
    private String description;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private PlanStatus status;
}
