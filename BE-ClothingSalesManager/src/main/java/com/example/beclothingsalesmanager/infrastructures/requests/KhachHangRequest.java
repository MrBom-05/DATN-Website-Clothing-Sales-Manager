package com.example.beclothingsalesmanager.infrastructures.requests;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class KhachHangRequest {
    @NotNull(message = "Mã giảm giá không được để trống")
    private String hoVaTen;
}
