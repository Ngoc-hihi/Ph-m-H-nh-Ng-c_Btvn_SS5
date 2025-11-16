-- GIỎI 7_SS5
CREATE TABLE ThanhToan (
    MaThanhToan INT PRIMARY KEY AUTO_INCREMENT,
    MaKhachHang INT,
    MaNhanVien INT,
    SoTien DECIMAL(10,2),
    NgayThanhToan DATE
);
INSERT INTO ThanhToan (MaKhachHang, MaNhanVien, SoTien, NgayThanhToan) VALUES
(1, 1, 15.00, '2005-08-02'),
(2, 2, 5.00, '2005-12-03'),
(3, 1, 12.00, '2005-05-10'),
(4, 3, 20.00, '2005-08-10'),
(5, 1, 0.00, '2005-08-13'),
(6, 3, 0.00, '2005-10-15'),
(7, 2, 8.00, '2005-08-18'),
(8, 1, 25.00, '2005-07-20');
SELECT MaKhachHang AS 'Mã khách hàng', SoTien AS 'Số tiền', NgayThanhToan AS 'Ngày thanh toán'
FROM ThanhToan
WHERE NgayThanhToan > '2005-08-01'
AND SoTien > 9.00
ORDER BY SoTien DESC;
SELECT MaThanhToan AS 'Mã giao dịch', 
       MaKhachHang AS 'Mã khách hàng', 
       MaNhanVien AS 'Mã nhân viên', 
       SoTien AS 'Số tiền'
FROM ThanhToan
WHERE SoTien = 0.00
OR ((MaNhanVien = 1 OR MaNhanVien = 3) AND SoTien > 10.00)

/* 
PHÂN TÍCH VÀ NHẬN ĐỊNH
Khách hàng VIP: 
Dựa vào kết quả Nhiệm vụ 1, nhóm khách hàng có các giao dịch lớn (amount > 9.00) là những khách hàng chi tiêu nhiều. 
Việc sắp xếp theo amount giảm dần giúp nhanh chóng xác định những khách hàng chi tiêu cao nhất, từ đó cửa hàng có thể xây dựng chương trình khuyến mãi hoặc ưu đãi riêng cho nhóm này.

Giao dịch Bất thường: 
Các giao dịch có amount = 0.00 có thể là kết quả của chương trình khuyến mãi, phiếu tặng, hoặc lỗi nhập liệu/hệ thống. 
Quản lý cửa hàng cần quan tâm để đảm bảo tính chính xác trong báo cáo doanh thu và đánh giá hiệu quả chương trình khuyến mãi.

Hiệu suất Nhân viên: 
Việc nhân viên staff_id = 1 xử lý các giao dịch giá trị cao có thể là dấu hiệu tốt về khả năng chăm sóc khách hàng hoặc xử lý các giao dịch quan trọng. 
Tuy nhiên, cần thêm thông tin như số lượng giao dịch tổng thể, tỷ lệ lỗi, thời gian xử lý trung bình để đánh giá chính xác hiệu suất thực sự của nhân viên này.
*/

-- GIỎI 8_SS5
CREATE TABLE ANNAHILL (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    store_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    address_id INT,
    active TINYINT(1) DEFAULT 1,
    create_date DATETIME,
    last_update DATETIME
);
INSERT INTO ANNAHILL (store_id, first_name, last_name, email, address_id) VALUES
(1, 'JENNIFER', 'SMITH', 'JENNIFER.SMITH@sakilacustomer.org', 1),
(1, 'JENNIFER', 'LEE', 'JENNIFER.LEE@sakilacustomer.org', 2),
(2, 'DAVID', 'BROWN', 'DAVID.BROWN@sakilacustomer.org', 3),
(2, 'ANNA', 'HILL', 'ANNA.HILL@sakilacustomer.org', 5),
(2, 'MICHAEL', 'WHITE', 'MICHAEL.WHITE@sakilacustomer.org', 4),
(1, 'EMILY', 'CLARK', 'EMILY.CLARK@sakilacustomer.org', 6),
(1, 'MARK', 'JOHNSON', 'MARK.JOHNSON@sakilacustomer.org', 7);
SET @ho = 'ANNA';
SET @ten = 'HILL';
SET @emailMoi = CONCAT(@ho, '.', @ten, '@sakilacustomer.org');
INSERT INTO ANNAHILL (store_id, first_name, last_name, email, address_id, active, create_date, last_update)
VALUES (2, @ho, @ten, @emailMoi, 5, 1, NOW(), NOW());
SELECT * FROM ANNAHILL WHERE email = @emailMoi;
UPDATE ANNAHILL
SET email = REPLACE(email, '@sakilacustomer.org', '@sakilacustomer.com'),
    last_update = NOW()
WHERE first_name = 'JENNIFER';
SELECT customer_id, first_name, email FROM ANNAHILL WHERE first_name = 'JENNIFER';
UPDATE ANNAHILL
SET active = 0,
    last_update = NOW()
WHERE customer_id = 25;
SELECT customer_id, first_name, last_name, active FROM ANNAHILL WHERE customer_id = 25;
/*
GIẢI THÍCH SOFT DELETE
Trong nhiều hệ thống kinh doanh, việc "đánh dấu" một bản ghi là không hoạt động (soft delete) thường được ưu tiên hơn xóa vĩnh viễn (hard delete) vì các lý do sau:
1. Bảo toàn lịch sử dữ liệu: Việc đánh dấu khách hàng không hoạt động giúp lưu trữ toàn bộ lịch sử giao dịch, mua hàng và tương tác của khách hàng. Điều này quan trọng để phân tích hành vi khách hàng, xây dựng báo cáo doanh thu, và đánh giá hiệu quả các chương trình marketing.
2. Khả năng phục hồi: Nếu khách hàng yêu cầu kích hoạt lại tài khoản hoặc phát hiện xóa nhầm, hệ thống có thể dễ dàng khôi phục dữ liệu mà không mất thông tin quan trọng. Hard delete sẽ làm mất toàn bộ thông tin và giao dịch liên quan.
Ngoài ra, soft delete giúp tránh lỗi ràng buộc dữ liệu (FK constraints) trong các bảng liên quan, vì bản ghi vẫn tồn tại nhưng không hoạt động.
*/

-- XUẤT SẮC 9_SS5
CREATE TABLE Phimm (
    film_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    rating VARCHAR(10),
    length INT,
    rental_rate DECIMAL(5,2),
    original_rental_rate DECIMAL(5,2),
    last_update DATETIME
);
INSERT INTO Phimm (title, rating, length, rental_rate, last_update) VALUES
('Bộ phim A', 'PG', 120, 3.50, NOW()),
('Bộ phim B', 'G', 130, 4.00, NOW()),
('Bộ phim C', 'PG-13', 110, 3.00, NOW()),
('Bộ phim D', 'R', 95, 2.50, NOW()),
('Bộ phim E', 'PG', 105, 2.99, NOW()),
('Bộ phim F', 'G', 150, 3.50, NOW()),
('Bộ phim G', 'PG', 90, 3.00, NOW());
SELECT film_id, title, rating, length, rental_rate
FROM Phimm
WHERE (rating = 'PG' OR rating = 'G')
  AND length > 100
  AND rental_rate >= 2.99
ORDER BY rental_rate DESC;
UPDATE Phimm
SET original_rental_rate = rental_rate
WHERE (rating = 'PG' OR rating = 'G')
  AND length > 100
  AND rental_rate >= 2.99;
UPDATE Phimm
SET rental_rate = rental_rate / 2,
    last_update = NOW()
WHERE (rating = 'PG' OR rating = 'G')
  AND length > 100
  AND original_rental_rate IS NOT NULL;
SELECT film_id, title, rating, length, original_rental_rate, rental_rate
FROM Phimm
ORDER BY rental_rate DESC;
/*
KẾ HOẠCH HOÀN TÁC VÀ PHÂN TÍCH RỦI RO
Rủi ro: 
- Nếu câu lệnh UPDATE được chạy mà không có mệnh đề WHERE hoặc mệnh đề WHERE sai, toàn bộ bảng film có thể bị giảm giá, không chỉ các phim mục tiêu. 
- Hậu quả: Doanh thu từ thuê phim sẽ giảm mạnh, làm ảnh hưởng trực tiếp đến lợi nhuận, gây khó khăn trong việc đo lường hiệu quả chiến dịch khuyến mãi.
Kế hoạch Hoàn tác (Rollback Plan):
-- Giả sử đã chạy UPDATE và cần khôi phục giá thuê ban đầu:
-- Câu lệnh này nhân ngược lại rental_rate đã giảm để trở về giá cũ
UPDATE sakila.film
SET rental_rate = rental_rate * 2
WHERE (rating = 'PG' OR rating = 'G')
  AND length > 100
  AND rental_rate < 2.99; -- rental_rate hiện tại là những phim đã giảm giá
- Việc có kế hoạch hoàn tác là cần thiết để đảm bảo an toàn dữ liệu, giảm thiểu rủi ro và giúp hệ thống duy trì tính ổn định trong các chiến dịch cập nhật dữ liệu hàng loạt.
Đề xuất Cải tiến:
1. Thêm cột mới original_rental_rate để lưu giá gốc trước khi cập nhật:
   ALTER TABLE sakila.film ADD COLUMN original_rental_rate DECIMAL(4,2) AFTER rental_rate;
   -- Trước khi UPDATE, copy giá trị rental_rate sang original_rental_rate:
   UPDATE sakila.film
   SET original_rental_rate = rental_rate
   WHERE (rating = 'PG' OR rating = 'G')
     AND length > 100
     AND rental_rate >= 2.99;
2. Lợi ích: Nếu cần hoàn tác, chỉ cần dùng original_rental_rate mà không cần tính toán nhân/chia, tránh sai sót và dễ kiểm soát chiến dịch hơn.
*/

-- BTTH

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(255),
    Email VARCHAR(255),
    RegistrationDate DATE,
    City VARCHAR(100),
    Status VARCHAR(50) -- Ví dụ: 'Active', 'Inactive', 'Potential'
);
INSERT INTO Customers (CustomerID, FullName, Email, RegistrationDate, City, Status) VALUES
(1, 'Nguyen Van An', 'an.nguyen@email.com', '2023-01-15', 'Ho Chi Minh', 'Active'),
(2, 'Tran Thi Ba', 'ba.tran@email.com', '2023-02-20', 'Hanoi', 'Active'),
(3, 'Le Van Cuong', 'cuong.le@email.com', '2023-02-25', 'Da Nang', 'Inactive'),
(4, 'Pham Thi Dung', 'dung.pham@email.com', '2023-03-10', 'Hanoi', 'Potential'),
(5, 'Hoang Van Em', 'em.hoang@email.com', '2023-04-01', 'Ho Chi Minh', 'Active');
-- Nhiệm vụ 1
INSERT INTO Customers (CustomerID, FullName, Email, RegistrationDate, City, Status)
VALUES (6, 'Lý Thị Giang', 'giang.ly@email.com', '2023-05-20', 'Cần Thơ', 'Potential');
-- Nhiệm vụ 2
SELECT FullName, Email
FROM Customers;
SELECT DISTINCT City
FROM Customers;
SELECT *
FROM Customers
ORDER BY RegistrationDate DESC;
SELECT *
FROM Customers
WHERE City = 'Hanoi';
SELECT *
FROM Customers
WHERE City = 'Ho Chi Minh'
  AND Status = 'Active';
-- Nhiệm vụ 3
UPDATE Customers
SET Status = 'Active'
WHERE CustomerID = 3;
SELECT *
FROM Customers
WHERE CustomerID = 3;
DELETE FROM Customers
WHERE CustomerID = 4;