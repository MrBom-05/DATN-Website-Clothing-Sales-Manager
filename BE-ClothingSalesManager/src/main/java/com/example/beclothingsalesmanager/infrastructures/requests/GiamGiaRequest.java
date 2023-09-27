package com.example.beclothingsalesmanager.infrastructures.requests;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PastOrPresent;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class GiamGiaRequest {
    @NotNull(message = "Mã giảm giá không được để trống")
    private Integer ma;

    @NotNull(message = "Số phần trăm giảm không được để trống")
    @Min(0)
    private Integer soPhamTramGiam;

    @NotNull(message = "Ngày kết thúc không được để trống")
    @PastOrPresent(message = "Ngày kết thúc không được nhỏ hơn ngày hiện tại")
    private LocalDate ngayKetThuc;

}
