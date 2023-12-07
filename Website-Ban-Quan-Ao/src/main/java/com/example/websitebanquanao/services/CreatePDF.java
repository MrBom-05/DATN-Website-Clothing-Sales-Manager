package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.HoaDon;
import com.example.websitebanquanao.infrastructures.responses.GioHangUserResponse;
import com.itextpdf.text.Font;
import com.itextpdf.text.pdf.PdfPCell;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import java.io.FileOutputStream;
import java.util.List;

@Service
public class CreatePDF {

    public void exportPDFBill(HoaDon hoaDon, List<GioHangUserResponse> listHoaDonChiTiet, String tongTien) {
        try {
            String fileName = hoaDon.getMa() + ".pdf";
            String filePath = "src/main/java/com/example/websitebanquanao/bills" + "/" + fileName;

            Font font = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);

            Document document = new Document();
            PdfWriter.getInstance(document, new FileOutputStream(filePath));
            document.open();

            document.add(new Paragraph("Hoá đơn Leninn", font));
            document.add(new Paragraph("----------------------------------------------------------------------------------------------------------------------------------"));

            document.add(new Paragraph("Mã hoá đơn: " + hoaDon.getMa(), font));
            document.add(new Paragraph("Tên Khách hàng: " + hoaDon.getIdKhachHang().getHoVaTen(), font));
            document.add(new Paragraph("Số điện thoại: " + hoaDon.getSoDienThoai(), font));
            document.add(new Paragraph("Địa chỉ: " + hoaDon.getDiaChi() + ", " + hoaDon.getXaPhuong() + ", " + hoaDon.getQuanHuyen() + ", " + hoaDon.getTinhThanhPho(), font));
            document.add(new Paragraph("Ghi Chú: " + hoaDon.getGhiChu(), font));
            document.add(new Paragraph("Nhân Viên: " + (hoaDon.getIdNhanVien() != null ? hoaDon.getIdNhanVien().getHoVaTen() : "Không có nhân viên"), font));
            document.add(new Paragraph("Ngày Tạo: " + hoaDon.getNgayTao(), font));

            document.add(new Paragraph("----------------------------------------------------------------------------------------------------------------------------------"));
            document.add(new Paragraph(" "));

            PdfPTable table = new PdfPTable(5);
            PdfPCell cell = new PdfPCell(new Paragraph("Danh sách sản phẩm", font));
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
            table.addCell(cell);
            table.addCell(new Paragraph("STT", font));
            table.addCell(new Paragraph("Tên sản phẩm", font));
            table.addCell(new Paragraph("Số lượng", font));
            table.addCell(new Paragraph("Đơn giá", font));
            table.addCell(new Paragraph("Thành tiền", font));

            int count = 0;
            for (GioHangUserResponse hoaDonChiTiet : listHoaDonChiTiet) {
                count++;
                table.addCell(new Paragraph(String.valueOf(count + 1), font));
                table.addCell(new Paragraph(hoaDonChiTiet.getTenSanPham() + "/" + hoaDonChiTiet.getTenMauSac() + "/" + hoaDonChiTiet.getTenKichCo(), font));
                table.addCell(new Paragraph(hoaDonChiTiet.getSoLuong().toString(), font));
                table.addCell(new Paragraph(hoaDonChiTiet.getGia().toString(), font));
                BigDecimal gia = hoaDonChiTiet.getGia();
                int soLuong = hoaDonChiTiet.getSoLuong();
                BigDecimal tongTien1 = gia.multiply(BigDecimal.valueOf(soLuong));
                table.addCell(new Paragraph(String.valueOf(tongTien1), font));
            }

            document.add(table);
            document.add(new Paragraph("----------------------------------------------------------------------------------------------------------------------------------"));
            document.add(new Paragraph("Tổng tiền : " + tongTien, font));
            document.add(new Paragraph("----------------------------------------------------------------------------------------------------------------------------------"));
            document.add(new Paragraph("Cảm ơn quý khách đã mua hàng!", font));
            document.close();

            document.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
